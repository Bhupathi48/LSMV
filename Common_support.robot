*** Settings ***
Documentation     Executes web based tests.
...               Keywords created are based on http://robotframework.org/
# Library    XML
Resource        ../../../Tests/Support.robot
Resource        ../POC/Support_Web_File.robot

*** Variables ***
${web_test}=      True
${lsr_username}      GSSAUTOMATIONSITSBX040
${lsr_password}      Password@1234


*** Keywords ***
Get Dynamic Username And Password
    [Documentation]    Get dynamic username and password from the username pool
    [Arguments]    ${agent_name}    ${test_case_id}
    # ${credentials}=    Get Free Username    agent_name=${agent_name}    credentials_path=${EXECDIR}${/}Resource${/}Username.json    test_name=${test_case_id}
    ${credentials}=    Get Free Username    agent_name=${agent_name}    credentials_path=${EXECDIR}/Data/Web/${user_test_server}/Username.json    test_name=${test_case_id}
    ${username}=    Get From Dictionary    ${credentials}    username
    ${password}=    Get From Dictionary    ${credentials}    password
    Log    Allocated username: ${username} for test: ${test_case_id} and agent: ${agent_name}    console=True
    RETURN    ${username}    ${password}

Release Dynamic Username And Password
    [Documentation]    Release the username back to the pool after test completion
    [Arguments]    ${agent_name}    ${test_case_id}
    Release Username    agent_name=${agent_name}    credentials_path=${EXECDIR}/Data/Web/${user_test_server}/Username.json    test_name=${test_case_id}
    Log    Released username for test: ${test_case_id} and agent: ${agent_name}    console=True

Read Test Data From Excel For RCT
    [Documentation]    Read test data from the Excel file for the specified RCT
    [Arguments]    ${Test Case ID}
    ${project_folder}=    Set Variable    ${EXECDIR}${/}Resource${/}TestData_Excels${/}
    ${excel_file}=    Set Variable    ${project_folder}${wvar('workbook')}
    ${sheet_name}=    Set Variable    ${wvar('sheet')}
    ${Column_name}=    Set Variable     Test Case ID
    ${result}=    Connect And Read Specific Column and Row Value From Sheet     ${excel_file}    ${sheet_name}    ${Column_name}    ${Test Case ID}
    Log    ${result}
    Log    ${TEST_TAGS}    
    Set Test Variable    ${Tag}    ${result['Tags']}
    Set Global Variable    ${test_case_id}      ${result['Test Case ID']}
    Set Global Variable    ${scenario_sheet_name}   ${result['Scenario Name']}
    Set Test Variable    ${username_value}    ${result['Username']}
    Set Test Variable    ${password_value}    ${result['Password']}
    Set Test Variable    ${company_unit_value}    ${result['Company_Unit']}
    Set Test Variable    ${sender_organ_value}    ${result['Sender_Organization_as_Coded']}
    Set Test Variable    ${latest_receview_date}  ${result['Latest_Received_Date']}
    Set Test Variable    ${report_type}           ${result['Report_Type']}
    Set Test Variable    ${primary_source_country_val}  ${result['Primary_Source_Country']}
    Set Test Variable    ${cases_signification_val}  ${result['Case_Significance']}
    Set Test Variable    ${first_name_value}     ${result['First_Name']}
    Set Test Variable    ${last_name_value}     ${result['Last_Name']}
    Set Test Variable    ${country_value}     ${result['Country']}
    Set Test Variable    ${qualification_value}     ${result['Qualification']}
    Set Test Variable    ${consent_to_contact_value}     ${result['Consent_to_Contact']}
    Set Test Variable    ${regional_state_value}     ${result['Regional_State']}
    Set Test Variable    ${patient_id_value}     ${result['Patient_ID']}
    Set Test Variable    ${age_group_value}     ${result['Age_Group']}
    Set Test Variable    ${sex_value}     ${result['Sex']}
    Set Test Variable    ${product_descrip_value}     ${result['Product_description']}
    Set Test Variable    ${action_taken_with_drug_value}     ${result['Action_Taken_With_Drug']}
    Set Test Variable    ${indication_value}   ${result['Indication_Term']}
    Set Test Variable    ${route_of_admin_value}   ${result['Route_of_admin']}
    Set Test Variable    ${lot_batch_no_value}   ${result['Lot_Batch_No']}
    Set Test Variable    ${is_sample_avail_value}   ${result['Is_Sample_Available']}
    Set Test Variable    ${reported_term_value}   ${result['Reported_Term']}
    Set Test Variable    ${outcome_value}   ${result['Outcome']}
    Set Test Variable    ${seriousness_value}   ${result['Seriousness']}
    Set Test Variable    ${death_value}   ${result['Death?']}
    Set Test Variable    ${disability_perment_damage_value}   ${result['Disability/Permanent Damage?']}
    Set Test Variable    ${required_intervention_value}   ${result['Required Intervention']}
    Set Test Variable    ${life_threatening_value}   ${result['Life Threatening?']}
    Set Test Variable    ${caused_prolonged_hospital_value}   ${result['Caused/prolonged hospitalization']}
    Set Test Variable    ${other_medically_imp_condtn_value}   ${result['Other Medically Important Condition']}
    Set Test Variable    ${congential_anomaly_birth_defect_value}   ${result['Congenital Anomaly/Birth Defect?']}
    Set Test Variable    ${event_descrip_value}   ${result['Event_Description']}
    Set Test Variable    ${test_name_value}   ${result['Test_Name']}
    Set Test Variable    ${result_unstructured_value}   ${result['Result_Unstructured_Data']}
    Set Test Variable    ${sponosr_study_value}   ${result['Sponsor_Study_No']}
    ${Output_folder}=    Set Variable    ${EXECDIR}/Output
    Copy Sheet To New Excel    ${excel_file}    ${scenario_sheet_name}    output_folder=${Output_folder}
    ${Output_excel}=    Set Variable    ${EXECDIR}/Output/${scenario_sheet_name}.xlsx    
    RETURN    ${sheet_name}

Connect And Read Specific Column and Row Value From Sheet
    [Documentation]    Connect to the Excel file and read data from the specified sheet
    [Arguments]    ${excel_file}    ${sheet_name}    ${Column_name}    ${Scenario_value}
    ${data}=    read_scenario_from_sheet    ${excel_file}    ${sheet_name}    ${Column_name}    ${Scenario_value}
    RETURN    ${data}

Logout From LSMV Application
    [Documentation]    Logout from LSMV application
    Wait For Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}    
    Wait Until Keyword Succeeds    10s    5s    Click Element Custom    ${wvar('lsmv_user_profile_xpath')}
    Wait for Element display
    Take Screenshot    selenium
    Click Element Custom    ${wvar('logout_application_xpath')}
    Click Element Custom    ${wvar('logout_confirmation_yes_xpath')}
    Wait Until Element Is Visible    ${wvar('login_title_grid_xpath')}    ${wvar('shortwait')}
    Take Screenshot    selenium
    Log To Console   Logged out successfully    

Validate Test Results
    [Documentation]    Validate Test Results from Excel Sheet
    [Arguments]       ${Output_excel}
    Log file to report     ${Output_excel}
    ${Test_Result}     ${Test_status}=    Get Actual Test Results    ${Output_excel}
    Run Keyword If    '${Test_status}' == 'True'
    ...    Log To Console    Test Pass.
    ...  ELSE
    ...    Fail    Test failed. Failure Test Data ${Test_Result}

Login to the LSMV application using the Automation user account, and confirm the user's profile information.
    [Documentation]     LSMV Web application login functionality validation
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${screenshot_name}=    Evaluate    'HomeScreen_${timestamp}.png'
    # Get username and password before opening browser
    # ${username_value}    ${password_value}=    Get Dynamic Username And Password    ${Tag}    ${Test Case ID}
    ${execution_platform}=    Get test execution environment        
    Log    Execution Platform is : ${execution_platform}    console=True

    IF  "${headless}" == "yes" or '${execution_platform}' == 'linux'
        ${user_agent}=    Set Variable   'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.88 Safari/537.36'
        Add options to global browser options from list     user-agent=${user_agent}
        Add options to global browser options from list       headless=new       
        Open Browser    ${wvar('lsmv_url')}    ${wvar('browser')}    options=${global_browser_options}
        Set Window Size   1920   1080  
        # Get username and password before opening browser
        IF    '${execution_platform}' == 'linux'
            ${username_value}    ${password_value}=    Get Dynamic Username And Password    ${Tag}    ${Test Case ID}     
        END
    ELSE
        Open Browser    ${wvar('lsmv_url')}    ${wvar('browser')}    options=${global_browser_options}
        Set Window Size   1920   1080
        Maximize Browser Window    
    END  
    Wait for Element display
    Wait Until Element is Visible    ${wvar('username_xpath')}  timeout=20       
    Input Text      ${wvar('username_xpath')}   ${username_value}  # Enter Username    
    Input Text      ${wvar('password_xpath')}   ${password_value}   # Enter Password
    Set Log Level    INFO
    Take Screenshot    selenium
    Click Button    ${wvar('login_button_xpath')}      # Click on login button
    Wait for Element display
    ${ok_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('ok_button_xpath')}
    Run Keyword If    ${ok_present}    Click element    ${wvar('ok_button_xpath')}
    Wait Until Page Contains Element    ${wvar('lsmv_logo_xpath')}    timeout=20    # Adjust timeout and element ID as necessary
    Click Element Custom    ${wvar('lsmv_user_profile_xpath')}
    Wait for Element display
    Take Screenshot    selenium
    log to console      Successfully logged into the application    

Wait for Element display
    [Documentation]     Wait for element to be displayed
    Sleep   2s

User navigates to New Full Data Entry Form under Case Management
    [Documentation]   The User navigates to New Full Data Entry Form under Case Management
    Wait for Element display
    Wait Until Element is Visible    ${wvar('case_management_xpath')}    timeout=20
    Click element    ${wvar('case_management_xpath')}
    Mouse Over    ${wvar('case_management_xpath')}
    ${new_case_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('new_case_menu_xpath')}
    Run Keyword Unless    ${new_case_visible}    Click Element    ${wvar('case_management_xpath')}
    Wait Until Element is Visible    ${wvar('new_case_menu_xpath')}    timeout=20
    Click element    ${wvar('new_case_menu_xpath')}

    ${full_data_form}   Run Keyword And Return Status    Element Should Be Visible    ${wvar('new_case_menu_xpath')}
    Run Keyword Unless    ${full_data_form}    Click Element    ${wvar('new_case_menu_xpath')}
    Wait Until Element is Visible    ${wvar('full_data_entry_form_submenu_xpath')}    timeout=20
    Take Screenshot    selenium
    Click element    ${wvar('full_data_entry_form_submenu_xpath')}


New Create RCT
    [Documentation]    Pass the expected value to the Python function and extract the row
    ${rct_number}=    filling RCT    ${company_unit_value}    ${sender_organ_value}    ${latest_receview_date}   ${report_type}    ${primary_source_country_val}   ${cases_signification_val}
    ...        ${consent_to_contact_value}  ${first_name_value}  ${last_name_value}  ${country_value}  ${qualification_value}  ${regional_state_value}
    ...        ${patient_id_value}   ${age_group_value}   ${sex_value}
    ...        ${product_descrip_value}  ${action_taken_with_drug_value}  ${indication_value}  ${route_of_admin_value}  ${lot_batch_no_value}  ${is_sample_avail_value}
    ...        ${reported_term_value}  ${outcome_value}  ${seriousness_value}    ${seriousness_value}   ${death_value}    ${disability_perment_damage_value}
    ...        ${required_intervention_value}      ${life_threatening_value}      ${caused_prolonged_hospital_value}      ${other_medically_imp_condtn_value}
    ...        ${congential_anomaly_birth_defect_value}    ${event_descrip_value}   ${test_name_value}  ${result_unstructured_value}
    Set Test Variable    ${RCT_No}    ${rct_number}
    RETURN    ${rct_number}

filling RCT
    [Documentation]    Verify filling the case information fields required
    [Arguments]        ${company_unit_value}    ${sender_organ_value}    ${latest_receview_date}   ${report_type}    ${primary_source_country_val}   ${cases_signification_val}
            ...        ${consent_to_contact_value}  ${first_name_value}  ${last_name_value}  ${country_value}  ${qualification_value}  ${regional_state_value}
            ...        ${patient_id_value}   ${age_group_value}   ${sex_value}
            ...        ${product_descrip_value}  ${action_taken_with_drug_value}  ${indication_value}  ${route_of_admin_value}  ${lot_batch_no_value}  ${is_sample_avail_value}
            ...        ${reported_term_value}  ${outcome_value}  ${seriousness_value}    ${seriousness_value}   ${death_value}    ${disability_perment_damage_value}
            ...        ${required_intervention_value}      ${life_threatening_value}      ${caused_prolonged_hospital_value}      ${other_medically_imp_condtn_value}
            ...        ${congential_anomaly_birth_defect_value}    ${event_descrip_value}   ${test_name_value}  ${result_unstructured_value}

    filling the case information in general tab  ${company_unit_value}    ${sender_organ_value}    ${latest_receview_date}   ${report_type}    ${primary_source_country_val}   ${cases_signification_val}
    filling the case information in reporter tab  ${consent_to_contact_value}  ${first_name_value}  ${last_name_value}  ${country_value}  ${qualification_value}   ${regional_state_value}
    filling the case information in patient tab   ${patient_id_value}  ${age_group_value}  ${sex_value}
    filling the case information in product tab   ${product_descrip_value}  ${action_taken_with_drug_value}  ${indication_value}  ${route_of_admin_value}  ${lot_batch_no_value}  ${is_sample_avail_value}
    filling the case information in event tab   ${reported_term_value}  ${outcome_value}  ${seriousness_value}  ${death_value}    ${disability_perment_damage_value}  ${required_intervention_value}      ${life_threatening_value}      ${caused_prolonged_hospital_value}      ${other_medically_imp_condtn_value}   ${congential_anomaly_birth_defect_value}
    filling the case information in narrative tab  ${event_descrip_value}
    Handle PULSE-0062 Validation Error    Not Related    Not Related
    filling the case information in lab data tab  ${test_name_value}  ${result_unstructured_value}
    ${rct_number}=    Saving the RCT and retrieving its details
    RETURN    ${rct_number}

# Saving the RCT and retrieving its details
#     [Documentation]    Saving the RCT and retrieving its details
#     Replace xpath and click element       ${wvar('common_button_new_case')}   Save
#     Wait Until Keyword Succeeds     120s      10s   Wait Until Element Is Visible   ${wvar('rct_successfully_validation')}
#     ${text}   Get Text    ${wvar('rct_successfully_validation')}
#     ${words}   Split String      ${text}    ${SPACE}
#     ${rct_number}   Set Variable    ${words[4]}
#     Set Global Variable    ${aer}    ${rct_number}
#     log      ${rct_number}
#     Take Screenshot    selenium
#     Wait Then Click Element    ${wvar('validation_confirm_ok_xpath')}
#     # ${project_folder}=    Set Variable    ${CURDIR}${/}POC${/}
#     ${project_folder}=    Set Variable    ${EXECDIR}${/}Resource${/}TestData_Excels${/}
#     ${excel_file}=    Set Variable    ${project_folder}${wvar('workbook')}
#     ${sheet_name}=    Set Variable    ${wvar('sheet')}
#     # Write Value To Scenario    ${excel_file}    ${wvar('sheet')}    Scenario Name    ${Scenario_sheet_name}    RCT    ${rct_number}
#     Set Test Variable    ${RCT_No}    ${rct_number}
#     RETURN    ${rct_number}

filling the case information in narrative tab
    [Documentation]    filling the case information in narrative tab
    [Arguments]    ${event_description_value}
    Replace xpath and select case info menu tab    Narrative
    Replace xpath and input textarea              ${wvar('event_description_field_text')}      ${event_description_value}
    Scroll into view and Input text        ${wvar('company_remark_txtbx')}    ${wvar('company_remarks')}

filling the case information in lab data tab
    [Documentation]    filling the case information in lab tab
    [Arguments]    ${test_name_field_text_value}     ${result_unstructured_data_free_field_text}
    Replace xpath and select case info menu tab    Lab Data
    Replace Xpath Contains And Input Text      ${wvar('input_box_contains_common_field_xpath')}    ${wvar('test_name_field_text')}         ${test_name_field_text_value}
    Wait for Element display
    Replace Xpath And Click Element      ${wvar('tabview_xpath')}     ${test_name_field_text_value}
    Replace Xpath And Input Textarea            ${wvar('result_unstructured_data_free_field_text')}    ${result_unstructured_data_free_field_text}

filling the case information in event tab
    [Documentation]        filling the case information in event tab
    [Arguments]    ${reported_term_value}   ${outcome_value}   ${seriousness_value}  ${death_value}    ${disability_perment_damage_value}   ${required_intervention_value}      ${life_threatening_value}      ${caused_prolonged_hospital_value}      ${other_medically_imp_condtn_value}   ${congential_anomaly_birth_defect_value}
    Replace xpath and select case info menu tab    Event(s)
    Replace Xpath And Input Text                          ${wvar('reported_term_field_text')}   ${reported_term_value}
    Wait For Element Display
    #Wait For Element Display
    Replace Xpath And Click Element      ${wvar('event_tabview_xpath')}     ${reported_term_value}
    ${res}  Run Keyword And Return Status        Replace text Then Search and Select from Dropdown         ${wvar('outcome_field_text')}  ${outcome_value}
    IF    '${res}' == 'False'
         Execute JavaScript    window.scrollBy(0, 300)
         Replace text Then Search and Select from Dropdown         ${wvar('outcome_field_text')}   ${outcome_value}
#         Replace Xpath And Wait And Scroll Then Click Radio Btn With JS        ${wvar('outcome_field_text')}   ${outcome_value}
         Wait For Element Display
    END
    Wait For Element Display
    Replace Xpath And Select Radio Button                 ${wvar('seriousness_field_text')}   ${seriousness_value}
    Replace Xpath And Select Radio Button                 ${wvar('death_field_text')}   ${death_value}
    Replace Xpath And Select Radio Button                 ${wvar('disability_permanent_damage_field_text')}   ${disability_perment_damage_value}
    Replace Xpath And Select Radio Button                 ${wvar('required_intervention_field_text')}   ${required_intervention_value}
    Replace Xpath And Select Radio Button                 ${wvar('life_threatening_field_text')}   ${life_threatening_value}
    Replace Xpath And Select Radio Button                 ${wvar('congenital_anomaly_birth_defect_field_text')}   ${caused_prolonged_hospital_value}
    Replace Xpath And Select Radio Button                 ${wvar('caused_prolonged_hospitalization_field_text')}   ${other_medically_imp_condtn_value}
    Replace Xpath And Select Radio Button                 ${wvar('other_medically_imp_condition_field_text')}   ${congential_anomaly_birth_defect_value}

filling the case information in patient tab
    [Documentation]     filling the case information in patient tab
    [Arguments]      ${patient_id_value}   ${age_group_value}   ${sex_value}
    Replace xpath and select case info menu tab    Patient
    Replace Xpath contains And Input Text            ${wvar('input_box_contains_common_field_xpath')}                   ${wvar('patient_id_field_text')}    ${patient_id_value}
    Replace Xpath And Select The Manuval Check Box                     ${wvar('manuval_check_box')}       ${wvar('age_group_text')}
    Replace xpath Then Select from Dropdown                            ${wvar('age_group_text')}   ${age_group_value}
    Replace xpath Then Select from Dropdown                            ${wvar('sex_field_text')}   ${sex_value}

filling the case information in product tab
    [Documentation]    filling the case information in product tab
    [Arguments]    ${product_descrip_value}   ${action_taken_with_drug_value}   ${indication_value}   ${route_of_admin_value}   ${lot_batch_no_value}   ${is_sample_avail_value}
    Replace xpath and select case info menu tab    Product(s)
    product description field    ${product_descrip_value}
#    product description field filling input
    Wait For Element Display
    Replace text Then Search and Select from Dropdown    ${wvar('action_taken_field_text')}   ${action_taken_with_drug_value}
    Scroll into view and Input text      ${wvar('indication_term_input_field')}   ${indication_value}
    Replace text contains then search and select from dropdown    ${wvar('route_of_admin_field_text')}   ${route_of_admin_value}
    Replace Xpath Contains And Input Text      ${wvar('input_box_contains_common_field_xpath')}   ${wvar('lot_or_batch_no_field_text')}    ${lot_batch_no_value}
    Replace Xpath And Select Radio Button    ${wvar('is_sample_available_field_text')}   ${is_sample_avail_value}

product description field
    [Documentation]    filling the product description field
    [Arguments]    ${product_descrip_value}
    IF  '${product_descrip_value}' == 'STELARA'
        product as combination product as a stelara
    ELSE
        Replace text and click element the search icon    ${wvar('product_description_field_text')}
        Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                
        Replace text contains then search and select from dropdown in pd     ${wvar('authorization_country_field_text')}   ${wvar('authorization_country_field_optn')}    
        Wait For Element Display
        Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('search_btn_product_desptn')}
        Wait For Element Display
        ${res}  Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('pd_radio_btn_xpath')}  ${product_descrip_value}
        IF    '${res}' == 'False'
             Wait For Element Display
             Scroll Element Into View     ${wvar('search_btn_product_desptn')}
             Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
             Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
        ELSE
             Scroll then Click button    ${wvar('pd_selected_ok_button')}
        END
        Wait For Element Display
    END

Replace text and click element the search icon
    [Documentation]    Replace text and select radio button
    [Arguments]        ${field_name}
    ${res}   Replace String            ${wvar('input_search_icon_common_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view      ${res}
#    Wait Until Element Is Visible       ${res_optn}     30s
    Click Element          ${res}
    Wait For Element Display


product as combination product as a stelara
    [Documentation]    product as combination product as a stelara
    Replace text and click element the search icon    ${wvar('product_description_field_text')}
    Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}
    Replace text contains then search and select from dropdown in pd     ${wvar('authorization_country_field_text')}   ${wvar('authorization_country_field_optn')}
    Wait For Element Display
    Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('search_btn_product_desptn')}
    Wait For Element Display
    ${element}=    Execute Javascript    return window.document.evaluate("${wvar('stelara_pd_combination_drug')}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    Log    Element found: ${element}
    ${ress}  Run Keyword And Return Status     Click Element Using JavaScript Xpath       ${wvar('stelara_pd_combination_drug')}
    IF    '${ress}' == 'False'
        Wait For Element Display
        Scroll Element Into View     ${wvar('search_btn_product_desptn')}
        Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
        sleep   3s
        Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
        sleep   4s
        Wait Until Keyword Succeeds     20s     2s      Click Element Using JavaScript Xpath     ${wvar('pd_selected_ok_button')}
        Wait For Element Display
    END
    sleep   3s
    Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
    Wait Until Keyword Succeeds     20s     2s      Click Element Using JavaScript Xpath     ${wvar('pd_selected_ok_button')}
    Wait For Element Display

filling the case information in reporter tab
    [Documentation]     filling the case information in reporter tab
    [Arguments]    ${consent_to_contact_value}   ${first_name_value}    ${last_name_value}    ${country_value}    ${qualification_value}      ${regional_state_value}
    Replace xpath and select case info menu tab    Reporter
    Replace xpath and select radio button                             ${wvar('consent_to_contact_field_text')}   ${consent_to_contact_value}
    Replace xpath contains and input text        ${wvar('input_box_contains_common_field_xpath')}                       ${wvar('first_name_text')}               ${first_name_value}
    Replace xpath contains and input text         ${wvar('input_box_contains_common_field_xpath')}                     ${wvar('last_name_text')}                  ${last_name_value}
    Replace text contains then search and select from dropdown       ${wvar('country_field_text')}              ${country_value}
    Replace text contains then search and select from dropdown       ${wvar('qualification_field_text')}        ${qualification_value}
    Replace text contains then search and select from dropdown       ${wvar('regional_state_field_text')}       ${regional_state_value}


filling the case information in general tab
    [Documentation]    filling the case information in general tab
     [Arguments]    ${company_unit_value}    ${sender_organ_value}    ${latest_receview_date}    ${report_type}    ${primary_source_country_val}  ${cases_signification_val}
    Wait For Element Display
    ${no_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('no_button_xpath')}
    Run Keyword If    ${no_present}    Click Element    ${wvar('no_button_xpath')}
    Replace text Then Search and Select from Dropdown   ${wvar('company_unit_field_text')}   ${company_unit_value}
    Sleep  2s
    Replace xpath and input text                         ${wvar('sender_organization_as_coded_field_text')}   ${sender_organ_value}
    Wait For Element Display
    ${latest_receview_date}   Get Current Date           result_format=%d-%m-%Y
    Select Date                                          ${wvar('latest_received_date_text')}   ${latest_receview_date}
    Replace xpath Then Select from Dropdown              ${wvar('report_type_field_text')}           ${report_type}
    Replace text Then Search and Select from Dropdown   ${wvar('primary_source_country_text')}      ${primary_source_country_val}
    Replace Xpath And Select The Manuval Check Box                     ${wvar('manuval_check_box')}       ${wvar('cases_signification_field_text')}
    Replace xpath Then Select from Dropdown                            ${wvar('cases_signification_field_text')}   ${cases_signification_val}        

clasify the RCT to retrieve the AER number
    [Documentation]        Classify the RCT to obtain the AER number
    Replace xpath and wait then click element    ${wvar('tab_view_xpath')}   ${wvar('tab_view_text')}[3]
    Replace Xpath And Wait Then Click Element    ${wvar('classification_type_btn_xpath')}   New
    Replace Xpath And Wait Then Click Element    ${wvar('common_btn_xpath')}   Classify Case
    Wait For Element Display
    Wait Until Element Is Visible    ${wvar('aer_number_xpath')}    ${wvar('normalwait')}
    ${aer_number}   Get Text     ${wvar('aer_number_xpath')}
    Log    ${aer_number}
    Click Element    ${wvar('case_information_xpath')}
    Log To Console   Classified successfully
    RETURN    ${aer_number}

Replace xpath and select the manuval check box
    [Documentation]    Select replace xpath and select the manuval check box
    [Arguments]    ${xpath}   ${text}
    ${res}                              Replace String      ${xpath}      replace    ${text}
    scroll element into view                 ${res}
    Click Element Using JavaScript Xpath     ${res}

Replace xpath and wait and scroll then Click radio btn with JS
    [Documentation]                     Replace xpath and click Button and wait until button not visible
    [Arguments]                         ${xpath}   ${text}
    ${Result}                           Replace String   ${xpath}      replace    ${text}
    Wait Until Keyword Succeeds    10s   2s     Scroll Element Into View            ${Result}
    Wait Until Element Is Visible       ${Result}    50
    Click Element Using JavaScript Xpath             ${Result}

Scroll then Click button
    [Documentation]                     Replace xpath and click Button and wait until button not visible
    [Arguments]                         ${locator}
    Wait Until Keyword Succeeds    10s   2s     Scroll Element Into View            ${locator}
    Wait Until Element Is Visible       ${locator}    50
    Wait Until Keyword Succeeds    10s   2s     Click Element            ${locator}

Replace and Click button with JS
    [Documentation]                     Replace xpath and click Button and wait until button not visible
    [Arguments]                         ${locator}     ${changedText}
    ${Result}                           Replace String   ${locator}      replace    ${changedText}
    Scroll Element Into View            ${Result}
    Wait Until Element Is Visible       ${Result}    50
    Click Element Using JavaScript Xpath             ${Result}

Replace xpath and click element
    [Documentation]    Replace xpath and select radio button
    [Arguments]         ${xpath}    ${field_name}
    ${res}   Replace String            ${xpath}     replace    ${field_name}
    Click Element          ${res}
    Wait For Element Display

Replace xpath and wait then click element
    [Documentation]    Replace xpath and select radio button
    [Arguments]         ${xpath}    ${field_name}
    ${res}   Replace String            ${xpath}     replace    ${field_name}
    Wait Until Element Is Visible      ${res}    40s
    wait Until Keyword Succeeds   120s    2s     Click Element          ${res}
    Wait For Element Display

Replace xpath and input text
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('input_box_common_field_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Input Text       ${res}    ${option}
    Wait For Element Display
    Press Keys       ${res}    ENTER
    Wait For Element Display

Highlight and Replace xpath for input text
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_name}     
    ${res}   Replace String            ${wvar('text_bx_highlighting_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Highlight WebElement    ${res}

UnHighlight and Replace xpath for input text
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_name}     
    ${res}   Replace String            ${wvar('text_bx_highlighting_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    UnHighlight WebElement    ${res}
    
Highlight and Replace xpath for Unique input text
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_name}     
    ${res}   Replace String            ${wvar('contains_text_bx_highlighting_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Highlight WebElement    ${res}

Replace xpath and input textarea
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('input_textarea_box_common_field_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Input Text       ${res}    ${option}
    Wait For Element Display
    Press Keys       ${res}    ENTER
    Wait For Element Display

Scroll into view and Input text
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_xpath}    ${option}
    Wait Until Keyword Succeeds    10s    1s   Scroll Element Into View     ${field_xpath}
    Wait Until Element Is Visible       ${field_xpath}     30s
    Input Text       ${field_xpath}    ${option}
    Wait For Element Display
    Press Keys       ${field_xpath}    ENTER
    Wait For Element Display

Replace xpath contains and input text
    [Documentation]    Replace xpath and input text
    [Arguments]       ${xpath}  ${field_name}     ${option}
    ${res}   Replace String       ${xpath}       replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Input Text       ${res}    ${option}
    Wait For Element Display
    Press Keys       ${res}    ENTER
    Wait For Element Display

Replace Xpath Contains And Enter the Input Text
    [Documentation]    Replace xpath and input text
    [Arguments]       ${xpath}   ${field_name}     ${option}
    ${res}   Replace String            ${xpath}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Input Text       ${res}    ${option}
    Wait For Element Display

Click Element Using JavaScript Xpath
    [Documentation]     Click element using javascript while passing location using xpath
    [Arguments]    ${xpath}
    Execute JavaScript    document.evaluate("${xpath}",document.body,null,9,null).singleNodeValue.click();

Replace xpath and select radio button
    [Documentation]    Replace xpath and select radio button
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('radio_btn_xpath')}     replace    ${field_name}
    ${res_optn}   Replace String            ${res}     option    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view      ${res_optn}
#    Wait Until Element Is Visible       ${res_optn}     30s
    Click Element Using JavaScript Xpath      ${res_optn}
    Wait For Element Display

Replace xpath and Highlight radio button title
    [Documentation]    Replace xpath and select radio button
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('highlight_radio_btn_xpath')}     replace    ${field_name}
    ${res_optn}   Replace String            ${res}     option    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view      ${res_optn}
    Highlight WebElement    ${res_optn}    

Replace xpath and click element the search icon
    [Documentation]    Replace xpath and select radio button
    [Arguments]        ${field_name}
    ${res}   Replace String            ${wvar('input_search_icon_common_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view      ${res}
#    Wait Until Element Is Visible       ${res_optn}     30s
    Click Element          ${res}
    Wait For Element Display

Replace xpath and select case info menu tab
    [Documentation]    Replace xpath and select radio button
    [Arguments]        ${tab}
    ${res}   Replace String         ${wvar('menu_tab_case_info')}         replace    ${tab}
    ${check}    Run Keyword And Return Status     Wait Until Element Is Visible       ${res}     30s
    Run Keyword If   '${check}'=='False'   Wait Until Keyword Succeeds    5s   1s  Scroll Element Into View    ${res}
    Click Element      ${res}
    Wait For Element Display

Replace xpath and Highlight Case info menu Tab
    [Documentation]    Replace xpath and select radio button
    [Arguments]        ${tab}
    ${res}   Replace String         ${wvar('menu_tab_case_info')}         replace    ${tab}
    ${check}    Run Keyword And Return Status     Wait Until Element Is Visible       ${res}     30s
    Run Keyword If   '${check}'=='False'   Wait Until Keyword Succeeds    5s   1s  Scroll Element Into View    ${res}
    Highlight WebElement    ${res}

Replace xpath and UnHighlight Case info menu Tab
    [Documentation]    Replace xpath and select radio button
    [Arguments]        ${tab}
    ${res}   Replace String         ${wvar('menu_tab_case_info')}         replace    ${tab}
    ${check}    Run Keyword And Return Status     Wait Until Element Is Visible       ${res}     30s
    Run Keyword If   '${check}'=='False'   Wait Until Keyword Succeeds    5s   1s  Scroll Element Into View    ${res}
    UnHighlight WebElement    ${res}

Replace xpath Then Select from Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('common_dropdown_select_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Replace xpath Then Highlight Dropdown
    [Documentation]     To replace xpath and highlight a value from dropdown
    [Arguments]        ${field_name}  
    ${res}   Replace String            ${wvar('dd_highlight_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}    
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Highlight WebElement    ${res}

Select Study Type From Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('study_type_dd_bx_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Replace Xpath Then highlight Dropdown value
    [Documentation]     To replace xpath and highlight a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('common_dropdown_select_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s    
    Highlight WebElement    ${res}

Replace text contains then search and select from dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            (${wvar('common_dropdown_select_contains_xpath')})[1]     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Input Text      ${wvar('input_search_xpath')}    ${option}
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Replace text contains then search and select from dropdown in pd
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            (${wvar('pd_dropdown_xpath')})[1]     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Input Text      ${wvar('input_search_xpath')}    ${option}
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Select Date
    [Documentation]    Enter Start Date
    [Arguments]     ${field_name}   ${date}
    ${res}                              Replace String  ${wvar('common_date_input_field_xpath')}   replace   ${field_name}    
    Wait Until Element Is Visible       ${res}  40s
    Scroll Element Into View            ${res}
    Input Text            ${res}             ${date}
    sleep    2
    SeleniumLibrary.Press Keys          None    ENTER
    sleep    2s
    Click Element       ${res}
    Screenshot.Take Screenshot                     Selenium

Highlight date field
    [Documentation]    Highlight Start Date
    [Arguments]     ${field_name}   
    ${res}                              Replace String  ${wvar('common_date_input_field_xpath')}   replace   ${field_name}    
    Wait Until Element Is Visible       ${res}  40s
    Scroll Element Into View            ${res}
    Highlight WebElement                ${res}

User navigated to the Case Listing module under Case Management
    [Documentation]     User navigated to the Case Listing module under Case Management   
    Sleep    5s
    Wait for Element display    
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=${wvar('longwait')}
    Wait Until Element is Visible    ${wvar('case_management_xpath')}    timeout=${wvar('shortwait')}
    Wait Until Keyword Succeeds    10s    2s    Click element    ${wvar('case_management_xpath')}
    Mouse Over    ${wvar('case_management_xpath')}
    ${case_listing_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('case_listing_xpath')}
    Run Keyword Unless    ${case_listing_visible}    Click Element    ${wvar('case_management_xpath')}
    Wait Until Element is Visible    ${wvar('case_listing_xpath')}    timeout=${wvar('shortwait')}
    Click element    ${wvar('case_listing_xpath')}
    Log    Case Listing Button is Visible and clicked 

Search for AER
    [Documentation]    Search for the AER
    [Arguments]    ${aer}
    Set Test Variable    ${RCT_No}    ${aer}
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('normalwait')}
    Wait Until Element is Visible    ${wvar('case_search_xpath')}     ${wvar('normalwait')}
    Clear Element Text    ${wvar('case_search_xpath')}
    Input Text    ${wvar('case_search_xpath')}    ${aer}
    Sleep    10s
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}     ${wvar('normalwait')}
    Wait Until Page Contains Element    ${wvar('case_search_button_xpath')}    ${wvar('normalwait')}  
    Click element    ${wvar('case_search_button_xpath')}
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('normalwait')}
    ${RCT_xpath}=    Replace String     ${wvar('rct_list_id_xpath')}    rct        ${aer}
    ${status}=    Run Keyword And Return Status     Wait Until Element Is Visible    ${RCT_xpath}    10s
    IF    '${status}' == 'True'
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90
        Sleep    5s
        Highlight WebElement    ${RCT_xpath}
        Click element    ${RCT_xpath}
        ${res}=    Run Keyword And Return Status     Wait For General Tab                    
        ${res}=    Run Keyword And Return Status    Press Ctrl E Keyboard Shortcut
        Take Screenshot    selenium
    END
    WHILE    '${status}' == 'False'    limit=3
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90
        Wait Until Element is Visible    ${wvar('case_search_xpath')}    timeout=20
        Clear Element Text    ${wvar('case_search_xpath')}
        Input Text    ${wvar('case_search_xpath')}    ${aer}
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90
        Wait for Element display
        Wait Until Page Contains Element    ${wvar('case_search_button_xpath')}    timeout=30
        Click element    ${wvar('case_search_button_xpath')}
        Wait for Element display
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90        
        ${RCT_xpath}=    Replace String     ${wvar('rct_list_id_xpath')}    rct        ${aer}
        ${status}=    Run Keyword And Return Status     Wait Until Element Is Visible    ${RCT_xpath}    10s
        IF    '${status}' == 'True'
            Highlight WebElement    ${RCT_xpath}
            Click element    ${RCT_xpath}
            ${res}=    Run Keyword And Return Status     Wait For General Tab  
            ${res}=    Run Keyword And Return Status    Press Ctrl E Keyboard Shortcut          
            BREAK
        END
    END    

Connect And Read Data From Excel Sheet
    [Documentation]    Connect to the Excel file and read data from the specified sheet
    [Arguments]    ${excel_file}    ${sheet_name}
    ${data}=    get_entire_data_as_dict_from_excel    ${excel_file}    ${sheet_name}
    RETURN    ${data}

Selct Value From Drop Down
    [Documentation]    Selct Value From Drop Down
    [Arguments]    ${DropDown_Box_element}    ${Value}
    Wait Until Element Is Visible    ${DropDown_Box_element}    ${wvar('normalwait')}
    Click Element    ${DropDown_Box_element}
    Wait Until Element Is Visible    ${wvar('dropdown_option_xpath')}     ${wvar('normalwait')}
    ${dd_options}=    Get WebElements    ${wvar('dropdown_option_xpath')}
    ${Length}=    Get Length    ${dd_options}
    FOR    ${option}    IN    @{dd_options}
        Wait Until Element Is Visible    ${option}     ${wvar('normalwait')}
        ${option_txt}=    Get Text From Dynamic Element     ${option}
        Log    ${option_txt}
        Log    ${Value}
        ${option_txt}=    Replace String    ${option_txt}    ${SPACE}    ${EMPTY}
        ${Value}=    Replace String    ${Value}    ${SPACE}    ${EMPTY}
        IF    '${option_txt}' == '${Value}'
            Highlight WebElement    ${option}
            Click Element    ${option}
            BREAK
        END
    END        

Get Text From Dynamic Element
    [Documentation]    Get the text from a dynamic element    
    [Arguments]    ${obj}
    Set Library Search Order    SeleniumLibrary
    ${Text}=    Get Text    ${obj}
    RETURN     ${Text}

Delete Product From Case
    [Documentation]    Delete Product from case
    [Arguments]    ${Product_Description_value}
    Replace xpath and select case info menu tab    Product(s)    
    Wait For Element Display    
    ${sub_product_xpath}=    Replace String    ${wvar('subproduct_xpath')}    replace    ${Product_Description_value}
    Click Element Custom    ${sub_product_xpath}
    Click Element Custom    ${wvar('product_delete_btn_xpath')}
    Click Element Custom    ${wvar('confirm_delete_btn_xpath')}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${sub_product_xpath}
    Run Keyword If    '${status}' == 'True'
    ...    Log To Console    Product Deleted Successfully.
    ...  ELSE
    ...    Fail    Product Deletion Failed.
    Take Screenshot    selenium

Fetch Workflow Stage
    [Documentation]    Fetch the current workflow status of the RCT
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
    ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
    Log    Current Workflow Stage is: ${workflow_label}
    RETURN    ${workflow_label}

Get Selected Transist Id
    [Documentation]    Get Selected Transist Id
    Wait Until Element Is Visible    ${wvar('active_noncase_xpath')}    ${wvar('shortwait')}  
    ${Value}=    Get Selected List Value    ${wvar('active_noncase_xpath')}
    Log    Selected Value is : ${Value}
    RETURN    ${Value}

Input Label Version As Per Country In Labeling tab    
    [Documentation]    This function will select label from the labeling table as per the country
    [Arguments]    ${labeling_ctry}    ${labeling_version}
    ${table_rows_elements}=     Get WebElements    ${wvar('labeling_table_rows_xpath')}
    ${count}=    Set Variable    1
    FOR    ${rows}    IN    @{table_rows_elements}
        ${count}=    Convert To String    ${count}    
        ${act_labeling_ctry_xpath}=    Replace String    ${wvar('labeling_ctry_rows_xpath')}    replace    ${count}
        ${act_labeling_ctry}=    Get Element Attribute    ${act_labeling_ctry_xpath}    aria-label        
        Log    ${act_labeling_ctry}
        IF    '${act_labeling_ctry}' == '${labeling_ctry}'
            Highlight WebElement    ${act_labeling_ctry_xpath}
            ${act_labeling_row_checkedbox_xpath}=    Replace String    ${wvar('labeling_row_version_checkbox_xpath')}    replace    ${count}
            ${checkbox_status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${act_labeling_row_checkedbox_xpath}   3s
            IF    '${checkbox_status}' == 'True'
                Log    Manual Checkbox is checked.
            ELSE
                Reduce Window Size Web Support    70%
                ${act_labeling_row_checkbox_xpath}=    Replace String    ${wvar('labeling_row_version_checkbox_xpath')}    replace    ${count}
                Scroll Element Into View    ${act_labeling_row_checkbox_xpath}
                # Element Should Be Enabled    ${act_labeling_row_checkbox_xpath}
                Click Element Using JavaScript Xpath    ${act_labeling_row_checkbox_xpath} 
                JS Toggle PrimeNG Checkbox    locator=${act_labeling_row_checkbox_xpath}    desired_state=true
                ${state}=    Get Element Attribute    ${act_labeling_row_checkbox_xpath}    aria-checked
                Should Be Equal    ${state}    true                   
                ${labeling_version_input_box_xpath}=    Replace String    ${wvar('labeling_version_input_box_xpath')}    replace    ${count}
                Click Element Custom    ${labeling_version_input_box_xpath} 
                Input Text    ${labeling_version_input_box_xpath}    ${labeling_version}
            END        
        END        
        ${count}=    Evaluate    ${count} + 1            
    END
    
Complete confirmation Activity
    [Documentation]    Complete confirmation Activity
    Wait for Element display
    ${RCT_No}=    Fetch RCT No From Case
    ${workflow_stage}=    Fetch Workflow Stage
    ${Transist_Id}=    Get Selected Transist Id
    Log    Transition Id is : ${Transist_Id}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
    Click Element Custom    ${wvar('actions_xpath')}
    Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
    Wait for Element display        
    Wait Until Keyword Succeeds    20s    3s    Click Element Custom    ${wvar('complete_activity_xpath')}
    Wait for Element display 
    
    ${Pre_warning_status}=    Set Variable    False   
    IF    '${workflow_stage}' == 'Distribute Transit'
        Sleep    15s
        ${Pre_warning_status}=    Run Keyword And Return Status    Wait Until Element is Visible    ${wvar('warning_confirmation_popup_yes_xpath')}   
        IF    '${Pre_warning_status}' == 'True'
            Click Element Custom    ${wvar('warning_confirmation_popup_yes_xpath')}
        END
    END
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    ${scheduler_warning}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('normalwait')}
    IF    '${scheduler_warning}' == 'False'
        Handle Scheduler Popup
        ${Transist_Id}=    Get Selected Transist Id
        User navigated to the Case Listing module under Case Management   
        Handle Modify Confirmtion Popup
        Search for RCT Latest    ${RCT_No} 
        Wait For General Tab
        Select From List By Value    ${wvar('workflow_dropdown_xpath')}     ${Transist_Id}
    END    
    IF    '${Pre_warning_status}' == 'True'
        Handle Scheduler Popup
        ${Transist_Id}=    Get Selected Transist Id
        Log    Transition Id is : ${Transist_Id}
        User navigated to the Case Listing module under Case Management
        Handle Modify Confirmtion Popup        
        Search for RCT Latest    ${RCT_No}
        Wait For General Tab
        ${current_workflow_stage}=    Fetch Workflow Stage
        IF    '${workflow_stage}' == '${current_workflow_stage}'
            Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
            Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
            Select From List By Value    ${wvar('workflow_dropdown_xpath')}     ${Transist_Id}
            Click Element Custom    ${wvar('actions_xpath')}
            Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
            Wait for Element display        
            Wait for Element display    
            Click Element Custom    ${wvar('complete_activity_xpath')}
        END
    END    
    Handle Lateness Popup    
    ${status1}=    Run Keyword And Return Status    Wait Until Element is Visible    ${wvar('pass_ok_button_xpath')}    ${wvar('normalwait')}
    IF    '${status1}' == 'False'
        # Run Keyword And Return Status    Search for RCT Latest    ${RCT_No} 
        # Select From List By Value    ${wvar('workflow_dropdown_xpath')}     ${Transist_Id}
        Click Element Custom    ${wvar('actions_xpath')}
        Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
        Wait for Element display        
        Wait for Element display    
        Click Element Custom    ${wvar('complete_activity_xpath')}
        Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
        Handle Lateness Popup
    END
    Wait Until Element is Visible    ${wvar('pass_ok_button_xpath')}    ${wvar('longwait')}
    Take Screenshot    selenium
    Click Element Custom    ${wvar('pass_ok_button_xpath')}
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    ${status1}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    IF    '${status1}' == 'False'
        Handle Scheduler Popup
        User navigated to the Case Listing module under Case Management  
        Handle Modify Confirmtion Popup
    END
    ${status}=    Run Keyword And Return Status    Wait Until Element is Visible    ${wvar('validation_confirm_ok_button_xpath')}    ${wvar('shortwait')}
    IF    '${status}' == 'False'
        User navigated to the Case Listing module under Case Management  
    ELSE    
        Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}
    END
 
Click Actions And Complete Activity
    [Documentation]    Click Actions And Complete Activity
    Click element    ${wvar('actions_xpath')}
    Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('normalwait')}
    Click element    ${wvar('complete_activity_xpath')}
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('normalwait')}

Select Flow Transition Dropdow
    [Documentation]    Select the flow transition dropdown
    [Arguments]    ${option}
    Wait Until Element Is Visible    ${wvar('active_noncase_xpath')}    ${wvar('shortwait')}
    Select From List By Value    ${wvar('active_noncase_xpath')}    ${option}
    Wait for Element display

Add Data In the Study Tab
    [Documentation]     Add Data In the Study Tab
    [Arguments]     ${Sponsor_Study_No_value}
    Replace xpath and select case info menu tab    Study
    Replace xpath and Highlight Case info menu Tab    Study    
    Replace xpath and click element        ${wvar('sponcer_study_search_xpath')}   ${wvar('sponsor_study_no_field_text')}
    Click Element Custom    ${wvar('confirm_delete_btn_xpath')}
    Wait Until Element Is Visible    ${wvar('sponce_study_no_txt_bx_xpath')}        ${wvar('normalwait')}
    Input Text    ${wvar('sponce_study_no_txt_bx_xpath')}    ${Sponsor_Study_No_value}
    Select Study Type From Dropdown              ${wvar('study_type_text')}           Other Studies
    Click Element Custom    ${wvar('staudy_dialog_search_btn_xpath')}   
    Wait for Element display
    Wait for Element display
    Click Element Custom    ${wvar('study_radio_btn_xpath')}    
    Click Element Custom    ${wvar('study_ok_btn_xpath')}    
    ${pdf_symbol_xpath}=    Replace String     ${wvar('pdf_symbol_xpath')}    replace    ${wvar('sponsor_study_no_field_text')}
    Wait Until Element Is Visible    ${pdf_symbol_xpath}    ${wvar('normalwait')}
    Take Screenshot    selenium
    Replace xpath and UnHighlight Case info menu Tab    Study

Medical Review
    [Documentation]    Medical Review
    [Arguments]    ${aer}
    Wait For Element Display
    Wait Until Element is Visible    ${wvar('medical_review_sidebar_xpath')}    timeout=60
    Click Element       ${wvar('medical_review_sidebar_xpath')}
    Wait Until Element is Visible    ${wvar('medical_review_switchto_form_xpath')}    timeout=20
    Click Element       ${wvar('medical_review_switchto_form_xpath')}
    Wait Until Element is Visible    ${wvar('medical_review_fulldata_entry_for_xpath')}    timeout=20
    Click Element       ${wvar('medical_review_fulldata_entry_for_xpath')}
    Wait for Element Display
    ${Status}=     Run Keyword And Return Status        Wait Until Element Is Visible    ${wvar('validation_confirm_ok_xpath')}    ${wvar('normalwait')}
    IF    '${Status}' == 'True'
        Sleep    10s
        Wait Until Element Is Enabled    ${wvar('validation_confirm_ok_xpath')}    ${wvar('normalwait')}
        Click Element    ${wvar('validation_confirm_ok_xpath')}
        Press Ctrl E Keyboard Shortcut
    END

Verify XML import and retrieve RCT number from queue
    [Documentation]    Verifying XML import and retrieve RCT number from queue
#    [Arguments]    ${file_name}
    Wait Then Click Element           ${wvar('new_btn_caselisting')}
    Wait For Element Display
    ${dest_file}=  Update XML File
    Choose File        ${wvar('import_xml_file_xpath')}     ${dest_file}
    ${max_attempts}=    Set Variable    5
    ${attempt}=    Set Variable    0
    WHILE    ${attempt} < ${max_attempts}    limit=${max_attempts}
        ${validation_error_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('action_completed_validation_error_xpath')}    10s
        IF    ${validation_error_present}
            Wait for Element display
            Click Element    ${wvar('action_completed_success_btn_ok_xpath')}
            Wait for Element display
            Wait Then Click Element      ${wvar('new_btn_caselisting')}
            Wait For Element Display
            ${dest_file}=  Update XML File
            Choose File        ${wvar('import_xml_file_xpath')}     ${dest_file}
        ELSE
            ${success_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('action_complete_success_btn_ok_xpath')}    10s
            Run Keyword If    ${success_present}    Exit For Loop
            Sleep    2s
        END
        ${attempt}=    Evaluate    ${attempt} + 1
    END
    Wait Until Element is Visible   ${wvar('xml_message_number')}    timeout=120s
    ${full_text}=    Get Text    ${wvar('xml_message_number')}
    Log    Full Text: ${full_text}
    ${part}=    Split String   ${full_text}  ICSR Message Number:
    ${right_part}=    Set Variable  ${part[1]}
    ${words}=    Split String   ${right_part}
    ${icsr_number}=    Set Variable   ${words[0]}
    Set Variable    ${icsr_number}    ${icsr_number}
    Log To Console    Extracted ICSR Message Number: ${icsr_number}
    Wait Then Click Element    ${wvar('action_complete_success_btn_ok_xpath')}
    Wait for Element display
    Wait for Element display
    Wait Until Element is Visible    ${wvar('case_management_xpath')}    timeout=20
    Click element    ${wvar('case_management_xpath')}
    Mouse Over    ${wvar('case_management_xpath')}
    ${etwob_message_queue_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('etwob_message_queue_xpath')}
    IF   '${etwob_message_queue_visible}' == 'False'    Click Element    ${wvar('case_management_xpath')}
    Wait for Element display
    Wait Until Element is Visible    ${wvar('etwob_message_queue_xpath')}    timeout=60
    Click element    ${wvar('etwob_message_queue_xpath')}
    Take A Screenshot    Selenium
    ${Count} =  Get Element Count         ${wvar('xml_import_status_xpath')}
    Run Keyword If  '${Count}'== '0'    Wait Until Keyword Succeeds     5 min    5 Sec   get rct status success     ${wvar('import_queue_refresh_xpath')}
    Precondition For CDDR_seventy_one    ${icsr_number}
    ${rct_number_xml}=    Replace String    ${wvar('rctnumber_message_queue_xpath')}    replace    ${icsr_number}
    Wait Until Keyword Succeeds    10s     2s   Scroll Element Into View      ${rct_number_xml}
    ${rct_number_xml}      Get Text    ${rct_number_xml}
    Set Global Variable     ${rct_number_xml}    ${rct_number_xml}
    Set Test Variable    ${RCT_No}    ${rct_number_xml}
    RETURN    ${rct_number_xml}

Update XML File
    [Documentation]    Update the XML file with new data
    IF    '${TEST_NAME}' == 'LSMV_Auto-Calculator_PULSE-CDDR71_E2B Causality_Clean up'
        ${xml_file}=    Set Variable    ${EXECDIR}${/}Resource${/}testdata_xml_file${/}CDDR_71_xmlfile.xml
        # ${dest_file}=    Set Variable    ${EXECDIR}${/}Resource${/}testdata_xml_file${/}RCT20240926591_updated.xml
        update_messagenumb_in_robot    ${xml_file} 
        RETURN     ${xml_file}   
    ELSE
        ${xml_file}=    Set Variable    ${EXECDIR}${/}Resource${/}testdata_xml_file${/}xmlfile.xml
        ${dest_file}=    Set Variable    ${EXECDIR}${/}Resource${/}testdata_xml_file${/}xmlfile_updated.xml
        Update Xml In Robot    ${xml_file}    ${dest_file}
        RETURN     ${dest_file}
    END

get rct status success
    [Documentation]    Get RCT status success
    [Arguments]    ${xpath}
    Click Element   ${xpath}
    Wait Until Element Is Visible     ${wvar('xml_import_status_xpath')}

Create Followup
    [Documentation]        Create followup to the RCT
    [Arguments]            ${followup_aer}
    ${expected_followup_rct}   Replace String            ${wvar('common_followup_aer_xpath')}     replace    ${followup_aer}
    Wait for Element display
    Replace xpath and wait then click element    ${wvar('tab_view_xpath')}   ${wvar('tab_view_text')}[3]
    Wait for Element display
    Replace Xpath And Wait Then Click Element    ${wvar('classification_type_btn_xpath')}   Follow Up
    ${noncase_confirm_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('classify_noncase_confirm_xpath')}
    Run Keyword If    ${noncase_confirm_present}    Click Element    ${wvar('classify_noncase_confirm_xpath')}
    ${proceed_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('classify_followup_proceed_xpath')}
    Run Keyword If    ${proceed_present}    Click Element Using JavaScript Xpath    ${wvar('classify_followup_proceed_xpath')}
    Wait until element is visible    ${wvar('classify_followup_search_aer_xpath')}    20s
    Click Element Using JavaScript Xpath  ${wvar('classify_followup_search_aer_xpath')}
    Wait until element is visible    ${wvar('classify_followup_search_xpath')}    30s
    Input Text    ${wvar('classify_followup_search_xpath')}    ${followup_aer}
    Press Keys    ${wvar('classify_followup_search_xpath')}    ENTER
    Wait until element is visible    ${expected_followup_rct}    20s
    Click Element Using JavaScript Xpath  ${expected_followup_rct}
    Wait until element is visible    ${wvar('classify_followup_select_btn_xpath')}    20s
    Click Element Using JavaScript Xpath  ${wvar('classify_followup_select_btn_xpath')}
    Wait until element is visible    ${wvar('classify_followup_confirm_xpath')}    20s
    Click Element Using JavaScript Xpath  ${wvar('classify_followup_confirm_xpath')}
    log to console   Follow up classified successfully
    Wait For Element Display    
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')} 
    Take Screenshot     selenium

Create Followup As per RCT
    [Documentation]        Create followup to the RCT
    [Arguments]            ${followup_aer}
    ${expected_followup_rct}   Replace String            ${wvar('common_followup_aer_xpath')}     replace    ${followup_aer}
    Wait for Element display
    Replace xpath and wait then click element    ${wvar('tab_view_xpath')}   ${wvar('tab_view_text')}[3]
    Wait for Element display
    Replace Xpath And Wait Then Click Element    ${wvar('classification_type_btn_xpath')}   Follow Up
    ${noncase_confirm_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('classify_noncase_confirm_xpath')}
    Run Keyword If    ${noncase_confirm_present}    Click Element    ${wvar('classify_noncase_confirm_xpath')}
    ${proceed_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('classify_followup_proceed_xpath')}
    Run Keyword If    ${proceed_present}    Click Element Using JavaScript Xpath    ${wvar('classify_followup_proceed_xpath')}
    Wait until element is visible    ${wvar('classify_followup_receipt_no_lp_xpath')}    20s
    Click Element Using JavaScript Xpath  ${wvar('classify_followup_receipt_no_lp_xpath')}
    Wait until element is visible    ${wvar('classify_followup_search_xpath')}    30s
    Input Text    ${wvar('classify_followup_search_xpath')}    ${followup_aer}
    Press Keys    ${wvar('classify_followup_search_xpath')}    ENTER
    Wait until element is visible    ${expected_followup_rct}    20s
    Click Element Using JavaScript Xpath  ${expected_followup_rct}
    Wait until element is visible    ${wvar('classify_followup_select_btn_xpath')}    20s
    Take Screenshot     selenium
    Click Element Using JavaScript Xpath  ${wvar('classify_followup_select_btn_xpath')}
    Wait until element is visible    ${wvar('classify_followup_confirm_xpath')}    20s
    Click Element Using JavaScript Xpath  ${wvar('classify_followup_confirm_xpath')}
    log to console   Follow up classified successfully
    
Select General Tab
    [Documentation]    Select General Tab
    Wait for Element display
    Wait Until Element Is Visible       ${wvar('case_information_xpath')}    60s
    Sleep  1s
    Click Element       ${wvar('case_information_xpath')}
    Wait Until Element Is Visible       ${wvar('general_tab_xpath')}    20s
    Click Element       ${wvar('general_tab_xpath')}

Highlight Workflow Status
    [Documentation]    Highlight the workflow status element
    Wait For General Tab
    Wait Until Element Is Visible    ${wvar('workflow_highlight_xpath')}    ${wvar('shortwait')}    
    Highlight WebElement    ${wvar('workflow_highlight_xpath')}

Create End to End RCT
    [Documentation]    Verify the data for end to end RCT
    [Arguments]    ${workflow}    ${result}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${screenshot_name}=    Evaluate    'End to End RCT_' + '${workflow}' + '_' + '${timestamp}' + '.png'
    Wait for Element display
    Wait Until Element is Visible    ${wvar('workflow_status_xpath')}    timeout=20
    ${workflow_status}=    Get Text    ${wvar('workflow_status_xpath')}
    Run Keyword Unless    '${workflow}' in '${workflow_status}'    Fail    Workflow status '${workflow_status}' does not contain expected stage '${workflow}'
    Wait Until Element Is Visible    ${wvar('rct_xpath')}    timeout=20
    ${rct}=    Get Text    ${wvar('rct_xpath')}
    Set Test Variable    ${rct}    ${rct}
    Click element    ${wvar('actions_xpath')}
    Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    timeout=20
    Click element    ${wvar('complete_activity_xpath')}
    Wait for Element display
    Run Keyword If    '${result}' == 'ERROR'    Run Keywords
    ...    AND    Take Screenshot   Selenium
    ...    AND    Handle Confirm Popup
    ...    ELSE    log to console      'No error found'
    IF   '${result}' == 'PASS'
        Take Screenshot    selenium
        Sleep    10s
        Handle Lateness Popup
        Handle warning saving Confirm Popup
        Wait Until Element is Visible    ${wvar('workflow_notes_xpath')}    timeout=60
        Input Text    ${wvar('workflow_notes_xpath')}    ${wvar('workflow_message')}
        Click element    ${wvar('pass_ok_button_xpath')}
        Sleep    30s
        Wait Until Element is Visible    ${wvar('validation_confirm_ok_button_xpath')}    timeout=60
        Click element    ${wvar('validation_confirm_ok_button_xpath')}
        Wait for Element display
        Search for AER  ${rct}
    END
    Take Screenshot   Selenium
    ${message}=    Evaluate    "'End to End RCT' + str(${workflow}) + ' verified successfully'"
    log to console      ${message}

Handle Scheduler Popup
    [Documentation]    Handle scheduler popup if it appears
    ${schedule_val}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('dl_error_msg_xpath')}    ${wvar('shortwait')}
    IF    '${schedule_val}' == 'True'
        Capture Page Screenshot
        Click Element Custom  ${wvar('dl_error_msg_xpath')}
        Capture Page Screenshot
    END
    Wait for Element display    

Handle warning saving Confirm Popup 
    [Documentation]    Handle confirm popup if it appears
    # Wait for Element display       
    # Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    ${is_popup_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('warning_confirmation_popup_xpath')}    ${wvar('longwait')}
    IF    '${is_popup_present}' == 'True'
        Click Element Custom    ${wvar('warning_confirmation_popup_yes_xpath')}    
    END    

Handle Confirm Popup
    [Documentation]    Handle confirm popup if it appears
    ${Satatus}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('nullification_warning_yes_xpath')}    20s
    IF    '${Satatus}' == 'True'
        Click Element    ${wvar('nullification_warning_yes_xpath')}
    END

Handle Warning Confirm Popup
    [Documentation]    Handle warning confirm popup if it appears
    ${Satatus}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('nullification_warning_yes_xpath')}    20s
    IF    '${Satatus}' == 'True'
        Click Element    ${wvar('nullification_warning_no_xpath')}
    END

Handle Pending Submission Error
    [Documentation]    Handle any pending submission errors
    [Arguments]    ${result}
    ${nullification_pending_submission_error_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('nullification_pending_submission_error_xpath')}    10s
    IF    '${nullification_pending_submission_error_present}' == 'True'
        Take Screenshot     selenium
        Wait Until Element Is Visible    ${wvar('nullification_text_area_xpath')}    timeout=20s
        Wait Until Element Is Enabled    ${wvar('nullification_text_area_xpath')}    timeout=20s
        Clear Element Text    ${wvar('nullification_text_area_xpath')}
        Click Element    ${wvar('amendment_radiobutton_xpath')}
        Sleep  1s
        IF    '${result}' == 'PASS'
            Click element    ${wvar('actions_xpath')}
            Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    timeout=20
            Click element    ${wvar('complete_activity_xpath')}
            Wait for Element display
            Handle Confirm Popup
        END
    END

Handle Company Remark Warning by narrative tab
    [Documentation]    Handle the company remark warning.
    Common_support.Replace xpath and select case info menu tab   Narrative
    Wait For Element Display
    Scroll into view and Input text    ${wvar('company_remark_txtbx')}    ${wvar('company_remarks')}

Handle Lateness Popup
    [Documentation]    Handle the lateness popup
    ${Satatus}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('lateness_title')}    10s
    IF    '${Satatus}' == 'True'
        Select From List By Value    ${wvar('latnes_dd_xpath')}    1
        Wait Until Element Is Visible    ${wvar('latenss_popup_submit_btn')}    10s
        Click Element    ${wvar('latenss_popup_submit_btn')}
    END

replace xpath and Page Should Contain
    [Documentation]    Verify that the page contains the specified text.
    [Arguments]    ${xpath}    ${text}
    ${new_xpath}=    Replace String     ${xpath}     replace     ${text}
    Page Should Contain Element          ${new_xpath}
    Highlight WebElement    ${new_xpath}

replace and click element with JS
    [Documentation]                     Replace xpath and click Button and wait until button not visible
    [Arguments]                         ${xpath}   ${text}
    ${Result}                           Replace String   ${xpath}      replace    ${text}
    Wait Until Keyword Succeeds    10s   2s     Scroll Element Into View    ${Result}
    Highlight WebElement    ${Result}
    Click Element Using JavaScript Xpath             ${Result}

Replace text and select case info menu tab
    [Documentation]    Replace text and select radio button
    [Arguments]        ${tab}
    ${res}   Replace String         ${wvar('menu_tab_case_info')}         replace    ${tab}
    ${check}    Run Keyword And Return Status     Wait Until Element Is Visible       ${res}     50s
    Run Keyword If   '${check}'=='False'   Wait Until Keyword Succeeds    5s   1s  Scroll Element Into View    ${res}
    Wait For Element Display
    Wait Until Keyword Succeeds    ${wvar('longwait')}  3s  Click Element        ${res}
    Wait For Element Display

handling the lateness popup
    [Documentation]    Handling the lateness popup
    Wait For Element Display
    Select From List By Value    ${wvar('lateness_reason_dropdown_xpath')}     1
    ${status}=     Run Keyword And Return Status        Wait Until Keyword Succeeds    10s  2s  Input Text     ${wvar('lateness_pop_up_input_xpath')}    test
    IF    '${status}' == 'True'
        Wait Until Keyword Succeeds    35s    6s     Wait Then Click Element    ${wvar('lateness_pop_up_submit_xpath')}
    END

moving rct to full data entry form
    [Documentation]    Moving RCT to full data entry form
    Replace xpath and wait then click element    ${wvar('tab_view_xpath')}   ${wvar('tab_view_text')}[0]
    sleep   4s
    ${in_workflow}   Get Text    ${wvar('current_workflow_xpath')}
    IF    '${in_workflow}' == 'Intake and Assessment'
        Log    Current workflow is: ${in_workflow}
        Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Actions
        ${run}   Run Keyword And Return Status     Wait Until Keyword Succeeds   10s    2s    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Complete Activity
        IF    '${run}' == 'False'
            Wait For Element Display
            Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Actions
            Wait Until Keyword Succeeds   10s    2s    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Complete Activity
        END
        sleep  4s
        ${warning_lateness}=   Run Keyword And Return Status      Element Should Be Visible    ${wvar('lateness_pop_up_input_xpath')}
        Run Keyword If     '${warning_lateness}' == 'True'    Handling The Lateness Popup
        Adding workflow notes text and select ok
    END
    IF    '${in_workflow}' == 'Review'
        Log    Current workflow is: ${in_workflow}
        Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Actions
        ${run}   Run Keyword And Return Status     Wait Until Keyword Succeeds   10s    2s    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Complete Activity
        IF    '${run}' == 'False'
            Wait For Element Display
            Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Actions
            Wait Until Keyword Succeeds   10s    2s    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Complete Activity
        END
        Adding workflow notes text and select ok
    END
    Wait Until Keyword Succeeds    35s    2s    Wait Then Click Element    ${wvar('validation_confirm_ok_xpath')}

Adding workflow notes text and select ok
    [Documentation]    Adding workflow notes text and select ok
    ${note_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('workflow_note_textarea')}    ${wvar('normalwait')}
    IF    ${note_visible}
        Input Text    ${wvar('workflow_note_textarea')}    test
        Wait For Element Display
        Click Element Using JavaScript Xpath     ${wvar('workflow_ok_btn')}
        Wait For Element Display
    END

Verify import AER data and retrieve RCT number
    [Documentation]      Verify import AER data and retrieve RCT number
    [Arguments]    ${Filename}
    ${max_retries}=    Set Variable    3
    ${retry_count}=    Set Variable    0
    FOR    ${retry_count}    IN RANGE    ${max_retries}
        Wait For Element Display
        ${dest_file}=    Set Variable   ${EXECDIR}/Resource/Json/${Filename}.json
        ${warning_yes}=   Run Keyword And Return Status      Wait Until Element Is Visible    ${wvar('modify_confirm_yes_xpath')}    4s
        Run Keyword If     ${warning_yes}     Click Element     ${wvar('modify_confirm_yes_xpath')}
        sleep  4s
        Choose File        ${wvar('new_import_aer_data')}     ${dest_file}
        Wait Until Keyword Succeeds   90s    2s   Wait Until Element Is Visible      ${wvar('action_completed_success_rct_xpath')}
        ${full_text}=    Get Text    ${wvar('action_completed_success_rct_xpath')}
        ${rct_number}=    Split String    ${full_text}    :    2
        ${rct_number}=    Strip String    ${rct_number}[2]
        Log    Extracted RCT Number: ${rct_number}
        Set Global Variable     ${rct_number_json}    ${rct_number}
        Set Test Variable    ${RCT_No}    ${rct_number}
        ${click_status}=    Run Keyword And Return Status    Wait Then Click Element    ${wvar('action_complete_success_btn_ok_xpath')}
        Run Keyword If    ${click_status}    Exit For Loop
        Log    Retry ${retry_count + 1} failed. Retrying...
        Run Keyword If    ${retry_count + 1} == ${max_retries}    Fail    Maximum retries reached. Unable to complete the process.
    END

Replace text Then Search and Select from Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    Wait For Element Display
    ${res}   Replace String            (${wvar('common_dropdown_select_xpath')})[1]     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    20s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Wait Until Keyword Succeeds    20s    1s     Click Element     ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Input Text      ${wvar('input_search_xpath')}    ${option}
    Wait Until Keyword Succeeds    10s    1s    Click Element        ${res_optn}

Selecting the product flag as Vaccine
    [Documentation]    Selecting the product flag as Vaccine
    Replace Text Then Select From Dropdown    Product Flag      ${product_flag_value}

Selecting Product Flag
    [Documentation]    Selecting the product flag as Vaccine
    [Arguments]    ${product_flag_value}
    Wait For Element Display
    Replace Xpath Then Select From Dropdown      ${wvar('product_flag_field_text')}      ${product_flag_value}
    Highlight and Replace xpath for input text    ${wvar('product_flag_field_text')}

Validate Current Stage
    [Documentation]    Validate that the current workflow stage
    [Arguments]    ${stage}
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('shortwait')}
    Highlight Workflow Status
    ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
    ${status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${workflow_label}    ${stage}
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}    
    Run Keyword If    '${status}' == 'True'
    ...    Log    Validation Success. Workflow Status is: ${workflow_label} == Expected Status: ${stage}     console=True
    ...  ELSE
    ...    Fail    Validation Fail. Workflow Status is: ${workflow_label} != Expected Status: ${stage}
    

Replace Text Then Select From Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('common_dropdown_select_xpath')}     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Wait Until Keyword Succeeds    30s    1s    Click Element        ${res}
    Sleep    2s
    Execute JavaScript    window.document.evaluate("${res}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Wait Until Keyword Succeeds    10s    2s    Click Element Using JavaScript Xpath      ${res_optn}
    sleep    2s

complete the activity
    [Documentation]    Complete the activity
    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Actions
    ${run}   Run Keyword And Return Status     Wait Until Keyword Succeeds   10s    2s    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Complete Activity
    IF    '${run}' == 'False'
         Wait For Element Display
         Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Actions
         Wait Until Keyword Succeeds   10s    2s    Replace Xpath And Wait Then Click Element         ${wvar('text_xpath')}    Complete Activity
    END
    Adding workflow notes text and select ok

Replace xpath and Scroll
    [Documentation]                     Replace xpath and Scroll
    [Arguments]                         ${xpath}  ${Value}
    ${res}                              Replace String  ${xpath}   replace   ${value}
    Wait Until Element Is Visible       ${res}      15s
    Execute JavaScript    window.document.evaluate("${res}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);

Handle NF Confirm Popup
    [Documentation]    Handle NF Confirm Popup
    ${Status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('confirmation_popup_yes')}    20s
    IF    '${Status}' == 'True'
                Click Element    ${wvar('confirmation_popup_yes')}
    END

Replace xpath Then Click NF Button
    [Documentation]     To replace xpath and Click NF Button
    [Arguments]        ${field_name}
    ${res}   Replace String            ${wvar('common_nf_field_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}

Replace xpath Then Click New NF Button
    [Documentation]     To replace xpath and Click New NF Button
    [Arguments]        ${field_name}
    ${res}   Replace String            ${wvar('common_new_nf_field_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}

Import AER data and retrieve RCT number
    [Documentation]      Import AER data and retrieve RCT number
    [Arguments]         ${file_name}
    Wait For Element Display
    ${dest_file}=    Set Variable    ${EXECDIR}${/}Resource${/}Json${/}${file_name}
    Choose File        ${wvar('new_import_aer_data')}     ${dest_file}
    Wait Until Keyword Succeeds   3m    2s   Wait Until Element Is Visible      ${wvar('action_completed_success_rct_xpath')}
    ${full_text}=    Get Text    ${wvar('action_completed_success_rct_xpath')}
    ${rct_number}=    Split String    ${full_text}    :    2
    ${rct_number}=    Strip String    ${rct_number}[2]
    Log    Extracted RCT Number: ${rct_number}
    Set Global Variable     ${rct_number_json}    ${rct_number}
    Wait Then Click Element    ${wvar('action_complete_success_btn_ok_xpath')}
    Set Test Variable    ${RCT_No}    ${rct_number}

Replace xpath and Get Text
    [Documentation]    Replace xpath and get_matching_xpath_count text
    [Arguments]        ${field_name}     
    ${res}   Replace String            ${wvar('input_box_common_field_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    ${Value}=    Get Value       ${res}
    # ${Value}=    Get Text       ${res}
    RETURN    ${Value}

Replace Xpath and Get Dropdown Value
    [Documentation]    Replace xpath and get the value of a dropdown
    [Arguments]        ${field_name}
    ${res}   Replace String            ${wvar('dropdown_value_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    ${Value}=    Get Text       ${res}
    RETURN    ${Value}

Get label of the Dropdown
    [Documentation]     To replace xpath and get the label of a dropdown
    [Arguments]        ${field_name}
    ${res}   Replace String            ${wvar('dropdown_label_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    Wait Until Element Is Visible       ${res}     30s
    ${label}=    Get Element Attribute    ${res}    aria-label
    Log    Dropdown label for ${field_name} is: ${label}
    RETURN    ${label}

Select Patient Tab
    [Documentation]    Select the Patient tab
    Replace xpath and select case info menu tab    Patient
    Replace xpath and Highlight Case info menu Tab    Patient

Select Reporter Tab
    [Documentation]    Select the Reporter tab
    Replace xpath and select case info menu tab    Reporter
    Replace xpath and Highlight Case info menu Tab    Reporter

Select Study Tab
    [Documentation]    Select the Study tab
    Replace xpath and select case info menu tab    Study
    Replace xpath and Highlight Case info menu Tab    Study

Select Product Tab
    [Documentation]    Select the Product tab
    Replace xpath and select case info menu tab    Product(s)
    Replace xpath and Highlight Case info menu Tab    Product(s)

Select Causality Tab
    [Documentation]    Select the Causality tab
    Replace xpath and select case info menu tab    Causality
    Replace xpath and Highlight Case info menu Tab    Causality

Select Labeling Tab
    [Documentation]    Select the Labeling tab
    Replace xpath and select case info menu tab    Labeling
    Replace xpath and Highlight Case info menu Tab    Labeling

Select Source Tab
    [Documentation]    Select the Source tab
    Replace xpath and select case info menu tab    Source
    Replace xpath and Highlight Case info menu Tab    Source

Select Narrative Tab
    [Documentation]    Select the Narrative tab
    Replace xpath and select case info menu tab    Narrative
    Replace xpath and Highlight Case info menu Tab    Narrative

Select Event Tab
    [Documentation]    Select the Event tab
    Replace xpath and select case info menu tab    Event(s)
    Replace xpath and Highlight Case info menu Tab    Event(s)
    
Fetch The AER No
    [Documentation]    Fetch the AER Number
    Wait Until Element Is Visible    ${wvar('aer_no_label_xpath')}   timeout=${wvar('normalwait')}
    ${AER_No}=    Get Text    ${wvar('aer_no_label_xpath')}
    RETURN    ${AER_No}

Fetch RCT No From Case 
    [Documentation]    Fetch the RCT Number from the case
    Wait for Element display
    Wait Until Element Is Visible    ${wvar('rct_xpath')}    timeout=${wvar('shortwait')}
    ${rct}=    Get Text    ${wvar('rct_xpath')}
    Set Test Variable	${RCT_No}	${rct}
    RETURN    ${RCT_No}

Select Product Characterization From Product Tab
    [Documentation]    Select Product Characterization
    [Arguments]    ${product_characterization}
    IF    '${product_characterization}' == 'Blank'
        ${product_characterization}=    Set Variable    --Select--
    END
    Replace Xpath Then Select From Dropdown     Product Characterization     ${product_characterization}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('product_categrization_yes_btn_xpath')}    4s
    IF    '${status}' == 'True'
        Click Element Custom    ${wvar('product_categrization_yes_btn_xpath')}
    END
    Replace Xpath and Highlight Text Box    Product Characterization

Delete Event
    [Documentation]    Delete the Event
    Click Element Custom    ${wvar('delete_event_btn_xpath')}
    Click Element Custom    ${wvar('confirmation_popup_yes')}

Go To Event Tab
    [Documentation]    Go to the Event tab
    Replace xpath and select case info menu tab    Event(s)
    Replace xpath and Highlight Case info menu Tab    Event(s)

Create Event    
    [Documentation]    Create a new event
    [Arguments]    ${event_number_list}    ${Seriousness_Value_value}    ${Outcome_Value_value}    
    ${converted_event_number_list}=    Convert Comma Separated String To List    ${event_number_list}
    Log    ${converted_event_number_list}
    ${index}=    Set Variable    1
    ${list_length}=    Get Length    ${converted_event_number_list}
    FOR    ${event_number}    IN    @{converted_event_number_list}
        Log    ${event_number}
        Wait Until Element Is Visible    ${wvar('event_meddra_llt_code_text_box_xpath')}
        Replace Xpath and Highlight Text Box    Event MedDRA LLT Code
        Replace Xpath and Highlight Text Box    ${wvar('reported_term_field_text')}
        Click Element Custom   ${wvar('event_meddra_llt_code_lookup_icon_xpath')}
        Click Element Custom   ${wvar('dictionary_term_code_txt_bx_xpath')}        
        Input Text    ${wvar('dictionary_term_code_txt_bx_xpath')}    ${event_number}        
        Wait For Element Display
        ${basic_radio_btn__status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('event_directory_basic_radio_btn_xpath')}
        IF    '${basic_radio_btn__status}' == 'False'
            Click Element Custom   ${wvar('basic_radio_btn_xpath')}
        END
        Click Element Custom   ${wvar('event_search_button_xpath')}
        ${event_dictionary_code_xpath}=    Replace String     ${wvar('event_dictionary_code_list_code_xpath')}    replace    ${event_number}
        Wait Until Element Is Visible    ${event_dictionary_code_xpath}    ${wvar('normalwait')}        
        Click Element Custom    ${wvar('event_dictionary_code_ok_xpath')}
        Wait For Element Display        
        Highlight and Replace xpath for input text    ${wvar('reported_term_field_text')}
        Take Screenshot    selenium
        Replace Xpath And Select Radio Button                 ${wvar('seriousness_field_text')}   ${Seriousness_Value_value}
        Replace xpath and Highlight radio button title    ${wvar('seriousness_field_text')}   ${Seriousness_Value_value}        
        Replace xpath Then Select from Dropdown    ${wvar('outcome_field_text')}    ${Outcome_Value_value}
        Replace xpath Then Highlight Dropdown    ${wvar('outcome_field_text')}
        # Take Screenshot    selenium
        
        IF    '${index}' != '${list_length}'
            Add Event
            Wait For Element Display  
        END         
        ${index}=    Evaluate    ${index} + 1
    END

Create Event ONLY
    [Documentation]    Create a new event
    [Arguments]    ${reported_term_value}  
    Replace Xpath and Highlight Text Box    ${wvar('reported_term_field_text')}
    Replace Xpath And Input Text    ${wvar('reported_term_field_text')}   ${reported_term_value}
    Wait For Element Display
    Replace Xpath And Click Element      ${wvar('tabview_xpath')}     ${reported_term_value}

Create Event ONLY Latest
    [Documentation]    Create a new event
    [Arguments]    ${reported_term_value}  
    Replace Xpath and Highlight Text Box    ${wvar('reported_term_field_text')}
    Replace Xpath And Input Text    ${wvar('reported_term_field_text')}   ${reported_term_value}
    Wait For Element Display
    Replace Xpath And Click Element      ${wvar('event_tabview_xpath')}     ${reported_term_value}

Add Event As Per Description
    [Documentation]    Add a new event as per the description
    [Arguments]    ${event_description}
    Add Event
    Wait For Element Display
    Create Event ONLY Latest    ${event_description}

Select Event From Event Tab
    [Documentation]    Select an event from the event tab
    [Arguments]    ${event_title}
    Log    ${event_title}
    ${events_titles_xpath}=    Get WebElements    ${wvar('event_title_bar_events_xpaths')}
    FOR    ${event_title_xpath}    IN    @{events_titles_xpath}
        ${Event_text}=    Get Text From Dynamic Element    ${event_title_xpath}
        Log    ${Event_text}
        ${status}=    Check String In String    ${Event_text}    ${event_title}    
        IF    '${status}' == 'True'    
            Click Element Custom    ${event_title_xpath}
        END        
    END

Add Event 
    [Documentation]    Add a new event
    Click Element Custom    ${wvar('add_event_btn_xpath')}

Replace Xpath and Highlight Text Box
    [Documentation]    Highlight the text box for the given field
    [Arguments]    ${field_name}
    ${res}   Replace String            ${wvar('text_bx_highlighting_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Highlight WebElement    ${res} 

Save RCT
    [Documentation]    Save the RCT
    Click Element Custom    ${wvar('save_btn_xpath')}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('validation_confirm_ok_button_xpath')}    ${wvar('normalwait')}    
    WHILE    '${status}' == 'False'    limit=3
        Click Element Custom    ${wvar('save_btn_xpath')}
        ${status1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('validation_confirm_ok_button_xpath')}    ${wvar('normalwait')}    
        IF    '${status1}' == 'True'
            Take Screenshot    selenium  
            Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}
        END
    END
    IF    '${status}' == 'True'
        Take Screenshot    selenium  
        Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}
    END

Save RCT Without Screenshot
    [Documentation]    Save the RCT and take screenshot
    Click Element Custom    ${wvar('save_btn_xpath')}
    Wait Until Element Is Visible    ${wvar('validation_confirm_ok_button_xpath')}    ${wvar('longwait')}    
    Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}
    Wait For Element Display    

Replace xpath and Get Text from Attribute
    [Documentation]    Replace xpath and get_matching_xpath_count text
    [Arguments]        ${field_name}       ${element}  
    ${res}   Replace String            ${wvar('input_box_common_field_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    ${Value}=    Get Element Attribute       ${res}    ${element}  
    RETURN    ${Value}

Replace xpath and Get Text from dropdown label
    [Documentation]    Replace xpath and get_matching_xpath_count text
    [Arguments]        ${field_name}     
    ${res}   Replace String            ${wvar('patient_info_dt_dd_stage')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    ${Value}=    Get Text       ${res}
    RETURN    ${Value}

Input Value In Nullfy Input or DropDown Field
    [Documentation]    Input Value In Nullfy Input or DropDown Field
    [Arguments]        ${field_name}      ${value}
    Log    ${field_name}   
    Log    ${value}
    @{nullfy_dd_values}    Create List    Unknown    Not Asked    Asked but Unknown    Asked But Unknown
    ${result}=    Evaluate    '${value}' not in @{nullfy_dd_values}
    IF    '${result}' == 'True'
        ${res}   Replace String            ${wvar('contains_input_txt_box_xpath')}     replace    ${field_name}
        Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
        Wait Until Element Is Visible       ${res}     30s
        Input Text       ${res}    ${value}
        Wait For Element Display
        Press Keys       ${res}    ENTER
        # Wait For Element Display    
    END    
    ${result}=    Evaluate    '${value}' in @{nullfy_dd_values}
    IF    '${result}' == 'True'
        ${status}=    Run Keyword And Return Status    Replace Xpath and Click Element    ${wvar('nullyfy_img_btn_xpath')}    ${field_name}
        IF    '${status}' == 'False'
            Reduce Window Size Web Support    75%      
            Replace Xpath and Click Element    ${wvar('nullyfy_img_btn_xpath')}    ${field_name}
            Reduce Window Size Web Support    100%      
        END
        Replace Xpath Then Select Value from Nullfy Dropdown    ${field_name}      ${value}
    END

Replace Xpath Then Select Value from Nullfy Dropdown
    [Documentation]    Replace xpath and select value from nullify dropdown
    [Arguments]         ${field_name}    ${option}
    ${res}   Replace String            ${wvar('nullfy_dropdown_trigger_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Handle Reporter Country and Region
    [Documentation]    Handle the reporter's country and region
    [Arguments]    ${Country}    ${Region}
    Replace xpath and select case info menu tab    ${wvar('reporter_txt')}
    Wait for Element display
    Replace xpath Then Select from Dropdown    ${wvar('country_field_text')}     ${Country}
    Replace xpath Then Highlight Dropdown    ${wvar('country_field_text')}     
    # Replace Text Then Select From Dropdown     Country     UNITED STATES OF AMERICA ( USA ) 
    Replace xpath Then Select from Dropdown     ${wvar('regional_state_field_one_text')}     ${Region}
    Replace xpath Then Highlight Dropdown    ${wvar('regional_state_field_one_text')} 

Replace xpath contains Then Select from Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('contains_common_dropdown_select_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Upload AER Data
    [Documentation]     Upload AER Data
    [Arguments]   ${RCT_Json_Path}
    User navigated to the Case Listing module under Case Management   
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('normalwait')}
    # ${RCT_Json_Path}=    Set Variable    ${EXECDIR}/Resource/Json/final_review_stage_RCT.json
    Click Element Custom    ${wvar('new_button_xpath')}
    Choose File    ${wvar('import_aer_data_xpath')}    ${RCT_Json_Path}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}     ${wvar('normalwait')}
    Wait Until Element Is Visible    ${wvar('rct_txt_xpath')}    ${wvar('normalwait')}
    ${RCT_scuccess_msg}=    Get Text     ${wvar('rct_txt_xpath')}
    Log To Console    ${RCT_scuccess_msg}
    Wait Until Element Is Visible    ${wvar('action_complete_success_btn_ok_xpath')}    ${wvar('longwait')}
    ${RCT_No}=    Extract Rct Number    ${RCT_scuccess_msg}
    Click Element Custom    ${wvar('action_complete_success_btn_ok_xpath')}
    Set Test Variable    ${RCT_No}        
    RETURN    ${RCT_No}

Wait For General Tab
    [Documentation]    Replace xpath and select radio button
    # [Arguments]        ${tab}
     ${tab}=    Set Variable    General
    ${res}   Replace String         ${wvar('menu_tab_case_info')}         replace    ${tab}
    ${check}    Run Keyword And Return Status     Wait Until Element Is Visible       ${res}     30s
    Run Keyword If   '${check}'=='False'   Wait Until Keyword Succeeds    5s   1s  Scroll Element Into View    ${res}  

Move RCT Stage from Intake and Assignment to Target Stage
    [Documentation]     Move RCT Stage from Intake to Case
    [Arguments]    ${RCT_No}    ${Target_Stage}   
    # Wait for the loading image to disappear
    Complete confirmation Activity
    Search for RCT Latest    ${RCT_No}
    Wait For General Tab
    # Wait for the workflow status to be visible and Get Workflow label
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
    ${workflow_label}=    Wait Until Keyword Succeeds    10s    1s    Get Text    ${wvar('workflow_status_xpath')}
    Log To Console    Workflow Status is: ${workflow_label}   
    # this while loop will keep checking the workflow status if the worklabel is Full Data Entry then it will break
    WHILE    ${True}      
        Wait For General Tab
        Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
        ${workflow_label}=    Wait Until Keyword Succeeds    10s    1s    Get Text    ${wvar('workflow_status_xpath')}
        Log To Console    Workflow Status is: ${workflow_label}   
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
        ${workflow_label}=    Wait Until Keyword Succeeds    10s    1s    Get Text    ${wvar('workflow_status_xpath')}
        IF    '${workflow_label}' == '${Target_Stage}'
            Log To Console    Workflow is in ${workflow_label} stage
            BREAK
        ELSE
            ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('dl_error_msg_xpath')}    20s
            Run Keyword If    '${status}' == 'True'    Handle DL Error Message    ${RCT_No}
            Complete confirmation Activity
            Search for RCT Latest    ${RCT_No}
            Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
        END  
    END

Move RCT Stage To Distribute Stage
    [Documentation]     Move RCT Stage To Distribute Stage
    [Arguments]    ${RCT_No}   
    Complete confirmation Activity
    Search for RCT Latest    ${RCT_No}
    Wait For General Tab
    # Wait for the workflow status to be visible and Get Workflow label
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
    ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
    Log To Console    Workflow Status is: ${workflow_label}   
    # this while loop will keep checking the workflow status if the worklabel is Full Data Entry then it will break
    WHILE    ${True}      
        Wait For General Tab
        Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
        ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
        Log To Console    Workflow Status is: ${workflow_label}   
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
        # ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
        IF    '${workflow_label}' == 'Distribute Transit'
            Log To Console    Workflow is in Distribute stage
            BREAK        
        ELSE
            Complete confirmation Activity    
            Search for RCT Latest    ${RCT_No}
            Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('longwait')}
        END  
    END

Complete confirmation Activity In DT Stage
    [Documentation]    Complete confirmation Activity
    [Arguments]    ${RCT_No}
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
    Click Element Custom    ${wvar('actions_xpath')}
    Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
    Wait for Element display        
    Wait for Element display    
    ${status}=    Run Keyword And Return Status    Click Element Custom    ${wvar('complete_activity_xpath')}
    WHILE    '${status}' == 'False'    limit=3
        Wait for Element display
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
        Click Element Custom    ${wvar('actions_xpath')}
        Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
        Wait for Element display        
        Wait for Element display    
        ${status}=    Run Keyword And Return Status    Click Element Custom    ${wvar('complete_activity_xpath')}
        IF    '${status}' == 'True'
            BREAK
        END
    END 
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('dl_error_msg_xpath')}    10s
    Run Keyword If    '${status}' == 'True'    Handle DL Error Message    ${RCT_No}
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('dl_error_msg_xpath')}    10s
    Run Keyword If    '${status}' == 'True'    Handle DL Error Message    ${RCT_No}
    Handle Lateness Popup
    # Handle warning saving Confirm Popup 
    Wait Until Element is Visible    ${wvar('pass_ok_button_xpath')}    ${wvar('longwait')}
    Take Screenshot    selenium
    Click Element Custom    ${wvar('pass_ok_button_xpath')}
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    ${status}=    Run Keyword And Return Status    Wait Until Element is Visible    ${wvar('validation_confirm_ok_button_xpath')}    ${wvar('shortwait')}
    IF    '${status}' == 'False'
        User navigated to the Case Listing module under Case Management   
    ELSE    
        Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}
    END

Handle DL Error Message
    [Documentation]    Handle DL Error Message
    [Arguments]    ${RCT_No}
    Capture Page Screenshot
    Click Element Custom    ${wvar('dl_error_msg_xpath')}
    Wait For Element Display
    Capture Page Screenshot
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
    # IF    '${TEST_NAME}' == 'LSMV_Auto-Calculator_PULSE-CDDR41_Event_Onset_Date_End_Date'
    #     The User navigates to the Case Listing module under Case Management
    # END
    The User navigates to the Case Listing module under Case Management
    Search for RCT Latest    ${RCT_No}
    Click Element Custom    ${wvar('actions_xpath')}
    Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
    Wait for Element display        
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('dl_error_msg_xpath')}    10s
    WHILE    '${status}' == 'True'    limit=6
        Click Element Custom    ${wvar('dl_error_msg_xpath')}        
        Sleep    30s
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
        Click Element Custom    ${wvar('actions_xpath')}
        Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}    
        Wait for Element display        
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('unlocked_label_xpath')}    10s
        IF    '${status}' == 'True'
            The User navigates to the Case Listing module under Case Management   
            Search for RCT Latest  ${RCT_No}
            Wait For General Tab
            BREAK
        ELSE
            Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
            Wait Until Element Is Not Visible    ${wvar('classify_success_msg_xpath')}    ${wvar('normalwait')}
            Click Element Custom    ${wvar('actions_xpath')}
            Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('longwait')}  
            Click Element Custom    ${wvar('complete_activity_xpath')}  
            Wait for Element display        
        END
    END

Add Product Button
    [Documentation]    Click on the Add Product button
    Click Element Custom    ${wvar('add_product_button_xpath')}
    Wait For Element Display

product description field for CDDR20
    [Documentation]    filling the product description field
    [Arguments]    ${product_descrip_value}    ${radio_button}    
    Replace text and click element the search icon    ${wvar('product_description_field_text')}
    IF    '${radio_button}' == 'WHO DD'
        Wait Until Element Is Visible    ${wvar('product_radio_btns_xpath')}    ${wvar('shortwait')}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('whodd_radio_checked_xpath')}    10s
        IF    '${status}' == 'False'
            Click Element Custom    ${wvar('who_dd_radio_xpath')}
        END        
        Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                
        Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('product_lookup_search_btn')}
        ${first_pd_radio_btn_xpath}=    Replace String     ${wvar('first_pd_radio_btn_xpath')}    replace    ${product_descrip_value}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${first_pd_radio_btn_xpath}    ${wvar('shortwait')}
        WHILE    '${status}' == 'False'    limit=5
            Wait For Element Display
            Scroll Element Into View     ${wvar('product_lookup_search_btn')}                        
            ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${first_pd_radio_btn_xpath}    ${wvar('shortwait')}
            IF    '${status}' == 'True'
                Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}                      
            END
        END
        IF    '${status}' == 'True'
            Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}                      
        END
        Scroll then Click button    ${wvar('pd_selected_ok_button')}
        ${status1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('change_product_confirmation_dialog_xpath')}    10s
        IF    '${status1}' == 'True'
            Click Element Custom    ${wvar('change_product_confirmation_dialog_xpath')}
        END
        Wait For Element Display
        Wait For Element Display
        Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
        Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
        Replace Xpath and Highlight Text Box    Company Product
    ELSE    
        Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                
        Replace text contains then search and select from dropdown in pd     ${wvar('authorization_country_field_text')}   ${wvar('authorization_country_field_optn')}    
        Wait For Element Display
        Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('search_btn_product_desptn')}
        Wait For Element Display
        ${res}  Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('pd_radio_btn_xpath')}  ${product_descrip_value}
        IF    '${res}' == 'False'
                Wait For Element Display
                Scroll Element Into View     ${wvar('search_btn_product_desptn')}
                Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
                Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
        ELSE
                Scroll then Click button    ${wvar('pd_selected_ok_button')}
        END
        Wait For Element Display
        Wait For Element Display
        Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
        Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
        Replace Xpath and Highlight Text Box    Company Product
    END

Select Product By inputing Product Name
    [Documentation]    filling the product description field
    [Arguments]    ${product_descrip_value}    ${radio_button}   
    IF       '${radio_button}' != 'Blank'
        Replace text and click element the search icon    ${wvar('product_description_field_text')}    
    END
    IF    '${radio_button}' == 'WHO DD'
        Wait Until Element Is Visible    ${wvar('product_radio_btns_xpath')}    ${wvar('shortwait')}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('whodd_radio_checked_xpath')}    10s
        IF    '${status}' == 'False'
            Click Element Custom    ${wvar('who_dd_radio_xpath')}
        END        
        Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                
        Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('product_lookup_search_btn')}
        ${first_pd_radio_btn_xpath}=    Replace String     ${wvar('first_pd_radio_btn_xpath')}    replace    ${product_descrip_value}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${first_pd_radio_btn_xpath}    ${wvar('shortwait')}
        WHILE    '${status}' == 'False'    limit=5
            Wait For Element Display
            Scroll Element Into View     ${wvar('product_lookup_search_btn')}                        
            ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${first_pd_radio_btn_xpath}    ${wvar('shortwait')}
            IF    '${status}' == 'True'
                Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}                      
            END
        END
        IF    '${status}' == 'True'
            Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}
        END
        Scroll then Click button    ${wvar('pd_selected_ok_button')}
        ${status1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('change_product_confirmation_dialog_xpath')}    10s
        IF    '${status1}' == 'True'
            Click Element Custom    ${wvar('change_product_confirmation_dialog_xpath')}
        END
        Wait For Element Display
        Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
        Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
        Replace Xpath and Highlight Text Box    Company Product
        
        # ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('whodd_radio_checked_xpath')}    10s
        # IF    '${status}' == 'False'
        #     Click Element Custom    ${wvar('who_dd_radio_xpath')}
        # END        
        # Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                
        # Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('product_lookup_search_btn')}
        # ${res}  Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}        
        # IF    '${res}' == 'False'
        #     Wait For Element Display
        #     Scroll Element Into View     ${wvar('search_btn_product_desptn')}
        #     Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
        #     Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
        # ELSE
        #     Scroll then Click button    ${wvar('pd_selected_ok_button')}
        #     ${status1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('change_product_confirmation_dialog_xpath')}    10s
        #     IF    '${status1}' == 'True'
        #         Click Element Custom    ${wvar('change_product_confirmation_dialog_xpath')}
        #     END
        # END
        # Wait For Element Display
        # Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
        # Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
        # Replace Xpath and Highlight Text Box    Company Product
    ELSE    
        IF    '${radio_button}' == 'Blank'
            IF    '${product_descrip_value}' == 'Blank'
                Wait For Element Display
                Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
                Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
                Replace Xpath and Highlight Text Box    Company Product
                Highlight and Replace xpath for input text    ${wvar('product_name_as_reported_text')}   
            ELSE
                Wait For Element Display
                Highlight and Replace xpath for input text    ${wvar('product_name_as_reported_text')}   
                Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
                Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
                Replace Xpath and Highlight Text Box    Company Product
                Replace xpath and input text    ${wvar('product_name_as_reported_text')}    ${product_descrip_value}
            END
        ELSE
            Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                        
            Wait For Element Display
            Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('search_btn_product_desptn')}
            Wait For Element Display
            ${res}  Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('pd_radio_btn_xpath')}  ${product_descrip_value}
            IF    '${res}' == 'False'
                ${res1}=    Run Keyword And Return Status    Click Element Custom    ${wvar('search_btn_product_desptn')}
                ${res}=      Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}
            END
            IF    '${res}' == 'False'
                Wait For Element Display
                Scroll Element Into View     ${wvar('search_btn_product_desptn')}
                Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
                Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
            ELSE
                Scroll then Click button    ${wvar('pd_selected_ok_button')}
            END
            Wait For Element Display
            Replace Xpath and Highlight Text Box    ${wvar('product_description_field_text')}
            Replace Xpath and Highlight Text Box    ${wvar('product_flag_field_text')}
            Replace Xpath and Highlight Text Box    Company Product
        END
    END


Delete Product
    [Documentation]    Delete a product
    Click Element Custom    ${wvar('product_tab_delete_btn_xpath')}
    Click Element Custom    ${wvar('confirm_delete_btn_xpath')}

Select Reporter Type From General Screen
    [Documentation]    Select the reporter type from the general screen
    [Arguments]    ${report_type_option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${wvar('reporter_type_text_bx_highlighting_xpath')}
    Highlight WebElement    ${wvar('reporter_type_text_bx_highlighting_xpath')}
    Replace xpath Then Select from Dropdown    ${wvar('report_type_text')}    ${report_type_option}

Replace Text And Get DropDown Label Text
    [Documentation]    Replace text in a dropdown and get the label text
    [Arguments]    ${field_name}
    ${res}   Replace String            ${wvar('common_dropdown_label_xpath')}     replace    ${field_name}
    Scroll Element Into View    ${res}    
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    ${text}=    Get Element Attribute    ${res}    aria-label
    RETURN    ${text}

Reclassify the complaint in LSMV Application
    [Documentation]    Reclassify a complaint
    Click element custom    ${wvar('data_assessment_tab_xpath')}
    Wait For Element Display
    Click Element Custom    ${wvar('reclassify_btn_xpath')}   
    Click Element Custom    ${wvar('reclassify_confirm_btn_xpath')}
    Wait For Element Display

Handle Warning Confirm Yes Popup 
    [Documentation]    Handle confirm popup if it appears
    Wait for Element display       
    #Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('normalwait')}
    ${is_popup_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('warning_confirmation_popup_xpath')}    timeout=90s
    IF    '${is_popup_present}' == 'True'
        Click Element Custom    ${wvar('warning_confirmation_popup_yes_xpath')}    
    END 

Set Patient DOB In Patient Tab
    [Documentation]    Enter the patient's date of birth
    [Arguments]    ${dob}
    Select Date        ${wvar('patient_dob_txt')}   ${dob}
    Highlight and Replace xpath for input text    ${wvar('patient_dob_txt')}

Set Patient Date of Death In Patient Tab
    [Documentation]    Enter the patient's date of death
    [Arguments]    ${dod}
    IF    '${dod}' == 'Not Asked' or '${dod}' == 'Asked but Unknown'
        Input Value In Nullfy Input or DropDown Field    ${wvar('date_of_death_text')}    ${dod}   
        Highlight and Replace xpath for input text    ${wvar('date_of_death_text')} 
    ELSE    
        ${date_of_death}=    Fetch Date By Expected Days From Today    ${dod}
        Select Date        ${wvar('date_of_death_text')}   ${date_of_death}
        Highlight and Replace xpath for input text    ${wvar('date_of_death_text')}
    END

Enter Patient Age In Patient Tab
    [Documentation]    Enter the patient's age
    [Arguments]    ${age}
    Input Text    ${wvar('patient_age_txt')}    ${age}
    Highlight and Replace xpath for input text    ${wvar('patient_age_txt')}

Set Autopsy Done Value
    [Documentation]    This will the Autopsy Radio Button
    [Arguments]    ${autopsy_value}
    Log    ${autopsy_value}
    ${reported_cause_death}=     Replace String    ${wvar('internal_tab_headers')}    replace    ${wvar('reported_cause_of_death_text')}
    Click Element Custom    ${reported_cause_death}
    Highlight and Replace xpath for input text    Autopsy Done?
    IF    '${autopsy_value}' == 'Blank'
        Log    Autopsy Value set to blank   console=True
    ELSE
        IF    '${autopsy_value}' == 'Yes'
            JS Toggle PrimeNG Checkbox    locator=${wvar('autopsy_manual_checkbox_box_xpath')}    desired_state=true            
            Wait for Element display
            ${autopsy_value}=    Set Variable    1
            ${autopsy_radio_bt}=    Replace String    ${wvar('autopsy_radio_bt_xpath')}    replace    ${autopsy_value}
            Scroll Element Into View    ${autopsy_radio_bt}
            Click Element Custom    ${autopsy_radio_bt}
            Log    Autopsy Value set to Yes
        END
        IF    '${autopsy_value}' == 'No'
            JS Toggle PrimeNG Checkbox    locator=${wvar('autopsy_manual_checkbox_box_xpath')}    desired_state=true
            Wait for Element display
            ${autopsy_value}=    Set Variable    2
            ${autopsy_radio_bt}=    Replace String    ${wvar('autopsy_radio_bt_xpath')}    replace    ${autopsy_value}
            Scroll Element Into View    ${autopsy_radio_bt}
            Click Element Custom    ${autopsy_radio_bt}
            Log    Autopsy Value set to No
        END
        IF    '${autopsy_value}' == 'Unknown' or '${autopsy_value}' == 'Asked But Unknown' or '${autopsy_value}' == 'Not Asked'
            IF  '${autopsy_value}' == 'Asked But Unknown'
                ${autopsy_value}=    Set Variable    Asked ${SPACE}But Unknown
            END 
            JS Toggle PrimeNG Checkbox    locator=${wvar('autopsy_manual_checkbox_box_xpath')}    desired_state=true
            Wait for Element display
            Click Element Custom    ${wvar('autopsy_null_flavor_icon_xpath')}
            Wait for Element display
            Click Element Custom    ${wvar('autopsy_dropdown_trigger_xpath')}
            Wait Until Element Is Visible    ${wvar('p_dropdown_item_xpath')}    ${wvar('shortwait')}
            ${p_dropdown_items_xpath}=    Get WebElements    ${wvar('p_dropdown_item_xpath')}
            FOR    ${item}    IN    @{p_dropdown_items_xpath}
                ${item_text}=    Get Element Attribute    ${item}    aria-label
                Log    ${item_text}
                ${Status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${item_text}    ${autopsy_value}    ignore_case=True    strip_spaces=True
                IF    '${Status}' == 'True'
                    Click Element Custom    ${item}
                    BREAK
                END
            END            
            Log    Autopsy Value set to ${autopsy_value}
        END
    END

Select Outcome From Event Tab
    [Documentation]    Select the outcome from the event tab
    [Arguments]    ${outcome_value}
    Replace xpath Then Select from Dropdown    ${wvar('outcome_field_text')}    ${outcome_value}
    Highlight and Replace xpath for input text    ${wvar('outcome_field_text')}

Set Death radio button From Event Tab
    [Documentation]    Set the seriousness from the event tab
    [Arguments]    ${Death_Value}    
    Replace xpath and click element    ${wvar('subtabs_xpath')}    ${wvar('event_seriousness_field_text')}    
    Replace Xpath And Select Radio Button                 ${wvar('death_field_text')}   ${Death_Value}
    Replace xpath and Highlight radio button title    ${wvar('death_field_text')}   ${Death_Value}    

Validate Death Radio Button Selection Option
    [Documentation]    Validate the selection of the death radio button
    [Arguments]    ${Death_Value}
    Replace xpath and click element    ${wvar('subtabs_xpath')}    ${wvar('event_seriousness_field_text')}    
    ${death_radio_button_xpath}=    Replace String    ${wvar('radio_btn_xpath')}    replace    ${wvar('death_field_text')}
    ${death_option_xpath}=    Replace String    ${death_radio_button_xpath}    option    ${Death_Value}
    Replace xpath and Highlight radio button title    ${wvar('death_field_text')}   ${Death_Value}    
    # ${status}=    Run Keyword And Return Status    Element Should Be Visible    ${death_option_xpath}    
    # Run Keyword If    '${status}' == 'True'
    # ...    Log    Validation Success. Death radio button with value ${Death_Value} is visible.
    # ...  ELSE
    # ...    Fail    Validation Fail. Death radio button with value ${Death_Value} is not visible.

Validate Sender Organization In General Tab
    [Documentation]    Validate the sender organization in the general tab
    [Arguments]    ${Sender_Organization_value}
    Highlight and Replace xpath for input text    ${wvar('sender_organization_as_coded_field_text')}
    ${act_sender_org_value}=    Get Element Attribute    ${wvar('sender_organization_field_value_xpath')}    value
    Should Be Equal As Strings    ${act_sender_org_value}    ${Sender_Organization_value}

Validate Company Unit In General Tab
    [Documentation]    Validate the company unit in the general tab
    [Arguments]    ${Company_Unit_value}
    Highlight and Replace xpath for input text    ${wvar('company_unit_field_text')}
    ${act_company_unit_value}=    Get Element Attribute    ${wvar('company_unit_dropdown_xpath')}    aria-label
    Should Be Equal As Strings    ${act_company_unit_value}    ${Company_Unit_value}

Validate Report Type In General Tab
    [Documentation]    Validate the report type in the general tab
    [Arguments]    ${Report_Type_value}
    Highlight and Replace xpath for input text    ${wvar('report_type_text')}   
    Scroll Element Into View     ${wvar('report_type_aria_label')}
    ${act_report_type_value}=    Get Element Attribute    ${wvar('report_type_aria_label')}    aria-label
    Should Be Equal As Strings    ${act_report_type_value}    ${Report_Type_value} 

Validate Patient DOB In Patient Tab
    [Documentation]    Validate the patient date of birth in the patient tab
    [Arguments]    ${Patient_DOB_value}
    Highlight and Replace xpath for input text    ${wvar('patient_dob_calender_title')}   
    Scroll Element Into View     ${wvar('patient_dob_aria_label_xpath')}
    ${act_patient_dob_value}=    Get Element Attribute    ${wvar('patient_dob_aria_label_xpath')}    aria-label
    Should Be Equal As Strings    ${act_patient_dob_value}    ${Patient_DOB_value} 

Validate Reported Term In Event Tab
    [Documentation]    Validate the reported term in the event tab
    [Arguments]    ${Event_value}
    Highlight and Replace xpath for input text    ${wvar('reported_term_field_text')}   
    Scroll Element Into View     ${wvar('reported_term_input_xpath')}
    ${act_event_value}=    Get Element Attribute    ${wvar('reported_term_input_xpath')}    title
    Should Be Equal As Strings    ${act_event_value}    ${Event_value}    

Validate Outcome On Event Tab
    [Documentation]    Validate the outcome in the event tab
    [Arguments]    ${Outcome_value}
    Highlight and Replace xpath for input text    ${wvar('outcome_field_text')}   
    Scroll Element Into View     ${wvar('outcome_combobox_xpath')}
    ${act_outcome_value}=    Get Text    ${wvar('outcome_combobox_xpath')}
    # ${act_outcome_value}=    Get Element Attribute    ${wvar('outcome_combobox_xpath')}    title
    Should Be Equal As Strings    ${act_outcome_value}    ${Outcome_value}  

Set Source, Reference Type And reference Number In Source Tab
    [Documentation]    Set the source, reference type, and reference number
    [Arguments]    ${source}    ${reference_type}    ${reference_number}
    Replace xpath Then Select from Dropdown    ${wvar('source_text')}    ${source}
    Highlight and Replace xpath for Unique input text    ${wvar('source_text')}
    Replace xpath Then Select from Dropdown    ${wvar('reference_type_text')}    ${reference_type}
    Highlight and Replace xpath for input text    ${wvar('reference_type_text')}
    Replace xpath and input text    ${wvar('reference_number_text')}    ${reference_number}
    Highlight and Replace xpath for input text    ${wvar('reference_number_text')} 

Save And exit Case
    [Documentation]    Save and exit the case
    Click Element Custom    ${wvar('save_exit_btn_xpath')}
    Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}

Show Work Flow Activity History
    [Documentation]    Show the workflow activity history
    Click Element Custom    ${wvar('more_options_xpath')}
    Click Element Custom    ${wvar('ae_workflow_activity_tracking_xpath')}
    Wait For Element Display
    Wait Until Element Is Visible    ${wvar('workflow_activity_tracking_grid_xpath')}    ${wvar('normalwait')}
    Take Screenshot    selenium
    Click Element Custom    ${wvar('close_workflow_tracking_btn_xpath')} 

Verify json import and retrieve RCT number for CDDR-11 in final review workflow
    [Documentation]    Verify Json Import And Retrieve RCT Number
    # ${aer}=    Upload AER Data    ${EXECDIR}/Resource/Json/therapy_auto_calc_validation.json
    ${aer}=    Upload AER Data    ${EXECDIR}/Resource/Json/11_check.json
    Search for AER    ${aer}
    RETURN   ${aer}    

Select dates
    [Documentation]    Enter Start Date
    [Arguments]     ${field_name}   ${date}
    ${res}                              Replace String  ${wvar('common_date_input_field_xpath')}   replace   ${field_name}
    Wait Until Element Is Visible       ${res}  40s
    Scroll Element Into View            ${res}
#    ${CURRENT_DATE}       Get Current Date    result_format=%d-%m-%Y
    Input Text            ${res}             ${date}
    # click Element       ${wvar('close_date_picker_xpath')}
    # sleep    2s
    # SeleniumLibrary.Press Keys          None    ENTER
    # sleep    2s
    # Click Element       ${res}

Replace Xpath and select from dropdown
    [Documentation]     To replace xpath and highlight a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('common_dropdown_select_xpath')}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res_optn}
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

New Create RCT for CDDR11_1
    [Documentation]    New Create RCT for CDDR11_1
    [Arguments]   ${company_unit_value}    ${sender_organisation_value}    ${Latest_received_date_value}   ${Report_type_value}    ${product_description_value}    ${Therapies_2_value}    ${Therapies3_value} 
    filling the case information in general tab till report type    ${company_unit_value}    ${sender_organisation_value}    ${Latest_received_date_value}   ${Report_type_value}
    filling the case information in product tab for CDDR11_1   ${product_description_value}
    filling therapy details for CDDR11_1    ${Therapies_2_value}    ${Therapies3_value}
    Saving the RCT and retrieving its details

# filling the case information in general tab till report type
#     [Documentation]    filling the case information in general tab
#      [Arguments]    ${company_unit_value}    ${sender_organ_value}    ${latest_receview_date}    ${report_type}
#      Wait For Element Display
#     ${no_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('no_button_xpath')}
#     Run Keyword If    ${no_present}    Click Element    ${wvar('no_button_xpath')}
#     Replace xpath and select case info menu tab    General
#     Replace xpath Then Search and Select from Dropdown   ${wvar('company_unit_field_text')}   ${company_unit_value}
#     Sleep  2s
#     Replace xpath and input text                         ${wvar('sender_organization_as_coded_field_text')}   ${sender_organ_value}
#     Replace Xpath and Highlight Text Box    ${wvar('sender_organization_as_coded_field_text')}
#     Take Screenshot    selenium
#     Wait For Element Display
#     Select Date                                          ${wvar('latest_received_date_text')}   ${latest_receview_date}
#     Replace xpath Then Select from Dropdown              ${wvar('report_type_field_text')}    ${report_type}

filling the case information in product tab for CDDR11_1
    [Documentation]    filling the case information in product tab for CDDR11_1
    [Arguments]    ${product_descrip_value}
    Replace xpath and select case info menu tab    Product(s)
    product description field    ${product_descrip_value}
    Wait For Element Display

filling therapy details for CDDR11_1
    [Documentation]    Validate therapies tab presence for CDDR11_1
    [Arguments]    ${lot_batch_no_value_2}    ${lot_batch_no_value}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90
    # Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
    Replace xpath and select case info menu tab    Product(s)
    Wait For Element Display
    Press Ctrl E Keyboard Shortcut
    Click Element Using JavaScript Xpath    ${wvar('therapies_tab')}
    Wait For Element Display
    Scroll Element Into View    ${wvar('is_sample_available')}
    Wait For Element Display
    # Replace Xpath and select from dropdown    ${wvar('lot_or_batch_no_field_text')}    ${wvar('therapy_blank_text')}
    Replace Xpath and Highlight Text Box    ${wvar('lot_or_batch_no_field_text')}
    Take Screenshot    selenium
    # Click Element Using JavaScript Xpath    ${wvar('therapies_tab')}
    Scroll Then Click Button    ${wvar('add_button')}
    Replace Xpath And Click Element    ${wvar('common_search_subcategory')}    Therapies#2
#    Scroll Then Click Button    ${wvar('add_button')}
    Wait For Element Display
#    Replace Xpath Contains Then Search And Select From Dropdown    ${wvar('form_of_admin_field_text')}    ${Admin_form_value}
#    Replace Xpath Contains Then Search And Select From Dropdown    ${wvar('route_of_admin_field_text')}   ${route_of_admin_value}
    Scroll Element Into View    ${wvar('therapies_site')}
#    Select And Save Date
#    ${CURRENT_DATE}=       Get Current Date    result_format=%d-%m-%Y
    # Select dates    ${wvar('therapy_start_date_text')}    ${Date}
    Click Element    ${wvar('lot_no_null_flavor_xpath')}
    Wait For Element Display
    #Replace Xpath Then Search And Select From Dropdown    ${wvar('lot_or_batch_no_field_text')}    ${lot_batch_no_value_2}
   # Replace Xpath Then highlight Dropdown value    ${wvar('lot_or_batch_no_field_text')}    ${lot_batch_no_value_2}
    Replace Xpath Then Select From Dropdown    ${wvar('lot_or_batch_no_field_text')}    ${lot_batch_no_value_2}
    Replace Xpath and Highlight Text Box    ${wvar('lot_or_batch_no_field_text')}
    Scroll Element Into View    ${wvar('parent_route_of_administration_termid_xpath')}
    # Highlight WebElement    ${wvar('lot_batch_select_input_box')}
    Take Screenshot    selenium
    Click Element Using JavaScript Xpath    ${wvar('therapies_tab')}
    Scroll Then Click Button    ${wvar('add_button')}
    Wait For Element Display
#    Replace Xpath Contains Then Search And Select From Dropdown    ${wvar('form_of_admin_field_text')}    ${Admin_form_value}
#    Replace Xpath Contains Then Search And Select From Dropdown    ${wvar('route_of_admin_field_text')}   ${route_of_admin_value}
    Scroll Element Into View    ${wvar('therapies_site')}
    # Select dates    ${wvar('therapy_start_date_text')}    ${Date}
    Replace Xpath And Input Text      ${wvar('lot_or_batch_no_field_text')}    ${lot_batch_no_value}
   # Highlight and Replace xpath for input text    ${wvar('lot_or_batch_no_field_text')}
    Replace Xpath and Highlight Text Box    ${wvar('lot_or_batch_no_field_text')}
    Scroll Element Into View    ${wvar('parent_route_of_administration_termid_xpath')}
    Take Screenshot    selenium

Replace xpath Then Search and Select from Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    Wait For Element Display
    ${res}   Replace String            (${wvar('common_dropdown_select_xpath')})[1]     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Input Text      ${wvar('input_search_xpath')}    ${option}
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}

Verify Lot/Batch field
    [Documentation]    Verifying Lot/Batch field presence in therapies tab for CDDR11
    [Arguments]    ${lot_batch_no_value_2}    ${lot_batch_no_value}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
#    Wait For Element Display
    Replace xpath and select case info menu tab    Product(s)
    Highlight Workflow Status
    Press Ctrl E Keyboard Shortcut
#    Wait For Element Display
    Click Element Using JavaScript Xpath    ${wvar('therapies_tab')}
    Wait For Element Display
    Scroll Element Into View    ${wvar('therapies_site')}
    Wait For Element Display
    ${value_1}=    Get Text    ${wvar('therapy_one_input_xpath')}
#     ${noncase_confirm_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('classify_noncase_confirm_xpath')}
#    Run Keyword If    ${noncase_confirm_present}    Click Element    ${wvar('classify_noncase_confirm_xpath')}
    ${is_visible}=    Run Keyword And Return Status     Wait Until Element Is Visible    ${wvar('therapies_display_none')}    5s
    ${is_display}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('therapies_display')} #after clearing selcet is there
    Log    ${is_visible}
    Log    ${is_display}
    IF    '${value_1}' == 'Unknown'
        Replace Xpath and Highlight Text Box    ${wvar('lot_or_batch_no_field_text')}
        Take Screenshot    selenium
        Wait For Element Display
        Click Element Using JavaScript Xpath    ${wvar('therapies_tab')}
        Replace Xpath And Click Element    ${wvar('common_search_subcategory')}    Therapies#2
        Scroll Element Into View    ${wvar('therapies_site')}
        ${value_2}=    Get Text    ${wvar('lot_batch_select_input_box')}
        Replace Xpath and Highlight Text Box    ${wvar('lot_or_batch_no_field_text')}
        Scroll Element Into View    ${wvar('parent_route_of_administration_termid_xpath')}
        # Highlight WebElement    ${wvar('lot_batch_select_input_box')}
        ${Status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${lot_batch_no_value_2}    ${value_2}    ignore_case=True
            Run Keyword If    '${Status}' == 'True'
            ...    Log To Console    Validation Success. Actual Lot/Batch no is: '${lot_batch_no_value_2}' == Expected Lot/Batch no is: '${value_2}'
            ...  ELSE
            ...    Fail    Validation Fail. Actual Duration is: '${lot_batch_no_value_2}' != Expected Duration is: '${value_2}'
        Take Screenshot    selenium
        Wait For Element Display
        Click Element Using JavaScript Xpath    ${wvar('therapies_tab')}
        Replace Xpath And Click Element    ${wvar('common_search_subcategory')}    Therapies#3
        Scroll Element Into View    ${wvar('therapies_site')}
        ${value_3}=    Get Value    ${wvar('lot_batch_input_box')}
       # Highlight and Replace xpath for input text    ${wvar('lot_or_batch_no_field_text')}
        Replace Xpath and Highlight Text Box    ${wvar('lot_or_batch_no_field_text')}
        Scroll Element Into View    ${wvar('parent_route_of_administration_termid_xpath')}
        ${Status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${lot_batch_no_value}    ${value_3}
            Run Keyword If    '${Status}' == 'True'
            ...    Log To Console    Validation Success. Actual Lot/Batch no is: '${lot_batch_no_value}' == Expected Lot/Batch no is: '${value_3}'
            ...  ELSE
            ...    Fail    Validation Fail. Actual Duration is: '${lot_batch_no_value}' != Expected Duration is: '${value_3}'
        Take Screenshot    selenium
        Replace xpath and click element       ${wvar('common_button_new_case')}   Save
        Wait Until Keyword Succeeds     40s      5s   Wait Until Element Is Visible   ${wvar('rct_successfully_validation')}
        Wait Then Click Element    ${wvar('validation_confirm_ok_xpath')}
    ELSE
        Fail    Therapy 1 is not having Unknown value
    END

Create RCT and Validate Pulse-CDDR-34
    [Documentation]     Validate Pulse-CDDR-34 For Final Review
    ${project_folder}=    Set Variable    ${EXECDIR}${/}Resource${/}TestData_Excels${/}
    ${excel_file}=    Set Variable    ${project_folder}LSMV_TestData.xlsx
    ${sheet_name}=    Set Variable    ${scenario_sheet_name}
    ${data}=    Connect And Read Data From Excel Sheet    ${excel_file}    ${sheet_name}
    Log to Console  ${data}
    ${row_index}=    Set Variable    1
    
    # Get the first row's study value for one-time setup
    ${first_row}=    Set Variable    ${data}[0]
    Set Test Variable    ${sponser_study_value}    ${first_row['Study Sponsor Number']}
    # Initialize validation variable to empty for initial setup (before FOR loop)
    Set Test Variable    ${validation}    ${EMPTY}
    
    # Run these only once before the loop
    ${AER}=   Import aer and navigate to Case Listing from Home page for CDDR-34    
    clasify the RCT to retrieve the AER number
    Navigate Study Tab and Add Study Data for CDDR34_1
    
    FOR    ${row}    IN    @{data}
        # Set variables from current row inside the loop
        Set Test Variable    ${sponser_study_value}    ${row['Study Sponsor Number']}
        Set Test Variable    ${Investigational Product Blinded_select}    ${row['Investigational Product Blinded']}
        Set Test Variable    ${Coding_Class_value}      ${row['Coding Class']}
        Set Test Variable    ${Expected Investigational Product Blinded?_select}    ${row['Expected Investigational Product Blinded']}
        Set Test Variable    ${Expected Coding Class_value}    ${row['Expected Coding Class']}
        Set Test Variable    ${validation}      ${row['Validation']}
        
        IF    '${validation}' in ['Check 1', 'Check 2', 'Check 3', 'Check 4', 'Check 5']
            ${validator_result}    ${validator_error}=    Run Keyword And Ignore Error    Create RCT And Verify Auto-calc PULSE-CDDR34_1
            IF    '${validator_result}' == 'FAIL'
                Take Screenshot    Fail
            END
        END     
        IF    '${validation}' == 'Check 6'
            ${validator_result}    ${validator_error}=    Run Keyword And Ignore Error    Auto-calc PULSE-CDDR34_1 extension
            IF    '${validator_result}' == 'FAIL'
                Take Screenshot    Fail
            END
            # Store Check 6 result for Check 7
            # Set Test Variable    ${check6_result}    ${validator_result}
        END 
        IF    '${validation}' == 'Check 7'
            ${validator_result}    ${validator_error}=    Run Keyword And Ignore Error    Verify Coding Class as Blinded on Save for CDDR34_1
            IF    '${validator_result}' == 'FAIL'
                Take Screenshot    Fail
            END
        END   
        # IF    '${validation}' == 'Check 7'
        #     # Use Check 6 result for Check 7
        #     ${validator_result}=    Set Variable    ${check6_result}
        # END    
        ${Output_excel}=    Set Variable    ${EXECDIR}/Output/${sheet_name}.xlsx
        Update Cell By Excel Row    ${EXECDIR}/Output/${sheet_name}.xlsx    ${sheet_name}    ${row_index}    RCT No    ${RCT_No}
        Update Cell By Excel Row    ${Output_excel}    ${sheet_name}    ${row_index}    Actual Test Result    ${validator_result}
        ${row_index}=    Evaluate    ${row_index} + 1
    END    
    Set Test Variable    ${Output_excel}    
    Validate Test Results    ${Output_excel}

Navigate Study Tab and Add Study Data for CDDR34_1
    [Documentation]    Navigate Study Tab and Add Study Data for CDDR34_1
    # [Arguments]    ${sponser_study_value}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=90
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
    Replace xpath and select case info menu tab    Study
    ${validation_exists}=    Run Keyword And Return Status    Variable Should Exist    ${validation}
    IF    '${validation_exists}' == 'True' and '${validation}' == 'Check 6'
        Click Element Using JavaScript Xpath    ${wvar('clear_study_btn_xpath')}  
        Wait For Element Display
        Click Element Using JavaScript Xpath    ${wvar('rash_confirm_dialog_box_xpath')} 
        Wait For Element Display 
    END
    Highlight Workflow Status
    Press Ctrl E Keyboard Shortcut
    Study lookup and select the study    ${sponser_study_value}
    Replace Xpath And Wait Then Click Element      ${wvar('text_xpath')}     ${wvar('study_subcategory_text')}
    Click Element Using JavaScript Xpath    ${wvar('study_product_check_box_xpath')}
    IF    '${validation_exists}' == 'True' and '${validation}' == 'Check 6'
        Click Element Using JavaScript Xpath    ${wvar('study_product_check_box_xpath_two')}
    END
    Wait For Element Display
    Take Screenshot    selenium
    Click Element Using JavaScript Xpath    ${wvar('study_copy_product_xpath')}
    Wait For Element Display
    Wait Until Element Is Not Visible    ${wvar('processing_xpath')}    timeout=90
    Click Element Using JavaScript Xpath    ${wvar('study_dialog_box_ok_btn')}
    Wait For Element Display
    Replace xpath and select case info menu tab    Study
    Replace Xpath And Wait Then Click Element      ${wvar('text_xpath')}     ${wvar('study_information_text')}
    Replace Xpath and Highlight Text Box              ${wvar('sponsor_study_no_field_text')}
    Take Screenshot    selenium
    # Replace Xpath and Highlight Text Box              ${wvar('study_type_text')}
    Scroll Element Into View    ${wvar('study_acronym_label_xpath')}
    Highlight and Replace xpath for input text for pulse34    ${wvar('study_code_broken_text')}
    # Replace Xpath and Highlight Text Box              ${wvar('case_code_broken_text')}
    Take Screenshot    selenium
    
    

Study lookup and select the study
    [Documentation]    Study lookup and select the study
    [Arguments]    ${sponser_study_value}
    Wait For Element Display
    Replace text and click element the search icon    ${wvar('study_description_field_text')}
    Click Element Using JavaScript Xpath    ${wvar('therapy_clear_yes_button')}
    Wait For Element Display
    Replace Xpath Contains And Enter the Input Text      ${wvar('input_xpath')}   ${wvar('Sponsor_Study_No_field_text')}   ${sponser_study_value}
    Wait For Element Display
    Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('search_btn_product_desptn')}
    Wait For Element Display
    Click Element Using JavaScript Xpath    ${wvar('study_lookup_radio_btn_xpath')}
    Scroll Then Click Button    ${wvar('pd_selected_ok_button')}
    Wait For Element Display

Auto-calc PULSE-CDDR34_1 extension
    Navigate Study Tab and Add Study Data for CDDR34_1
    Verify Coding Class as Blinded on Save for CDDR34_1
Verify Coding Class As Blinded On Save For CDDR34_2
    [Documentation]    Verify Coding Class as Blinded on Save for CDDR34_2
    [Arguments]    ${Coding_Class_value}    ${Expected Coding Class_value}
    Wait For Element Display
    Highlight Workflow Status
    Press Ctrl E Keyboard Shortcut
    # Replace xpath Then Search and Select from Dropdown for CDDR34   ${wvar('coding_class_field_text')}   ${Coding_Class_value}
    Highlight and Replace xpath for div    Coding Class    
    Scroll Element Into View    ${wvar('fda_label_xpath')}
    # Click Element Using JavaScript Xpath    ${wvar('investigational_product_radio_no_btn_xpath')}
    Highlight and Replace xpath for div    Investigational Product Blinded?
    Take Screenshot    selenium
    Replace xpath and click element       ${wvar('common_button_new_case')}   Save
    Wait Until Keyword Succeeds     60s      5s   Wait Until Element Is Visible   ${wvar('rct_successfully_validation')}
    Wait Then Click Element    ${wvar('validation_confirm_ok_xpath')}
    Wait For Element Display
    ${value_1}=    Get Text    ${wvar('coding_class_input_xpath')}
        Highlight and Replace xpath for div    Coding Class
        # Highlight WebElement    ${wvar('coding_class_input_xpath')}
        ${Status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${Expected Coding Class_value}    ${value_1}    ignore_case=True
            Run Keyword If    '${Status}' == 'True'
            ...    Log To Console    Validation Success. Actual Lot/Batch no is: '${Expected Coding Class_value}' == Expected Lot/Batch no is: '${value_1}'
            ...  ELSE
            ...    Fail    Validation Fail. Actual Duration is: '${Expected Coding Class_value}' != Expected Duration is: '${value_1}'        
    ${is_display}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('investigational_product_radio_btn_xpath')}
    IF    '${is_display}' == 'False'
        Scroll Element Into View    ${wvar('fda_label_xpath')}
        Highlight and Replace xpath for div    Investigational Product Blinded?
        Take Screenshot    selenium
    END

Replace xpath Then Search and Select from Dropdown for CDDR34
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    Wait For Element Display
    ${res}   Replace String            (${wvar('common_dropdown_select_xpath')})[1]     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}
    
Move RCT Stage from Intake and Assignment to FDE
    [Documentation]     Move RCT Stage from Intake to Case
    [Arguments]    ${RCT_No}    ${Target_Stage}
    # Wait for the loading image to disappear
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=120
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
    Close Message Popup If Present
    Wait For Element Display
    ${workflow}=    Get Text    ${wvar('workflow_status_xpath')}
    # Click on the Actions button
    Click Element Custom    ${wvar('actions_xpath')}
    # Wait and Click on the Complete Activity button
    Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('normalwait')}
    Click Element Custom    ${wvar('complete_activity_xpath')}
    # wait for loading image to disappear
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=120
    Handle Lateness Popup
    # Clickon the Pass OK button
    Click Element Custom    ${wvar('pass_ok_button_xpath')}
    Same page view    ${workflow}    ${RCT_No}

    Wait For Element Display
    # Wait for the loading image to disappear
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=120
    Wait For Element Display
    # Wait for the workflow status to be visible and Get Workflow label
    Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
    ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
    Log To Console    Workflow Status is: ${workflow_label}
    # this while loop will keep checking the workflow status if the worklabel is Full Data Entry then it will break
    WHILE    ${True}
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=120
        Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
        ${workflow_label}=    Get Text    ${wvar('workflow_status_xpath')}
        IF    '${workflow_label}' == '${Target_Stage}'
            Log To Console    Workflow is in ${Target_Stage} stage
            Set Test Variable    ${workflow_label}    ${Target_Stage}
            Take Screenshot    selenium
            BREAK
        ELSE
            Wait For Element Display
            Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    timeout=120
            Click Element Custom    ${wvar('actions_xpath')}
            Wait Until Element is Visible    ${wvar('complete_activity_xpath')}    ${wvar('normalwait')}
            Click Element Custom    ${wvar('complete_activity_xpath')}
            Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('normalwait')}
            Click Element Custom    ${wvar('pass_ok_button_xpath')}
            Wait Until Element is Visible    ${wvar('validation_confirm_ok_button_xpath')}    timeout=120
            Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}
            Search for AER    ${RCT_No}
            Wait For Element Display
            ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('general_title_xpath')}    30s
            IF   '${status}' == 'True'
                    Medical Review    ${RCT_No}
                   # BREAK
            END
    #            Wait Until Element Is Visible    ${wvar('workflow_status_xpath')}    ${wvar('normalwait')}
        END

    END


Close Message Popup If Present
    [Documentation]    Close message popup if it appears
    ${is_popup_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('message_popup_close_btn_xpath')}    timeout=10s
    IF    '${is_popup_present}' == 'True'
        Click Element Custom    ${wvar('message_popup_close_btn_xpath')}    
    END

UnHighlight Labeling Tab
    [Documentation]    UnHighlight Labeling Tab
    Replace xpath and UnHighlight Case info menu Tab    Labeling

UnHighlight Causality Tab
    [Documentation]    UnHighlight Causality Tab
    Replace xpath and UnHighlight Case info menu Tab    Causality

Select Product From Label Details DropDown
    [Documentation]    Select Prduct From Label Details DropDown
    [Arguments]    ${product_name}  
    # Highlight WebElement    ${wvar('labeling_dropdown_xpath')}  
    Click Element Custom    ${wvar('labeling_details_dd_trigger_btn_xpath')}
    Wait Until Element Is Visible    ${wvar('causality_dropdown_elements_xpath')}    ${wvar('shortwait')}
    ${dd_option_elements}=    Get WebElements   ${wvar('causality_dropdown_elements_xpath')}
    FOR    ${element}    IN    @{dd_option_elements}
        Log    ${element}
        ${element_text}=    Get Text    ${element}
        Log    ${element_text}
        ${status}=    Check String In String     ${element_text}     ${product_name} 
        IF  '${status}' == 'True'
            Scroll Element Into View    ${element}
            Click Element Custom    ${element}            
            Exit For Loop
        END
    END    

Highlight Grid Row
    [Documentation]    Highlight the selected grid row
    [Arguments]    ${row_index}
    ${row_xpath}=    Set Variable    ${wvar('grid_view_row_xpath')}
    ${row_xpath}=    Replace String    ${row_xpath}    replace    ${row_index}
    Scroll Element Into View    ${row_xpath}
    Highlight WebElement    ${row_xpath}

UnHighlight Grid Row
    [Documentation]    UnHighlight the selected grid row
    [Arguments]    ${row_index}
    ${row_xpath}=    Set Variable    ${wvar('grid_view_row_xpath')}
    ${row_xpath}=    Replace String    ${row_xpath}    replace    ${row_index}
    Scroll Element Into View    ${row_xpath}
    UnHighlight WebElement    ${row_xpath}

Select Product From Causality Details DropDown
    [Documentation]    Select Product From Causality Details DropDown
    [Arguments]    ${product_name}
    Highlight WebElement    ${wvar('highlight_causality_product_dropdown_xpath')}
    Click Element Custom    ${wvar('causality_product_dropdown_xpath')}
    Wait Until Element Is Visible    ${wvar('causality_dropdown_elements_xpath')}    ${wvar('normalwait')}
    ${dropdown_elements}=    Get WebElements    ${wvar('causality_dropdown_elements_xpath')}
    FOR    ${element}    IN    @{dropdown_elements}
        ${product}=    Get Text    ${element}
        Log    ${product}
        ${status}=    Check String In String    ${product}    ${product_name}
        IF    '${status}' == 'True'
            Scroll Element Into View    ${element}
            Click Element Custom    ${element}            
            BREAK
        END
    END

Cancel Select Collections Dialog
    [Documentation]    Handle the Select Collections dialog
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('select_collections_xpath')}    10s
    IF    '${status}' == 'True'
        Click Element Custom    ${wvar('select_collections_cancel_button_xpath')}
    END

Click Do Not Auto Rank Checkbox
    [Documentation]    Clicks the 'Do Not Auto Rank' PrimeNG checkbox in the Product Ranking dialog.
    ...    Ensures it ends up checked (aria-checked = true). Uses PrimeNGSupport resilient toggle.
    [Arguments]    ${desired_state}=true    ${timeout}=10
    # Robust locator points to the visible checkbox box inside p-checkbox with inputid 'proDonNotAutoRank'.
    ${checkbox_box_locator}=    Set Variable    ${wvar('do_not_auto_rank_checkbox_xpath')}
    JS Toggle PrimeNG Checkbox    locator=${checkbox_box_locator}    desired_state=${desired_state}    timeout=${timeout}
    ${hidden_input}=    Set Variable    ${wvar('do_not_auto_rank_checkbox_status_xpath')}
    ${state}=    Get Element Attribute    ${hidden_input}    aria-checked
    Should Be Equal    ${state}    ${desired_state}
    Log    Do Not Auto Rank checkbox set to ${state}

Verify Do Not Auto Rank Checkbox State
    [Documentation]    Verifies the Do Not Auto Rank checkbox matches expected state.
    [Arguments]    ${expected_state}=true
    ${checkbox_box_locator}=    Set Variable    ${wvar('do_not_auto_rank_checkbox_xpath')}
    ${hidden_input}=    Set Variable    ${wvar('do_not_auto_rank_checkbox_status_xpath')}
    ${state}=    Get Element Attribute    ${hidden_input}    aria-checked
    Should Be Equal    ${state}    ${expected_state}
    Log    Verified Do Not Auto Rank checkbox state is ${state}

Uncheck Do Not Auto Rank Checkbox
    [Documentation]    Ensures the Do Not Auto Rank checkbox is unchecked (false).
    [Arguments]    ${timeout}=10
    Click Do Not Auto Rank Checkbox    desired_state=false    timeout=${timeout}

Uncheck Do Not Auto Rank If Checked
    [Documentation]    Unchecks Do Not Auto Rank only if currently checked.
    [Arguments]    ${timeout}=10
    ${checkbox_box_locator}=    Set Variable    ${wvar('do_not_auto_rank_checkbox_xpath')}
    ${hidden_input}=    Set Variable    ${wvar('do_not_auto_rank_checkbox_status_xpath')}
    ${current}=    Get Element Attribute    ${hidden_input}    aria-checked
    Run Keyword If    '${current}'=='true'    Click PrimeNG Checkbox    locator=${checkbox_box_locator}    desired_state=false    timeout=${timeout}
    ${final}=    Get Element Attribute    ${hidden_input}    aria-checked
    Should Be Equal    ${final}    false
    Log    Do Not Auto Rank checkbox ensured unchecked.

Grid View Off From Product Tab
    [Documentation]    Turn off the grid view
    Click Element Custom    ${wvar('grid_view_off_xpath')}

Select Option From DeChanllenge DropDown
    [Documentation]    Select Option From DeChanllenge DropDown
    [Arguments]    ${dechallenge_option}  
    Log      ${dechallenge_option}
    Reduce Window Size Web Support    70%
    Scroll Element Into View    ${wvar('dechallange_dropdown_trigger_btn')}
    Highlight WebElement    ${wvar('dechallenge_dropdown_highlight_xpath')}
    Click Element Custom    ${wvar('dechallange_dropdown_trigger_btn')}
    Wait Until Element Is Visible    ${wvar('dechallange_dropdown_items_xpath')}    ${wvar('shortwait')}
    ${dd_options}=    Get WebElements   ${wvar('dechallange_dropdown_items_xpath')}
    FOR    ${element}    IN    @{dd_options}
        Log    ${element}
        ${element_text}=    Get Text    ${element}
        Log    ${element_text}
        IF    '${dechallenge_option}' == 'Blank' and '${element_text}' == '--Select--'
            Click Element Custom    ${element}
            BREAK
        END
        ${status}=    Check String In String     ${element_text}     ${dechallenge_option} 
        IF  '${status}' == 'True'
            Click Element Custom    ${element}            
            Exit For Loop
        END
    END
    Take Screenshot    selenium
    Reset Window Size Web Support

Select Option From ReChanllenge DropDown
    [Documentation]    Select Option From ReChanllenge DropDown
    [Arguments]    ${rechallenge_option} 
    Log    ${rechallenge_option}
    Reduce Window Size Web Support    70%
    Scroll Element Into View    ${wvar('rechallange_dropdown_trigger_btn')}
    Highlight WebElement    ${wvar('rechallange_dropdown_highlight_xpath')}
    Click Element Custom    ${wvar('rechallange_dropdown_trigger_btn')}
    Wait Until Element Is Visible    ${wvar('rechallange_dropdown_items_xpath')}    ${wvar('shortwait')}
    ${dd_options}=    Get WebElements   ${wvar('rechallange_dropdown_items_xpath')}
    FOR    ${element}    IN    @{dd_options}
        Log    ${element}
        ${element_text}=    Get Text    ${element}
        Log    ${element_text}
        IF    '${rechallenge_option}' == 'Blank' and '${element_text}' == '--Select--'
            Click Element Custom    ${element}
            BREAK
        END
        ${status}=    Check String In String     ${element_text}     ${rechallenge_option} 
        IF  '${status}' == 'True'
            Click Element Custom    ${element}            
            Exit For Loop
        END
    END
    Take Screenshot    selenium
    Reset Window Size Web Support

Fetch Causality DeChallenge DropDown title
    [Documentation]    Fetch the title of the Causality DeChallenge DropDown 
    Wait For Element Display       
    Wait Until Element Is Visible    ${wvar('casuality_dechallange_dd_title_xpath')}    ${wvar('shortwait')}
    Highlight WebElement    ${wvar('dechallenge_dropdown_highlight_xpath')}
    Scroll Element Into View    ${wvar('casuality_dechallange_dd_title_xpath')}
    ${title}=    Get Text    ${wvar('casuality_dechallange_dd_title_xpath')}
    RETURN    ${title}

Fetch Causality ReChallenge DropDown title
    [Documentation]    Fetch the title of the Causality ReChallenge DropDown    
    Wait For Element Display
    Wait Until Element Is Visible    ${wvar('casuality_rechallange_dd_title_xpath')}    ${wvar('shortwait')}
    Highlight WebElement    ${wvar('rechallange_dropdown_highlight_xpath')}
    Scroll Element Into View    ${wvar('casuality_rechallange_dd_title_xpath')}
    ${title}=    Get Text    ${wvar('casuality_rechallange_dd_title_xpath')}
    RETURN    ${title}

Select Action Taken With Drug From Product Tab
    [Documentation]    Select Action Taken With Drug
    [Arguments]    ${Action_taken_on_Drug_value}
    Log    ${Action_taken_on_Drug_value}
    IF    '${Action_taken_on_Drug_value}' == 'Blank'
        ${Action_taken_on_Drug_value}=    Set Variable    --Select--
    END
    ${res}   Replace String            ${wvar('common_dropdown_select_xpath')}     replace    Action Taken With Drug
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${Action_taken_on_Drug_value}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s    
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}      
    Replace Xpath and Highlight Text Box    Action Taken With Drug

Old value of the field
    [Documentation]    Old value of the field
    [Arguments]    ${field_label}
    ${xpath}   replace string   ${wvar('common_old_value_field_label_xpath')}    replace      ${field_label}
    Mouse Over    ${xpath}
    Replace Xpath And Wait Then Click Element     ${wvar('old_value_common_xpath')}    ${field_label}
    Wait Until Element Is Visible    ${wvar('old_value_common_close_xpath')}
    Take Screenshot    selenium
    Click Element Custom    ${wvar('old_value_common_close_xpath')}

Text Field Should Be Blank
    [Documentation]    Assert that an input/textarea field has an empty value (after trimming). Accepts any SeleniumLibrary locator.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${wvar('normalwait')}
    Scroll Element Into View    ${locator}
    ${value}=    Run Keyword And Ignore Error    Get Value    ${locator}
    # ${value} will be a two-item list when using Run Keyword And Ignore Error: status and returned value
    ${status}=    Set Variable    ${value[0]}
    IF    '${status}' == 'PASS'
        ${val}=    Set Variable    ${value[1]}
    ELSE
        ${val}=    Get Element Attribute    ${locator}    value
    END
    ${val}=    Set Variable If    '${val}'=='${None}'    ${EMPTY}    ${val}
    ${val}=    Strip String    ${val}
    Highlight WebElement    ${locator}
    Should Be Equal    ${val}    ${EMPTY}
    Log    Field located by ${locator} is blank.    console=True

Text Field Should Be Disabled And Blank
    [Documentation]    Assert that a field is disabled (disabled attribute or aria-disabled=true) AND blank.
    [Arguments]    ${locator}
    Text Field Should Be Blank    ${locator}
    ${disabled_attr}=    Run Keyword And Ignore Error    Get Element Attribute    ${locator}    disabled
    ${disabled_status}=    Set Variable    ${disabled_attr[0]}
    IF    '${disabled_status}' == 'PASS'
        ${disabled_val}=    Set Variable    ${disabled_attr[1]}
    ELSE
        ${disabled_val}=    Set Variable    ${EMPTY}
    END
    ${aria_disabled}=    Run Keyword And Ignore Error    Get Element Attribute    ${locator}    aria-disabled
    ${aria_status}=    Set Variable    ${aria_disabled[0]}
    IF    '${aria_status}' == 'PASS'
        ${aria_val}=    Set Variable    ${aria_disabled[1]}
    ELSE
        ${aria_val}=    Set Variable    ${EMPTY}
    END
    ${is_disabled}=    Run Keyword And Return Status    Element Should Be Disabled    ${locator}
    Run Keyword If    '${is_disabled}' == 'False'    Run Keywords    Should Not Be Empty    ${disabled_val}    AND    Log    Falling back to attribute checks.    console=True
    ${combined}=    Set Variable    ${disabled_val}${aria_val}
    Should Not Be Equal    ${combined}    ${EMPTY}
    Log    Field located by ${locator} is disabled and blank.    console=True

Input LMP of Parent Date In Parent Tab
    [Documentation]    Input the LMP of Parent Date in the Parent Tab
    [Arguments]    ${LMP_Date}
    Highlight and Replace xpath for input text    ${wvar('lmp_parent_text')}
    ${res1}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${wvar('lmp_parent_text')}
    Wait Until Element Is Visible       ${res1}      ${wvar('normalwait')}
    Scroll Element Into View            ${res1}
    Clear Element Text    ${res1}
    Press Key    ${res1}    ENTER
    IF  '${LMP_Date}' == 'Blank'
        ${LMP_Date}=    Set Variable    ${EMPTY}    # To handle blank LMP date input
    END
    Select Date         ${wvar('lmp_parent_text')}   ${LMP_Date}

Input Onset Date In Parent Tab
    [Documentation]    Input the Onset Date in the Parent Tab
    [Arguments]    ${Onset_Date}
    Highlight and Replace xpath for input text    ${wvar('onset_date_field_text')}
    ${nf_onset_date}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('onset_date_null_flavour_btn_xpath')}    5s
    IF    '${nf_onset_date}' == 'True'
        Click Element Custom    ${wvar('onset_date_null_flavour_btn_xpath')}
        Click Element Custom    ${wvar('prof_charac_confirm_xpath')}        
    END
    ${res1}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${wvar('onset_date_field_text')}
    Wait Until Element Is Visible       ${res1}      ${wvar('normalwait')}
    Scroll Element Into View            ${res1}
    Clear Element Text    ${res1}
    Press Key    ${res1}    ENTER
    IF  '${Onset_Date}' == 'Blank'
        ${Onset_Date}=    Set Variable    ${EMPTY}    # To handle blank onset date input
    END
    Select Date         ${wvar('onset_date_field_text')}   ${Onset_Date}

Fetch Gestational Age Weeks
    [Documentation]    Returns gestational age (weeks) from the title attribute of the disabled input. Retries until non-empty and falls back to JS if needed.
    [Arguments]    ${retries}=8    ${interval}=1s
    ${locator}=    Set Variable    ${wvar('gestationalage_txt_box_xpath')}
    Wait Until Element Is Visible    ${locator}    ${wvar('shortwait')}
    ${value}=    Set Variable    
    FOR    ${i}    IN RANGE    ${retries}
        ${value}=    Get Element Attribute    ${locator}    title
        Run Keyword If    '${value}' != ''    Exit For Loop
        Sleep    ${interval}
    END
    Run Keyword If    '${value}' == ''    
    ...    Execute Javascript    return document.getElementById('adverseEventNew:patientPanelTable:patientIdentifierTable:gestationalAge')?.getAttribute('title');
    Should Not Be Empty    ${value}    Gestational age title attribute was empty after ${retries} retries and JS fallback.
    RETURN    ${value}

Select Value From the Gestational Age of Event Dropdown    
    [Documentation]    Select a value from the Gestational Age of Event dropdown
    [Arguments]    ${value}
    IF    '${value}' == 'Blank'
        ${value}=    Set Variable    --Select--
    END
    Log    ${value}
    JS Toggle PrimeNG Checkbox    locator=${wvar('gestationalage_manaul_checkbox')}    desired_state=true
    Click Element Custom    ${wvar('gestationalage_week_dd_xpath')}
    ${gestationalage_week_dd_elements}=    Get WebElements    ${wvar('gestationalage_week_dd_elements_xpath')}
    FOR    ${element}    IN    @{gestationalage_week_dd_elements}
        ${text}=    Get Text From Dynamic Element    ${element}
        Log    ${text}
        ${status}=    Check String In String    ${text}    ${value}
        IF    '${status}' == 'True'   
            Click Element Custom    ${element}
            BREAK
        END
    END

replace common xpath and Get Text from Attribute
    [Documentation]   Replace common xpath and Get Text from Attribute
    [Arguments]       ${xpath}     ${element}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${xpath}
    Wait Until Element Is Visible       ${xpath}     30s
    ${Value}=    Get Element Attribute       ${xpath}    ${element}
    RETURN    ${Value}

Select Parent Tab
    [Documentation]    Select the Parent tab
    Replace xpath and select case info menu tab    Parent
    Replace xpath and Highlight Case info menu Tab    Parent

Handle PULSE-0062 Validation Error
    [Documentation]    Handle validation errors for PULSE-0062
    [Arguments]       ${Report_Causality}    ${Company_Causality}
    Select Report Causality And Company Causality From Causality Tab    ${Report_Causality}    ${Company_Causality}

Input Latest Received Date In General Tab
    [Documentation]    Input the latest received date in the general tab
    [Arguments]    ${Latest_Received_Date}
    Select General Tab
    IF    '${Latest_Received_Date}' == 'CurrentDate'
        ${Latest_Received_Date}=    Get Current Date    result_format=%d-%m-%Y
    END
    Highlight and Replace xpath for input text    ${wvar('latest_received_date_text')}
    ${res1}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${wvar('latest_received_date_text')}
    Wait Until Element Is Visible       ${res1}      ${wvar('normalwait')}
    Scroll Element Into View            ${res1}
    Clear Element Text    ${res1}
    Press Key    ${res1}    ENTER
    Select Date      ${wvar('latest_received_date_text')}   ${Latest_Received_Date}

Reclassify RCT
    [Documentation]    Reclassify the RCT
    Replace xpath and wait then click element    ${wvar('tab_view_xpath')}   ${wvar('tab_view_text')}[3]
    Wait For Element Display    
    Click Element Custom    ${wvar('reclassify_btn_xpath')}
    Click Element Custom    ${wvar('reclassify_confirm_button_xpath')}
    Wait For General Tab    

Select Stage From Filter from Case Listing Window
    [Documentation]    Select a stage from the filter in the Case Listing window
    [Arguments]    ${value}
    User navigated to the Case Listing module under Case Management   
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    ${stage_elements}=    Get WebElements    ${wvar('filter_stage_text_xpath')}
    FOR    ${element}    IN    @{stage_elements}
        ${text}=    Get Text From Dynamic Element    ${element}
        Log    ${text}
        IF    '${text}' == '${value}'
            Click Element Custom    ${element}
            BREAK
        END
    END
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}

Fetch Last Page RCT From Distribute Stage Case Listing
    [Documentation]    Fetch the last page RCT from the Distribute Stage Case Listing
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    Wait For Element Display
    Click Element Custom    ${wvar('last_page_xpath')}
    ${RCT_No}=    Get Element Attribute    ${wvar('distribute_stage_rct_xpath')}    id
    RETURN    ${RCT_No}

Select Primary Source Country From General Tab
    [Documentation]    Select the Primary Source Country from the General tab
    [Arguments]    ${Primary_Source_Country}    
    Click Element Custom    ${wvar('case_specific_information_xpath')}
    Replace text Then Search and Select from Dropdown   ${wvar('primary_source_country_text')}      ${Primary_Source_Country}    
    Highlight and Replace xpath for input text   ${wvar('primary_source_country_text')}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('reporter_confirmation_dilog_xpath')}    5s
    IF    '${status}' == 'True'
        Click Element Custom    ${wvar('reporter_confirmation_dilog_xpath')}
    END

Clear existing Study And Add New Study By Entering Sponsor Study No
    [Documentation]    Clear existing study and add a new study by entering the Sponsor Study No
    [Arguments]    ${Sponsor_Study_No}
    Select Study Tab
    Replace xpath and Highlight Case info menu Tab    Study
    Click Element Custom    ${wvar('clear_study_btn_xpath')}
    Click Element Custom    ${wvar('confirm_delete_btn_xpath')}
    Wait for Element display
    Replace xpath and click element    ${wvar('sponcer_study_search_xpath')}    ${wvar('sponsor_study_no_field_text')}
    Click Element Custom    ${wvar('confirm_delete_btn_xpath')}
    Wait for Element display
    Wait Until Element Is Enabled    ${wvar('sponce_study_no_txt_bx_xpath')}
    Input Text     ${wvar('sponce_study_no_txt_bx_xpath')}    ${Sponsor_Study_No}
    Click Element Custom    ${wvar('staudy_dialog_search_btn_xpath')}
    Click Element Custom    ${wvar('study_radio_btn_xpath')}    
    Click Element Custom    ${wvar('study_ok_btn_xpath')}    
    ${pdf_symbol_xpath}=    Replace String     ${wvar('pdf_symbol_xpath')}    replace    ${wvar('sponsor_study_no_field_text')}
    Wait Until Element Is Visible    ${pdf_symbol_xpath}    ${wvar('normalwait')}
    Highlight and Replace xpath for input text    ${wvar('study_type_text')}
    Highlight and Replace xpath for input text    ${wvar('sponsor_study_no_field_text')}
    Replace xpath and UnHighlight Case info menu Tab    Study

Open Korean Review window
    [Documentation]    Open the Korean Review window
    Wait Until Keyword Succeeds    10s    1s    Click Element Custom    ${wvar('korean_review_btn_xpath')}
    Wait For Element Display
    Wait Until Element Is Visible    ${wvar('korean_window_xpath')}    ${wvar('shortwait')}

Select Reporter Country From Reporter Tab
    [Documentation]    Select the Reporter Country from the Reporter tab
    [Arguments]    ${Country}
    Replace xpath Then Select from Dropdown    ${wvar('country_field_text')}     ${Country}
    Replace xpath Then Highlight Dropdown    ${wvar('country_field_text')}     

Press Ctrl E Keyboard Shortcut
    [Documentation]    Press Ctrl + E keyboard shortcut
    [Arguments]    ${element}=${NONE}
    IF    '${element}' != '${NONE}'        
        Press Keys    ${element}    CTRL+e
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('e_two_b_label_xpath')}    10s
        WHILE    '${status}' == 'False'    limit=3
            Press Keys    ${element}    CTRL+e
            ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('e_two_b_label_xpath')}    10s
            IF    '${status}' == 'True'
                Log    E2B Tags Enabled    console=True
                BREAK
            END
        END 
    ELSE
        Press Keys    None    CTRL+e
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('e_two_b_label_xpath')}    10s
        WHILE    '${status}' == 'False'    limit=3
            Press Keys    None    CTRL+e
            ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('e_two_b_label_xpath')}    10s
            IF    '${status}' == 'True'
                Log    E2B Tags Enabled    console=True
                BREAK
            END
        END        
    END

Get Title Attribute Using JavaScript
    [Documentation]    Get Title Attribute Using JavaScript
    [Arguments]    ${input_title_value}
    ${title}=    SeleniumLibrary.Execute Javascript    return document.evaluate("${input_title_value}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.getAttribute("title")
    Log    Title Attribute: ${title}
    RETURN    ${title}

Replace Text Contains Then Select From Dropdown
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${field_name}     ${option}
    ${res}   Replace String            ${wvar('common_dropdown_select_contains_xpath')}     replace    ${field_name}
    ${res_optn}   Replace String            ${wvar('text_common_span_xpath')}     replace    ${option}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Wait Until Keyword Succeeds    10s    1s    Click Element        ${res}
    Sleep    2s
    Execute JavaScript    window.document.evaluate("${res}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Wait Until Keyword Succeeds    10s    2s    Click Element Using JavaScript Xpath      ${res_optn}
    sleep    2s

Select Coding Class
    [Documentation]    Select the Coding Class from the dropdown
    [Arguments]    ${Coding_Class}
    IF    '${Coding_Class}' == 'Blank'
        ${Coding_Class}=    Set Variable    --Select--
    END
    Highlight and Replace xpath for input text    ${wvar('coding_class_field_text')}
    Replace xpath Then Select from Dropdown    ${wvar('coding_class_field_text')}    ${Coding_Class}

Random Number Generator for RCT and Click
    [Documentation]    Generate a random number for RCT
    Wait Until Element Is Visible     ${wvar('first_rct_xpath')}    ${wvar('shortwait')}
    Wait Until Enabled  ${wvar('first_rct_xpath')}
    Wait for Element display
    Wait for Element display
    ${table_elements}=  Get Element Count  xpath=${wvar('random_rct_xpath')}
    Take Screenshot  selenium
    Log  Table Elements Count: ${table_elements}
    IF  ${table_elements} != 0
        ${low}=  Set Variable  1
        ${high}=    Set Variable  ${table_elements}
        ${rand}=  Evaluate  random.randint(int(${low}), int(${high}))  modules=random
        ${chosen_rct}=   Set Variable   xpath=(${wvar('random_rct_xpath')})[${rand}]
        ${rct_value}=    Get Element Attribute    ${chosen_rct}    id
        Log  Chosen RCT Value: ${rct_value}
        Set Test Variable    ${Selected_RCT}    ${rct_value}
        Click Element Custom    ${chosen_rct}
        Set Global Variable     ${status}    1
    ELSE
        Log  No elements found to select from
        Set Global Variable     ${status}    0
    END

Saving the RCT and retrieving its details
    [Documentation]    Saving the RCT and retrieving its details
    Replace xpath and click element       ${wvar('common_button_new_case')}   Save
    Wait Until Keyword Succeeds     120s      10s   Wait Until Element Is Visible   ${wvar('rct_successfully_validation')}
    ${text}   Get Text    ${wvar('rct_successfully_validation')}
    ${words}   Split String      ${text}    ${SPACE}
    ${rct_number}   Set Variable    ${words[4]}
    Set Global Variable    ${aer}    ${rct_number}
    log      ${rct_number}
    Wait for Element display
    Take Screenshot    selenium
    Wait Then Click Element    ${wvar('validation_confirm_ok_xpath')}
    # ${project_folder}=    Set Variable    ${CURDIR}${/}POC${/}
    ${project_folder}=    Set Variable    ${EXECDIR}${/}Resource${/}TestData_Excels${/}
    ${excel_file}=    Set Variable    ${project_folder}${wvar('workbook')}
    ${sheet_name}=    Set Variable    ${wvar('sheet')}
    Set Test Variable    ${RCT_No}    ${rct_number}
    # Write Value To Scenario    ${excel_file}    ${wvar('sheet')}    Scenario Name    ${Scenario_sheet_name}    RCT    ${rct_number}
    RETURN    ${rct_number}

filling the case information in general tab till report type
    [Documentation]    filling the case information in general tab
     [Arguments]    ${company_unit_value}    ${sender_organ_value}    ${latest_receview_date}    ${report_type}
     Wait For Element Display
    ${no_present}=    Run Keyword And Return Status    Element Should Be Visible    ${wvar('no_button_xpath')}
    Run Keyword If    ${no_present}    Click Element    ${wvar('no_button_xpath')}
    Replace xpath and select case info menu tab    General
    Press Ctrl E Keyboard Shortcut
    Replace xpath Then Search and Select from Dropdown   ${wvar('company_unit_field_text')}   ${company_unit_value}
    Sleep  2s
    Replace xpath and input text                         ${wvar('sender_organization_as_coded_field_text')}   ${sender_organ_value}
    Replace Xpath and Highlight Text Box    ${wvar('sender_organization_as_coded_field_text')}
    Take Screenshot    selenium
    Wait For Element Display
    Select Date                                          ${wvar('latest_received_date_text')}   ${latest_receview_date}
    Replace xpath Then Select from Dropdown              ${wvar('report_type_field_text')}    ${report_type}
    Take Screenshot    selenium
    Wait For Element Display

Precondition For CDDR_seventy_one
    [Documentation]    Precondition for CDDR seventy one test case
    [Arguments]    ${icsr_number}
    IF    '${TEST_NAME}' == 'LSMV_Auto-Calculator_PULSE-CDDR71_E2B Causality_Clean up'
        ${rct_number_xml_img}=    Replace String    ${wvar('rct_number_xml_xpath')}    replace    ${icsr_number}
        Wait Until Keyword Succeeds    10s     2s   Scroll Element Into View      ${rct_number_xml_img}
        Click element    ${rct_number_xml_img}
        Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
        Scroll Element Into View    ${wvar('xml_inside_text_xpath')}
        Take Screenshot    selenium
        Click element    ${wvar('xml_close_button_xpath')}
    END    

Select Advance Search From Case Listing Window
    [Documentation]    Select Advance Search From Case Listing Window
    Wait For Element Display
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    Wait For Element Display
    Click Element Custom    ${wvar('advanced_panel_search_xpath')}
    Wait For Element Display

Go To Case Information
    [Documentation]    Go To Case Information
    Wait For Element Display
    Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    Wait Until Keyword Succeeds    10s     2s     Click Element Custom    ${wvar('case_information_xpath')}

Select Nullification Radio Button
    [Documentation]    Select the Nullification Radio Button
    [Arguments]    ${Nullification_Radio_Button}
    Select Case Submission Tab From the General Tab
    Highlight WebElement    ${wvar('highlight_nullification_xpath')}
    IF    '${Nullification_Radio_Button}' == 'Yes'
        Click Element Custom    ${wvar('nullification_radiobtn_xpath')}
        Log    Nullification Radio Button Selected
    ELSE
        IF    '${Nullification_Radio_Button}' == 'Blank'
            ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('nullification_radiobtn_checked_xpath')}    5s
            IF    '${status}' == 'True'
                Click Element Custom    ${wvar('nullification_radiobtn_xpath')}
            END
            Log    Nullification Radio Button Is Blank
        END    
    END

Select Case Submission Tab From the General Tab
    [Documentation]    Select Case Submission Tab From the General Tab
    Select General Tab
    Click Element Custom    ${wvar('case_specific_information_xpath')}
    Wait For Element Display

Handle Reconciliation
    [Documentation]    Handle Reconciliation if present
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('reconciliation_button_xpath')}    10s
    IF    '${status}' == 'True'
        Click Element Custom    ${wvar('reconciliation_button_xpath')}
        Click Element Custom    ${wvar('showmore_xpath')}
        Wait For Element Display
        ${showmore_status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('showmore_xpath')}    5s
        IF    '${showmore_status}' == 'True'
            Click Element Custom    ${wvar('showmore_xpath')}
        END
        Click Element Custom    ${wvar('reconcile_submit_xpath')}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('reconciliation_page_yes_xpath')}    10s
        IF    '${status}' == 'True'
            Click Element Custom    ${wvar('reconciliation_page_yes_xpath')}
        END
        Wait For Element Display
        Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('longwait')}
        Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('longwait')}
    ELSE
        Log to console    Reconciliation popup is not displayed
    END



Select Case Significance From General Tab
    [Documentation]    Select Case Significance From General Tab
    [Arguments]    ${Case_Significance}    
    Log      ${Case_Significance}
    Select General Tab    
    Click Element Custom       ${wvar('case_significance_sub_tab_text_xpath')}    
    JS Toggle PrimeNG Checkbox    ${wvar('case_significance_manual_checkb_xpath')}    desired_state=true
    Replace Text Then Select From Dropdown     ${wvar('cases_signification_field_text')}    Non-Significant (Not reportable)
    Highlight and Replace xpath for input text    ${wvar('cases_signification_field_text')}

    
Select Non Case Assignment Reason From General Tab
    [Documentation]    Select Non Case Assignment Reason From General Tab
    [Arguments]    ${Non_Case_Assignment_Reason}    
    Log      ${Non_Case_Assignment_Reason}
    Select General Tab    
    Replace xpath Then Select from Dropdown    ${wvar('non_case_assessment_reason_text')}    ${Non_Case_Assignment_Reason} 
    Highlight and Replace xpath for input text    ${wvar('non_case_assessment_reason_text')}


Select Value From Report Classification Dropdown
    [Documentation]    Select Value From Report Classification Dropdown
    [Arguments]    ${Report_Classification}    
    Log      ${Report_Classification}
    IF    '${Report_Classification}' != 'Blank'            
        Select General Tab
        Scroll Element Into View    ${wvar('report_classification_dd_trigger_xpath')}
        Click Element Custom    ${wvar('report_classification_dd_trigger_xpath')}
        ${option_xpath}=    Replace String    ${wvar('report_classification_option_xpath')}    replace    ${Report_Classification}
        Click Element Custom    ${option_xpath}
        Highlight and Replace xpath for input text    ${wvar('report_classification_text')}
        Select General Tab
    END
    Highlight and Replace xpath for input text    ${wvar('report_classification_text')}
    Replace xpath and click element    ${wvar('general_tab_subtab_report_link_xpath')}    Case Report


Input Text in MedDRA and take hierarchy screenshot
    [Documentation]    Input Text in MedDRA and take hierarchy screenshot
    [Arguments]    ${sider_tab_name}    ${bread_crumbs_tab_name}   ${input_field_name}    ${input_disease_name}    ${llt_code_disease_name_for_hierarchy}   ${common_meddra_code_click_value_xpath}
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('normalwait')}
    Wait for Element display
    Replace xpath and click element  ${wvar('common_side_panel_tab_xpath')}    ${sider_tab_name} 
    Wait for Element display
    Replace xpath and click element  ${wvar('common_bread_crumbs_header_option_xpath')}    ${bread_crumbs_tab_name}
    Wait for Element display
    ${replaced_tab_xpath}=    Replace String    ${wvar('common_disease_name_input_xpath')}    replace    ${input_field_name}
    Input Text    ${replaced_tab_xpath}    ${input_disease_name}
    Wait for Element display
    Press Keys  ${replaced_tab_xpath}     TAB
    Wait for Element display
    Wait for Element display
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('reporter_confirmation_dilog_xpath')}    10s
    IF   ${status}
        Click Element Custom  ${wvar('reporter_confirmation_dilog_xpath')}
        Wait for Element display
    END
    Click Element Custom  ${wvar('common_meddra_code_click_value_xpath')}
    Wait for Element display
    Wait Until Element Is Visible    ${wvar('common_meddra_highlight_ss_xpath')}    ${wvar('shortwait')}
    Highlight Workflow Status
    Take Screenshot  selenium

 
Saving and retrieving RCT with search and highlight workflow status
    [Documentation]    Save and retrieve RCT with search and highlight workflow status
    Wait for Element display
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('cancel_from_main_screen_xpath')}    ${wvar('longwait')}
    IF    ${status}
        Wait For General Tab
        Wait Until Enabled  ${wvar('cancel_from_main_screen_xpath')}
        Wait for Element display
        Click Element Using JavaScript Xpath   ${wvar('cancel_from_main_screen_xpath')}
        Wait for Element display
        Wait Until Element Is Not Visible    ${wvar('loading_img_xpath')}    ${wvar('normalwait')}
    END
    Search for AER  ${aer}
    Wait for Element display
    Wait Until Element Is Not Visible    ${wvar('search_loading_img_xpath')}    ${wvar('shortwait')}
    Wait for Element display


Select Product By inputting Product Description
    [Documentation]    filling the product description field
    [Arguments]    ${product_descrip_value}    ${radio_button}   
    IF       '${radio_button}' != 'Blank'
        Replace text and click element the search icon    ${wvar('product_description_label_text')}    
    END
    IF    '${radio_button}' == 'WHO DD'
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('whodd_radio_checked_xpath')}    10s
        IF    '${status}' == 'False'
            Click Element Custom    ${wvar('who_dd_radio_xpath')}
        END        
        Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                
        Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('product_lookup_search_btn')}
        ${res}  Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}        
        IF    '${res}' == 'False'
            Wait For Element Display
            Scroll Element Into View     ${wvar('search_btn_product_desptn')}
            Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
            Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
        ELSE
            Scroll then Click button    ${wvar('pd_selected_ok_button')}
            ${status1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('change_product_confirmation_dialog_xpath')}    10s
            IF    '${status1}' == 'True'
                Click Element Custom    ${wvar('change_product_confirmation_dialog_xpath')}
            END
        END
        Wait For Element Display
    ELSE    
        IF    '${radio_button}' == 'Blank'
                IF    '${product_descrip_value}' == 'Blank'
                    Wait For Element Display
                    Highlight and Replace xpath for input text    ${wvar('product_name_as_reported_text')}   
                ELSE
                    Wait For Element Display
                    Highlight and Replace xpath for input text    ${wvar('product_name_as_reported_text')}   
                    Replace xpath and input text    ${wvar('product_name_as_reported_text')}    ${product_descrip_value}
                END
        ELSE
            Replace Xpath Contains And Enter the Input Text      ${wvar('pd_input_xpath')}   ${wvar('trade_or_brand_name_field_text')}   ${product_descrip_value}                        
            Wait For Element Display
            Wait Until Keyword Succeeds    10s   2s   Click Element     ${wvar('search_btn_product_desptn')}
            Wait For Element Display
            ${res}  Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('pd_radio_btn_xpath')}  ${product_descrip_value}
            IF    '${res}' == 'False'
                ${res}=      Run Keyword And Return Status    Replace xpath and wait and scroll then Click radio btn with JS     ${wvar('first_pd_radio_btn_xpath')}  ${product_descrip_value}
            END
            IF    '${res}' == 'False'
                Wait For Element Display
                Scroll Element Into View     ${wvar('search_btn_product_desptn')}
                Click Element Using JavaScript Xpath        ${wvar('search_btn_product_desptn')}
                Scroll Then Click Button                     ${wvar('pd_selected_ok_button')}
            ELSE
                Scroll then Click button    ${wvar('pd_selected_ok_button')}
            END
            Wait For Element Display
        END
    END

Move RCT Stage From FDE To Case Deletion
    [Documentation]    Move RCT Stage From FDE To Case Deletion
    [Arguments]    ${RCT_No}
    Wait For General Tab
    Click Element Custom    ${wvar('more_options_xpath')}
    Click Element Custom    ${wvar('delete_case_xpath')}
    Click Element Custom    ${wvar('delete_confirm_ok_xpath')}
    Wait Until Element Is Visible    ${wvar('delete_reason_code_dd_xpath')}    ${wvar('shortwait')}
    Select From List By Value    ${wvar('delete_reason_code_dd_xpath')}    5008
    Take Screenshot    selenium
    Click Element Custom    ${wvar('case_delection_confirmation_yes_btn_xpath')}
    Click Element Custom    ${wvar('validation_confirm_ok_button_xpath')}

change in product
    [Documentation]    change in product
    ${warning_yes}=   Run Keyword And Return Status      Wait Until Element Is Visible    ${wvar('confirmation_popup_yes')}    4s
    Run Keyword If     ${warning_yes}     Click Element     ${wvar('confirmation_popup_yes')}
    Wait for Element display


Select Reporter Qualifiction From Reporter Tab
    [Documentation]    Select Reporter Qualification From Reporter Tab
    [Arguments]    ${Reporter_Qualification}    
    Log      ${Reporter_Qualification}
    Scroll Element Into View    ${wvar('reporter_qualification_xpath')}    
    ${res}   Replace String            ${wvar('common_dropdown_select_xpath')}     replace    ${wvar('reporter_qualification_text')}
    Scroll Element Into View    ${res}
    ${res_optn}   Replace String            ${wvar('common_dropdown_optn_select_xpath')}     replace    ${Reporter_Qualification}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Wait Until Element Is Visible       ${res}     30s
    Click Element                       ${res}
    Sleep    2s
    Input Text    ${wvar('reporter_qualification_searchbox_xpath')}    ${Reporter_Qualification}
    Wait Until Keyword Succeeds    10s    2s    Click Element        ${res_optn}    
    Replace xpath Then Highlight Dropdown    ${wvar('reporter_qualification_text')}        

Handle Modify Confirmtion Popup
    [Documentation]    Handle Modify Confirmtion Popup
    ${modify_confirm_status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('confirmation_yes_popup_xpath')}    5s
    IF    '${modify_confirm_status}' == 'True'
        Click Element Custom    ${wvar('confirmation_yes_popup_xpath')}
        Log    Clicked Yes on Modify Confirmation Popup
    END

Create RCT And Move To Distribute Transit Stage And Return AER No
    [Documentation]    Create RCT And Move To Distribute Stage And Return AER No
    ${RCT_No}=    Upload AER Data    ${EXECDIR}/Resource/Json/final_review_stage_RCT1.json    
    Set Test Variable    ${RCT_No}  
    Search for RCT Latest    ${RCT_No}  
    Wait For General Tab
    Classify the complaint in LSMV Application
    ${AER_No}=    Fetch The AER No
    Handle Reporter Country and Region    ${wvar('authorization_country_field_optn')}    Alabama
    Select Product Tab
    Select Product Characterization From Product Tab    Suspect
    Move RCT Stage from Intake and Assignment to Target Stage    ${RCT_No}    ${wvar('distribute_transit_text')}    
    RETURN     ${AER_No}

Input Parent Medial History Start Date
    [Documentation]     Input Parent Medial History Start Date
    [Arguments]    ${Parent_Medical_History_Start_Date}
    Log    ${Parent_Medical_History_Start_Date}
    ${start_Date_title}=    Set Variable    ${wvar('parent_medical_hist_startdate_title')}
    ${res1}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${start_Date_title}
    Wait Until Element Is Visible       ${res1}      ${wvar('normalwait')}
    Scroll Element Into View            ${res1}
    Clear Element Text    ${res1}
    Press Key    ${res1}    ENTER
    Select Date    ${start_Date_title}    ${Parent_Medical_History_Start_Date}
    ${Highlight_start_Date_xpath}    Replace String    ${wvar('highlight_date_xpath')}    replace    ${wvar('parent_medical_hist_startdate_title')}    
    Highlight WebElement    ${Highlight_start_Date_xpath}

Input Parent Medial History End Date
    [Documentation]     Input Parent Medial History End Date
    [Arguments]    ${Parent_Medical_History_End_Date}
    Log    ${Parent_Medical_History_End_Date}    
    ${end_Date_title}=    Set Variable    ${wvar('parent_medical_hist_enddate_title')}
    ${res2}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${end_Date_title}
    Wait Until Element Is Visible       ${res2}      ${wvar('normalwait')}
    Scroll Element Into View            ${res2}
    Clear Element Text    ${res2}
    Press Key    ${res2}    ENTER
    Select Date    ${end_Date_title}    ${Parent_Medical_History_End_Date}
    ${Highlight_end_Date_xpath}    Replace String    ${wvar('highlight_date_xpath')}    replace    ${wvar('parent_medical_hist_enddate_title')}    
    Highlight WebElement    ${Highlight_end_Date_xpath}

Select Medical History Tab From Parent Tab
    [Documentation]    Select Medical History Tab From Parent Tab
    ${Mediacl_hist_xpath}=    Replace String    ${wvar('internal_tab_headers')}    replace    ${wvar('medical_history_tab_name')}
    Click Element Custom    ${Mediacl_hist_xpath}

Enter Report Disease Term In Parent Tab
    [Documentation]    Enter Report Disease Term In Parent Tab
    [Arguments]    ${reported_disease}
    Select Medical History Tab From Parent Tab
    Click Element Custom    ${wvar('report_disease_parent_txtbx')}
    Input Text    ${wvar('report_disease_parent_txtbx')}    ${reported_disease}

Enter Disease Type In Parent Tab
    [Documentation]    Enter Disease Type In Parent Tab
    [Arguments]    ${Disease_type}
    Select Medical History Tab From Parent Tab
    Selct Value From Drop Down    ${wvar('disease_type_dd_xptha')}    ${Disease_type}
    # Highlight and Replace xpath for input text    ${wvar('disease_type_field_text')}

Clear Parent Medical Start Date 
    [Documentation]    Clear Parent Medical Start Date 
    ${start_Date_title}=    Set Variable    ${wvar('parent_medical_hist_startdate_title')}
    ${res1}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${start_Date_title}
    Wait Until Element Is Visible       ${res1}      ${wvar('normalwait')}
    Scroll Element Into View            ${res1}
    # Clear Element Text    ${res1}    
    Clear Text Box Advanced    ${res1}

Clear Parent Medical End Date 
    [Documentation]    Clear Parent Medical End Date
    ${end_Date_title}=    Set Variable    ${wvar('parent_medical_hist_enddate_title')}
    ${res2}    Replace String  ${wvar('common_date_input_field_xpath')}   replace    ${end_Date_title}
    Wait Until Element Is Visible       ${res2}      ${wvar('normalwait')}
    Scroll Element Into View            ${res2}
    # Clear Element Text    ${res2}
    Clear Text Box Advanced    ${res2}

Select Duration And Duration Data Type
    [Documentation]    Select Duration And Duration Data Type
    [Arguments]    ${Duration}   ${Duration_Unit}
    Wait Until Element Is Visible    ${wvar('parent_medical_hist_xpath')}
    IF    '${Duration}' == 'Blank'
        # ${Duration}=    Set Variable    ${EMPTY}
        Clear Text Box Advanced   ${wvar('parent_medical_hist_xpath')}
    ELSE
        Input Text     ${wvar('parent_medical_hist_xpath')}    ${Duration}
    END
    IF    '${Duration_Unit}' == 'Blank'
        ${Duration_Unit}=    Set Variable    --Select--
    END
    Click Element Custom    ${wvar('duration_type_dd_trigger_xpath')}
    Wait Until Element Is Visible    ${wvar('input_search_xpath')}    ${wvar('shortwait')}
    Input Text    ${wvar('input_search_xpath')}    ${Duration_Unit}
    Replace xpath and click element    ${wvar('dropdown_list_option_xpath')}    ${Duration_Unit}        
    Highlight WebElement    ${wvar('highlight_duration_and_duration_type_xpath')}

Replace Xpath and Highlight elements
    [Documentation]    Highlight the text box for the given field
    [Arguments]    ${xpath}  ${field_name}
    ${res}   Replace String            ${xpath}     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Highlight WebElement    ${res}
    RETURN    ${res}

Replace text Then Search and Select from Dropdown for pulse11
    [Documentation]     To replace xpath and select a value from dropdown
    [Arguments]        ${xpath}     ${option}
    Wait For Element Display    
    ${res_optn}   Replace String            ${wvar('causality_common_dropown_value_xpath')}     replace    ${option}   
    Wait Until Keyword Succeeds    20s    1s     Click Element     ${xpath}
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Input Text      ${wvar('input_search_xpath')}    ${option}
    Wait Until Keyword Succeeds    10s    1s    Click Element        ${res_optn}

Highlight and Replace xpath for input text for pulse34
    [Documentation]    Replace xpath and input text
    [Arguments]        ${field_name}     
    ${res}   Replace String            (${wvar('text_bx_highlighting_xpath')})[1]     replace    ${field_name}
    Wait Until Keyword Succeeds    10s    1s    scroll element into view    ${res}
    Highlight WebElement    ${res}

Clear Text Box Advanced
    [Documentation]    Advanced method to clear text box with proper event triggering
    [Arguments]    ${locator}
    # Method 1: Try Clear Element Text first
    ${status1}=    Run Keyword And Return Status    Clear Element Text    ${locator}
    IF    '${status1}' == 'True'
        # Trigger events to notify Angular/JavaScript framework using ID-based approach
        ${element_id}=    Get Element Attribute    ${locator}    id
        Execute JavaScript    
        ...    var element = document.getElementById('${element_id}'); 
        ...    if (element) { 
        ...        element.focus(); 
        ...        element.dispatchEvent(new Event('input', {bubbles: true})); 
        ...        element.dispatchEvent(new Event('change', {bubbles: true})); 
        ...        element.blur(); 
        ...    }
        RETURN
    END
    
    # Method 2: Fallback to keyboard simulation
    Set Focus To Element    ${locator}
    Press Keys    ${locator}    CTRL+a
    Press Keys    ${locator}    BACKSPACE
    Sleep    0.5s
    # Ensure the change is registered using ID-based approach
    ${element_id}=    Get Element Attribute    ${locator}    id
    Execute JavaScript    
    ...    var element = document.getElementById('${element_id}'); 
    ...    if (element) { 
    ...        element.dispatchEvent(new Event('input', {bubbles: true})); 
    ...        element.dispatchEvent(new Event('change', {bubbles: true})); 
    ...        element.blur(); 
    ...    }

Handle Primarty Source Country Error
    [Documentation]    Handles the primary source country error popup if it appears during the workflow.
    ${primary_source_error_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${wvar('primary_source_country_error_xpath')}    5s
    IF    '${primary_source_error_present}' == 'True'
        Click Element Custom    ${wvar('primary_source_country_error_xpath')}
        Replace text contains then search and select from dropdown       ${wvar('country_field_text')}    SWITZERLAND ( CHE )
        ${warning_yes}=   Run Keyword And Return Status      Wait Until Element Is Visible    ${wvar('confirmation_popup_yes')}    4s
        Run Keyword If     ${warning_yes}     Click Element     ${wvar('confirmation_popup_yes')}
    END

Check if the complete activity dropdown is available instead of the cancel button
    [Documentation]    Check if the complete activity dropdown is available instead of the cancel button
    [Arguments]    ${rct_number_json}
    ${verify_dropdwn}=    Run Keyword And Return Status  Wait Until Element Is Visible   ${wvar('workflow_dropdown_xpath')}
    WHILE  '${verify_dropdwn}'=='False'  limit=4
         The User navigates to the Case Listing module under Case Management
         Search for AER  ${rct_number_json}
         Wait Until Keyword Succeeds  50s    2s    Wait Until Element Is Visible      ${wvar('current_workflow_xpath')}
         ${check_dropdwn_current}=    Run Keyword And Return Status  Wait Until Element Is Visible   ${wvar('workflow_dropdown_xpath')}   50s
         IF  '${check_dropdwn_current}'=='True'
             BREAK
         END
    END