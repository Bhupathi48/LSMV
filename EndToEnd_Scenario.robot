*** Settings ***
Documentation     qtest-folderID: 129030
Suite Setup       Log to Console    Keyword is executed once before first test in the suite
Suite Teardown    Close Browser
Test Setup        Log to Console    This keyword is executed before every test
Test Teardown     Close All Browsers
Library           DataDriver    LSMV_TestData.xlsx    sheet=CreateRCTinLSR
Resource         ../Support_Web_File.robot
Force Tags        Regression
# Test Template     LSMV_End_to_End_Scenario

*** Test Cases ***
LSMV_End_to_End_Scenario
    [Documentation]    This Test will validate End to End Scenario
    [Tags]  JDNS-0112   POC_WEB    Test
    #[Template]    LSMV_End_to_End_Scenario

***Keywords***
# LSMV_End_to_End_Scenario
#     [Documentation]    This Test will validate End to End Scenario
#     [Arguments]    ${Test_Case_ID}	${Scenario_Name}	${Followup}	${RCT}	${adverse_event_option}	${quality_product_complaint_option}	${was_complaint_reported_option}	${complaint_date_value}	${narrative_additional_value}	${product_purchased_in_value}	${product_value}	${reporter_role_value}	${consumer_provided_permission_option}	${reporter_first_name_value}	${reporter_last_name_value}	${reporter_state_value}	${reporter_country_value}	${suspect_product_value}	${was_action_taken_option}	${was_part_of_cart_pathway_option}	${is_product_lot_number_available_option}	${suspect_lot_number_value}	${is_product_sample_available_option}	${complaint_description_value}	${lsr_what_complaint_outcome_value}	${patient_initials_value}	${patient_medical_history_value}	${provide_product_history_value}	${lsr_product1_name_value}	${lsr_product2_name_value}	${lab_investigations_first_value}	${lab_investigations_second_value}	${lab_test_result}
#     [Setup]    Read Test Data From Excel For RCT   TC011
#     Log   ${Scenario_Name}
#     Given Login to LSRApplication Operator as user  
#     When Create complaint in LSR Application using Data file    ${Test_Case_ID}    ${Scenario_Name}    ${Followup}    ${RCT}    ${adverse_event_option}    ${quality_product_complaint_option}    ${was_complaint_reported_option}    ${complaint_date_value}    ${narrative_additional_value}    ${product_purchased_in_value}    ${product_value}    ${reporter_role_value}    ${consumer_provided_permission_option}    ${reporter_first_name_value}    ${reporter_last_name_value}    ${reporter_state_value}    ${reporter_country_value}    ${suspect_product_value}    ${was_action_taken_option}    ${was_part_of_cart_pathway_option}    ${is_product_lot_number_available_option}    ${suspect_lot_number_value}    ${is_product_sample_available_option}    ${complaint_description_value}    ${lsr_what_complaint_outcome_value}    ${patient_initials_value}    ${patient_medical_history_value}    ${provide_product_history_value}    ${lsr_product1_name_value}    ${lsr_product2_name_value}    ${lab_investigations_first_value}    ${lab_investigations_second_value}    ${lab_test_result}
#     And User Login into the LSMV application
#     When User navigated to the Case Listing module under Case Management    
#     And Search for LSR Aer in LSMV Application
#     And Classify the complaint in LSMV Application
#     Then Complete End to End Scenario
    #Then Verify LSR RCT complete status 
