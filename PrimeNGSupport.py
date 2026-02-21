"""PrimeNG UI component helper keywords for Robot Framework.

Provides a resilient keyword to click (toggle) PrimeNG p-checkbox widgets
handling common issues: hidden native input, overlays, scrolling, animation
delays, and fallback to JavaScript click & synthetic events.

Usage in a .robot file:

    Library    SeleniumLibrary
    Library    LSMV/Library/PrimeNGSupport.py

    *** Test Cases ***
    Select Example Checkbox
        Click PrimeNG Checkbox    row_text=Example Row Label

Keyword parameters:
    locator      Optional explicit locator to the visible checkbox box element
                 (e.g. //p-checkbox//div[contains(@class,'p-checkbox-box')])
    row_text     Text contained in a row <tr>/<td> used to derive a relative locator
    index        1-based index when multiple checkboxes match within the row or page
    desired_state  true/false (string or boolean) for target checked state
    timeout      Max seconds to wait for element presence

Precedence: if locator provided it is used; else if row_text provided we build an
            XPath using it; else we default to the first p-checkbox on the page.
"""

from __future__ import annotations

from typing import Optional, Union
from robot.api import logger
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


def _get_selenium_library():
    return BuiltIn().get_library_instance('SeleniumLibrary')


class PrimeNGSupport:
    """Robot Framework library for PrimeNG helpers."""

    @keyword("Click PrimeNG Checkbox")
    def click_primeng_checkbox(
        self,
        locator: Optional[str] = None,
        row_text: Optional[str] = None,
        index: Union[int, str] = 1,
        desired_state: Union[bool, str] = True,
        timeout: Union[int, float, str] = 10,
    ):
        """Click (toggle) a PrimeNG p-checkbox to reach desired_state.

        One of (locator | row_text) may be supplied. If neither is given the first
        checkbox on the page is targeted.
        desired_state accepts true/false (any case) or boolean.
        """
        sl = _get_selenium_library()

        # Normalize desired_state to string 'true'/'false'
        if isinstance(desired_state, str):
            desired_state_norm = desired_state.strip().lower() in ("true", "1", "yes", "y")
        else:
            desired_state_norm = bool(desired_state)
        desired_str = "true" if desired_state_norm else "false"

        # Build locator if not explicitly provided
        if not locator:
            if row_text:
                # Row text locator: finds a tr containing the text anywhere in its td descendants
                locator = (
                    f"(//tr[.//td[contains(normalize-space(.), "
                    f"'{row_text.strip()}')]]//p-checkbox//div[contains(@class,'p-checkbox-box')])[{index}]"
                )
            else:
                locator = f"(//p-checkbox//div[contains(@class,'p-checkbox-box')])[{index}]"

        logger.info(f"[PrimeNGSupport] Target checkbox box locator: {locator}")

        # Wait for element presence
        sl.wait_until_page_contains_element(locator, timeout=timeout)

        # Best-effort: scroll into view (ignore failures if not supported)
        try:
            sl.scroll_element_into_view(locator)
        except Exception as e:  # noqa: BLE001 - non-fatal
            logger.debug(f"Scroll ignored: {e}")

        # Hidden input relative to box: ancestor p-checkbox then input descendant
        hidden_input_xpath = locator + "//ancestor::p-checkbox//input[@type='checkbox']"

        def _get_state() -> Optional[str]:
            try:
                return sl.get_element_attribute(hidden_input_xpath, "aria-checked")
            except Exception:  # noqa: BLE001
                return None

        # Quick exit if already at desired state
        current = _get_state()
        if current == desired_str:
            logger.info(
                f"[PrimeNGSupport] Checkbox already in desired state ({desired_str}); no action taken."
            )
            return

        driver = sl.driver

        # Retry normal Selenium clicks
        attempts = 4
        for i in range(1, attempts + 1):
            current = _get_state()
            if current == desired_str:
                logger.info(
                    f"[PrimeNGSupport] Achieved desired state '{desired_str}' after {i-1} attempts."
                )
                return
            try:
                logger.debug(f"[PrimeNGSupport] Attempt {i}: clicking via Selenium.")
                sl.click_element(locator)
            except Exception as e:  # noqa: BLE001
                logger.debug(f"[PrimeNGSupport] Selenium click attempt {i} failed: {e}")
            sl.sleep(0.2)

        # Fallback: JavaScript click
        try:
            logger.info("[PrimeNGSupport] Falling back to JavaScript click.")
            element = sl.find_element(locator)
            driver.execute_script("arguments[0].click();", element)
            sl.sleep(0.2)
        except Exception as e:  # noqa: BLE001
            logger.warn(f"[PrimeNGSupport] JS click failed: {e}")

        # Final fallback: dispatch synthetic events sequence if still not toggled
        if _get_state() != desired_str:
            try:
                logger.info("[PrimeNGSupport] Dispatching synthetic mouse events fallback.")
                element = sl.find_element(locator)
                driver.execute_script(
                    "var el=arguments[0];['mousedown','mouseup','click'].forEach(function(t){el.dispatchEvent(new MouseEvent(t,{bubbles:true,view:window}));});",
                    element,
                )
                sl.sleep(0.2)
            except Exception as e:  # noqa: BLE001
                logger.warn(f"[PrimeNGSupport] Synthetic events failed: {e}")

        final_state = _get_state()
        if final_state != desired_str:
            # Gather diagnostic info
            try:
                box_el = sl.find_element(locator)
                rect = driver.execute_script(
                    "var r=arguments[0].getBoundingClientRect();return r.width+'x'+r.height+'@'+r.top+','+r.left;",
                    box_el,
                )
            except Exception:
                rect = "?"
            raise AssertionError(
                f"Checkbox state did not become {desired_str}. Current={final_state}. Locator={locator}. Rect={rect}"
            )
        logger.info(f"[PrimeNGSupport] Checkbox successfully set to {desired_str}.")

    @keyword("Get Pseudo Element Content")
    def get_pseudo_element_content(self, locator: str, pseudo: str = '::before') -> str:
        """Return the CSS 'content' value of a pseudo-element (::before/::after) for the element at locator.

        Strips wrapping single or double quotes that browsers commonly include.

        Example (Robot):
            ${content}=    Get Pseudo Element Content    //label[@for='email']    ::before
            Should Be Equal    ${content}    *
        """
        sl = _get_selenium_library()
        element = sl.find_element(locator)
        # Execute JS to get computed style content
        try:
            raw = sl.driver.execute_script(
                "return window.getComputedStyle(arguments[0], arguments[1]).getPropertyValue('content');",
                element,
                pseudo,
            )
        except Exception as e:  # noqa: BLE001
            raise AssertionError(f"Unable to retrieve pseudo-element content for {locator} {pseudo}: {e}")
        if raw is None:
            return ""
        raw = str(raw).strip()
        # Remove leading/trailing quotes (", ')
        if (raw.startswith('"') and raw.endswith('"')) or (raw.startswith("'") and raw.endswith("'")):
            raw = raw[1:-1]
        logger.info(f"[PrimeNGSupport] Pseudo-element {pseudo} content for {locator}: {raw}")
        return raw

    @keyword("JS Toggle PrimeNG Checkbox")
    def js_toggle_primeng_checkbox(
        self,
        locator: str | None = None,
        row_text: str | None = None,
        index: int | str = 1,
        desired_state: bool | str = True,
        timeout: int | float | str = 10,
    ):
        """Force-toggle a PrimeNG p-checkbox to desired_state using JavaScript only.

        This bypasses Selenium's native click (useful when ElementNotInteractable or overlays
        intercept the click) while still attempting to fire realistic event sequences to keep
        Angular/PrimeNG model state in sync.

        Parameters mirror Click PrimeNG Checkbox (locator/row_text/index/desired_state/timeout).
        """
        sl = _get_selenium_library()

        # Normalize desired state
        if isinstance(desired_state, str):
            want_bool = desired_state.strip().lower() in ("true", "1", "yes", "y")
        else:
            want_bool = bool(desired_state)

        # Build locator if not provided
        if not locator:
            if row_text:
                locator = (
                    f"(//tr[.//td[contains(normalize-space(.), '{row_text.strip()}')]]"
                    f"//p-checkbox//div[contains(@class,'p-checkbox-box')])[{index}]"
                )
            else:
                locator = f"(//p-checkbox//div[contains(@class,'p-checkbox-box')])[{index}]"

        logger.info(f"[PrimeNGSupport][JS] Target checkbox locator: {locator}")
        sl.wait_until_page_contains_element(locator, timeout=timeout)
        try:
            sl.scroll_element_into_view(locator)
        except Exception:  # noqa: BLE001
            pass

        element = sl.find_element(locator)
        driver = sl.driver

        script = r"""
            const box = arguments[0];
            const want = arguments[1];
            if(!box){return {success:false, reason:'No box element'};}
            const host = box.closest('p-checkbox');
            if(!host){return {success:false, reason:'No p-checkbox ancestor'};}
            const input = host.querySelector('input[type="checkbox"]');
            if(!input){return {success:false, reason:'No hidden input'};}
            function getState(){ return input.getAttribute('aria-checked') === 'true'; }
            const initial = getState();
            if(initial === want){
                return {success:true, final:getState(), path:'already'};
            }
            // Try normal synthetic click sequence on visible box
            ['mousedown','mouseup','click'].forEach(t=>box.dispatchEvent(new MouseEvent(t,{bubbles:true,view:window})));
            if(getState() === want){
                return {success:true, final:getState(), path:'box-events'};
            }
            // Try direct input click (sometimes triggers framework binding)
            try { input.click(); } catch(e) {}
            if(getState() === want){
                return {success:true, final:getState(), path:'input-click'};
            }
            // Force update: adjust aria + property + dispatch change/input events
            input.setAttribute('aria-checked', want ? 'true':'false');
            input.checked = !!want; // in case framework inspects .checked
            input.dispatchEvent(new Event('input', {bubbles:true}));
            input.dispatchEvent(new Event('change', {bubbles:true}));
            return {success: getState() === want, final:getState(), path:'forced'};
        """

        result = driver.execute_script(script, element, want_bool)
        logger.info(f"[PrimeNGSupport][JS] Toggle result: {result}")
        final_state = result.get('final')
        if final_state != want_bool:
            raise AssertionError(
                f"JS toggle failed. Desired={want_bool} Final={final_state} Locator={locator} Detail={result}"
            )
        logger.info(
            f"[PrimeNGSupport][JS] Checkbox state now {final_state} via path {result.get('path')}"
        )

    @keyword("JS Toggle PrimeNG Radio Button")
    def js_toggle_primeng_radio_button(
        self,
        radio_group_name: str,
        option: Union[str, int],
        locator: Optional[str] = None,
        timeout: Union[int, float, str] = 10,
    ):
        """Select a PrimeNG radio button using JavaScript only.

        This bypasses Selenium's native click issues while maintaining Angular/PrimeNG 
        model state synchronization for radio button groups.

        Args:
            radio_group_name: The 'name' attribute of the radio button group
            option: The option to select - can be:
                    - "Yes" or 1 (selects value="1")
                    - "No" or 2 (selects value="2") 
                    - "Clear" or "" (selects the hidden clear option value="")
            locator: Optional specific locator override
            timeout: Maximum seconds to wait for element

        Returns:
            None (raises AssertionError on failure)
        """
        sl = _get_selenium_library()
        
        # Normalize option to value
        if str(option).lower() in ["yes", "1"]:
            target_value = "1"
            option_name = "Yes"
        elif str(option).lower() in ["no", "2"]:
            target_value = "2" 
            option_name = "No"
        elif str(option).lower() in ["clear", "", "blank"]:
            target_value = ""
            option_name = "Clear"
        else:
            raise ValueError(f"Invalid option: {option}. Use 'Yes', 'No', '1', '2', 'Clear', or ''")

        # Build locator if not provided
        if not locator:
            if target_value == "":
                # For clear option, target the hidden radio button
                locator = f"//input[@type='radio'][@name='{radio_group_name}'][@value='']"
            else:
                # For Yes/No options, target the visible radio button box
                locator = f"//input[@type='radio'][@name='{radio_group_name}'][@value='{target_value}']/../../div[@class='p-radiobutton-box']"

        logger.info(f"[PrimeNGSupport][JS Radio] Target locator: {locator}")
        logger.info(f"[PrimeNGSupport][JS Radio] Selecting option: {option_name} (value='{target_value}')")
        
        # Wait for element presence
        sl.wait_until_page_contains_element(locator, timeout=timeout)
        
        # Scroll into view (best effort)
        try:
            sl.scroll_element_into_view(locator)
        except Exception:  # noqa: BLE001
            pass

        element = sl.find_element(locator)
        driver = sl.driver

        # JavaScript radio button selection script
        script = r"""
            const target = arguments[0];
            const targetValue = arguments[1];
            const radioGroupName = arguments[2];
            
            if (!target) {
                return {success: false, reason: 'No target element found'};
            }
            
            // Find the radio group by name
            const allRadiosInGroup = document.querySelectorAll(`input[type="radio"][name="${radioGroupName}"]`);
            if (allRadiosInGroup.length === 0) {
                return {success: false, reason: `No radio buttons found with name: ${radioGroupName}`};
            }
            
            // Find the specific radio button we want to select
            let targetRadio = null;
            for (let radio of allRadiosInGroup) {
                if (radio.value === targetValue) {
                    targetRadio = radio;
                    break;
                }
            }
            
            if (!targetRadio) {
                return {success: false, reason: `No radio button found with value: ${targetValue}`};
            }
            
            // Check if already selected
            if (targetRadio.checked) {
                return {success: true, final: targetValue, path: 'already-selected'};
            }
            
            // Method 1: Try clicking the visible radio button box
            const radioBox = targetRadio.closest('.p-radiobutton').querySelector('.p-radiobutton-box');
            if (radioBox) {
                try {
                    ['mousedown', 'mouseup', 'click'].forEach(eventType => {
                        radioBox.dispatchEvent(new MouseEvent(eventType, {
                            bubbles: true, 
                            view: window
                        }));
                    });
                    
                    if (targetRadio.checked) {
                        return {success: true, final: targetValue, path: 'box-click'};
                    }
                } catch(e) {
                    console.log('Box click failed:', e);
                }
            }
            
            // Method 2: Try direct input click
            try {
                targetRadio.click();
                if (targetRadio.checked) {
                    return {success: true, final: targetValue, path: 'input-click'};
                }
            } catch(e) {
                console.log('Input click failed:', e);
            }
            
            // Method 3: Force selection with events
            try {
                // Uncheck all other radios in the group first
                allRadiosInGroup.forEach(radio => {
                    if (radio !== targetRadio) {
                        radio.checked = false;
                        radio.removeAttribute('checked');
                    }
                });
                
                // Select target radio
                targetRadio.checked = true;
                targetRadio.setAttribute('checked', 'checked');
                
                // Fire events to notify Angular/PrimeNG
                targetRadio.dispatchEvent(new Event('change', {bubbles: true}));
                targetRadio.dispatchEvent(new Event('input', {bubbles: true}));
                
                // Update visual states
                allRadiosInGroup.forEach(radio => {
                    const radioComponent = radio.closest('.p-radiobutton');
                    if (radioComponent) {
                        if (radio.checked) {
                            radioComponent.classList.add('p-radiobutton-checked');
                            const box = radioComponent.querySelector('.p-radiobutton-box');
                            if (box) box.classList.add('p-highlight');
                        } else {
                            radioComponent.classList.remove('p-radiobutton-checked');
                            const box = radioComponent.querySelector('.p-radiobutton-box');
                            if (box) box.classList.remove('p-highlight');
                        }
                    }
                });
                
                return {
                    success: targetRadio.checked, 
                    final: targetRadio.checked ? targetValue : 'none', 
                    path: 'forced'
                };
            } catch(e) {
                return {success: false, reason: `Force selection failed: ${e.message}`};
            }
        """

        # Execute the radio button selection script
        result = driver.execute_script(script, element, target_value, radio_group_name)
        logger.info(f"[PrimeNGSupport][JS Radio] Selection result: {result}")
        
        if not result.get('success'):
            raise AssertionError(
                f"Radio button selection failed. Target value: {target_value} "
                f"Group: {radio_group_name} Detail: {result}"
            )
        
        logger.info(f"[PrimeNGSupport][JS Radio] Radio button '{option_name}' selected successfully via {result.get('path')}")

    @keyword("Select Emergency Department Radio")
    def select_emergency_department_radio(self, option: str, timeout: Union[int, float, str] = 10):
        """Select Emergency Department radio button (Yes/No/Clear).
        
        Args:
            option: "Yes", "No", or "Clear"
            timeout: Maximum seconds to wait for element
        """
        self.js_toggle_primeng_radio_button(
            radio_group_name="adverseEventNew:reactionPanelTable:departmentundefined0",
            option=option,
            timeout=timeout
        )

    @keyword("Select Healthcare Professional Radio")
    def select_healthcare_professional_radio(self, option: str, timeout: Union[int, float, str] = 10):
        """Select Doctor/healthcare professional office radio button (Yes/No/Clear).
        
        Args:
            option: "Yes", "No", or "Clear"
            timeout: Maximum seconds to wait for element
        """
        self.js_toggle_primeng_radio_button(
            radio_group_name="adverseEventNew:reactionPanelTable:healthcareProfessionalundefined0",
            option=option,
            timeout=timeout
        )

    @keyword("Get Radio Button State")
    def get_radio_button_state(self, radio_group_name: str, timeout: Union[int, float, str] = 10):
        """Get the current state of a radio button group.
        
        Args:
            radio_group_name: The 'name' attribute of the radio button group
            timeout: Maximum seconds to wait for elements
            
        Returns:
            dict: Contains selected_value, selected_label, and all_options
        """
        sl = _get_selenium_library()
        driver = sl.driver
        
        script = """
            const radioGroupName = arguments[0];
            const allRadios = document.querySelectorAll(`input[type="radio"][name="${radioGroupName}"]`);
            
            let selectedValue = null;
            let selectedLabel = null;
            let allOptions = [];
            
            allRadios.forEach(radio => {
                const label = radio.closest('.p-radiobutton').querySelector('.p-radiobutton-label');
                const labelText = label ? label.textContent.trim() : radio.value;
                
                allOptions.push({
                    value: radio.value,
                    label: labelText,
                    checked: radio.checked
                });
                
                if (radio.checked) {
                    selectedValue = radio.value;
                    selectedLabel = labelText;
                }
            });
            
            return {
                selected_value: selectedValue,
                selected_label: selectedLabel,
                all_options: allOptions,
                total_options: allOptions.length
            };
        """
        
        try:
            # Wait for at least one radio button to be present
            locator = f"//input[@type='radio'][@name='{radio_group_name}']"
            sl.wait_until_page_contains_element(locator, timeout=timeout)
            
            result = driver.execute_script(script, radio_group_name)
            logger.info(f"[PrimeNGSupport][Radio State] Group '{radio_group_name}' state: {result}")
            return result
        except Exception as e:
            logger.warn(f"[PrimeNGSupport][Radio State] Error getting radio button state: {e}")
            raise AssertionError(f"Failed to get radio button state for group '{radio_group_name}': {e}")

    # -------------------------- Scrolling Utilities ---------------------------
    @keyword("Scroll To Page Bottom")
    def scroll_to_page_bottom(
        self,
        attempts: int | str = 1,
        pause: float | str = 0.3,
        ensure_stable: bool | str = True,
        use_keyboard: bool | str = False,
    ):
        """Scroll the window to the bottom of the document.

        attempts: number of times to attempt further scrolling (use >1 for lazy / infinite scroll pages)
        pause: seconds to wait between attempts for new content to load
        ensure_stable: if true, stops early when scroll height no longer increases
        use_keyboard: if true, sends END key each attempt in addition to JS scroll (fallback)
        """
        sl = _get_selenium_library()
        driver = sl.driver

        attempts_i = int(attempts)
        pause_f = float(pause)
        ensure_stable_b = (str(ensure_stable).lower() in ("true", "1", "yes", "y"))
        use_keyboard_b = (str(use_keyboard).lower() in ("true", "1", "yes", "y"))

        prev_height = -1
        for i in range(1, attempts_i + 1):
            try:
                height = driver.execute_script("return Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);")
            except Exception:
                height = None
            driver.execute_script("window.scrollTo(0, document.documentElement.scrollHeight || document.body.scrollHeight || 0);")
            if use_keyboard_b:
                try:
                    sl.press_keys("xpath=//body", "END")
                except Exception:
                    pass
            sl.sleep(pause_f)
            try:
                new_height = driver.execute_script("return Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);")
            except Exception:
                new_height = None
            logger.info(
                f"[PrimeNGSupport][Scroll] Attempt {i}: height before={height} after={new_height} prev_recorded={prev_height}"
            )
            if ensure_stable_b and new_height is not None and prev_height != -1 and new_height == prev_height:
                logger.info("[PrimeNGSupport][Scroll] Scroll height stable; stopping early.")
                break
            if new_height is not None:
                prev_height = new_height

    @keyword("Scroll To Page Top")
    def scroll_to_page_top(self):
        """Scroll to the very top of the page."""
        sl = _get_selenium_library()
        driver = sl.driver
        driver.execute_script("window.scrollTo(0,0);")
        try:
            sl.press_keys("xpath=//body", "HOME")
        except Exception:
            pass

    @keyword("Scroll Until Element Visible")
    def scroll_until_element_visible(
        self,
        element_locator: str,
        max_attempts: int | str = 15,
        step: int | str = 800,
        pause: float | str = 0.25,
        final_scroll_into_view: bool | str = True,
    ):
        """Progressively scroll down until element_locator is visible or max_attempts reached.

        step: pixel distance per scroll increment (JS window.scrollBy)
        final_scroll_into_view: perform a precise scrollElementIntoView when found.
        """
        sl = _get_selenium_library()
        driver = sl.driver
        attempts = int(max_attempts)
        step_i = int(step)
        pause_f = float(pause)
        final_b = (str(final_scroll_into_view).lower() in ("true", "1", "yes", "y"))

        for i in range(1, attempts + 1):
            # Check presence & displayed state
            found = False
            try:
                webelement = sl.find_element(element_locator)
                displayed = webelement.is_displayed()
                if displayed:
                    found = True
            except Exception:
                found = False
            if found:
                logger.info(f"[PrimeNGSupport][Scroll] Element visible after {i-1} scrolls.")
                if final_b:
                    try:
                        sl.scroll_element_into_view(element_locator)
                    except Exception:
                        pass
                return
            # Scroll further
            driver.execute_script(f"window.scrollBy(0,{step_i});")
            sl.sleep(pause_f)
        raise AssertionError(
            f"Element '{element_locator}' not visible after {attempts} scroll attempts (step {step_i})."
        )


__all__ = ["PrimeNGSupport"]
