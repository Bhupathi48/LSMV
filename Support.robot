*** Settings ***
Documentation    Imports libraries and gets the setup ready for execution.
Library           SeleniumLibrary
Library           Screenshot
Library           ../Library/BrowserSupport.py
Library           ../Library/Exceldata.py
Library           ../Library/Dates_manipulator.py
Library           ../Library/user_testdata_xml_file.py
Library           ../Library/utility.py
Library           RequestsLibrary
Library           json
Library           OperatingSystem
Library           String
Library           Process
Library           Collections
Library           DateTime
Library           BuiltIn
Library           openpyxl
Library           ../Resource/get_free_username.py
Library           ../Library/PrimeNGSupport.py
Resource          Web/Support_Web.robot
Resource          Web/POC/Common_support.robot
Resource          Web/POC/Auto_Cal/Auto_Cal_Keywords.robot
Resource          Web/POC/Validator/Validator_Keywords.robot

*** Keywords ***
Set up screenshot directory
    Create directory  ${OUTPUTDIR}${/}${wvar('screenshot_dir')}

Take Screenshot
    [Arguments]    ${module}
    [Documentation]    Expects arguments as Selenium or Appium to control which type of 
    ...    screenshot to take for the action
    Run Keyword If		${screenshot_taking}    Take a Screenshot  ${module}

Take a Screenshot
    [Arguments]    ${module}
    ${Result}=  Run Keyword And Return Status  Take ${module} screenshot at Test Level
    Run Keyword If	${Result}==${False}  Take ${module} Screenshot at Suite Level
    Run Keyword If	${Result}==${False}  Take ${module} Screenshot at Test Level 
	Add to screenshot count

Take Selenium Screenshot at Test Level
    Capture page screenshot  ${OUTPUTDIR}${/}${wvar('screenshot_dir')}${/}${TEST NAME}_${screenshotCount}.png

Take Fail Screenshot at Test Level
    ${Test_failed_msg}=    Set Variable    Failed Test Case
    Capture page screenshot  ${OUTPUTDIR}${/}${wvar('screenshot_dir')}${/}${Test_failed_msg}_${screenshotCount}.png

Take Selenium Screenshot at Suite Level
    Capture page screenshot  ${OUTPUTDIR}${/}${wvar('screenshot_dir')}${/}${SUITE NAME}_${screenshotCount}.png

Take Fail Screenshot at Suite Level
    ${Test_failed_msg}=    Set Variable    Failed Test Case
    Capture page screenshot  ${OUTPUTDIR}${/}${wvar('screenshot_dir')}${/}${Test_failed_msg}_${screenshotCount}.png

Take Appium Screenshot at Test Level
    Capture page screenshot  ${OUTPUTDIR}${/}${mvar('screenshot_dir')}${/}${TEST NAME}_${screenshotCount}.png

Take Appium Screenshot at Suite Level
    Capture page screenshot  ${OUTPUTDIR}${/}${mvar('screenshot_dir')}${/}${SUITE NAME}_${screenshotCount}.png

Add to screenshot count
    ${current_counter}=     evaluate    int("${screenshotCount}".rsplit("_", 1)[1])+1
	${screenshotCount}=  Set variable  ${PABOTQUEUEINDEX}_${current_counter}
	Set global variable  ${screenshotCount}

Reset screenshot count variable
	${screenshotCount}=  Set variable  ${PABOTQUEUEINDEX}_1
	Set global variable  ${screenshotCount}
	Set up screenshot directory
	
Turn Screenhots Off
    Set global variable  ${screenshot_taking}  ${FALSE}

Turn Screenhots On
    Set global variable  ${screenshot_taking}  ${TRUE}

Setup linux execution
    ${web_test_check}=      Run Keyword and Return Status    Variable Should Exist       ${web_test}
    Run keyword if      ${web_test_check}     Setup Docker Execution Options

Log file to report 
    [Arguments]    ${filepath}
	Log	<msg src="${filepath}">img src="${filepath}"</msg>	HTML

Update test log information
    [Arguments]     ${update_dictionary}
    ${test_data_dict}=     get variable value  ${test_data_dict}     ${None}
    ${test_data_dict}=  Run Keyword If   ${test_data_dict}==${None}   get variable value  ${update_dictionary}     ${None}
    ...     ELSE    Add values to test data dict  ${update_dictionary}  ${test_data_dict}
    set test variable    ${test_data_dict}

Add values to test data dict
    [Arguments]         ${update_dictionary}        ${test_data_dict}
    FOR    ${key}   IN    @{update_dictionary.keys()}
        Run Keyword if    ${test_data_dict}["${key}"]        Set variable    ${test_data_dict}["${key}"]
             ${test_data_dict}["${key}"]:${update_arguments}["${key}"]
        ELSE    ${test_data_dict}["${key}"]    Set variable      ${update_arguments}["${key}"]
    END
    Return  ${test_data_dict}

Log Test Iteration Result To PDF
    [Arguments]    ${test_name}    ${status}
    ${color}=    Run Keyword If    '${status}'=='PASS'    Set Variable    green    ELSE    Set Variable    red
    # Log	<msg src="${filepath}">img src="${filepath}"</msg>	HTML
    Log    <msg style="color:${color}">img Test: ${test_name} - ${status}</msg>	HTML


Highlight WebElement
    [Arguments]     ${element_xpath_or_id}
    ${element}=    Get WebElement    ${element_xpath_or_id}
    Execute Javascript    arguments[0].style.setProperty('border', '4px solid red', 'important');     ARGUMENTS    ${element}
    Sleep    1

UnHighlight WebElement
    [Arguments]     ${element_xpath_or_id}
    ${element}=    Get WebElement    ${element_xpath_or_id}
    Execute Javascript    arguments[0].removeAttribute('style','border: solid 4px red');     ARGUMENTS    ${element}    
    Sleep    1