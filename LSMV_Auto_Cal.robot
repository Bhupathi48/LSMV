*** Settings ***
Documentation       LSMV Project Automation POC
...                 qtest-folderID: 129030
Resource            ../Support_Web_File.robot
Suite Setup         Log to Console    Keyword is executed once before first test in the suite
Suite Teardown      Close Browser
Test Setup          Log to Console    This keyword is executed before every test
Test Teardown       Close All Browsers
Force Tags          robot:continue-on-failure


*** Test Cases ***
LSMV_Autocalc_PULSE_CDDR91_Medical_History_Duration_calculation
    [Documentation]    This Test will validate the calculate the Duration when the Precise dates are provided in Start Date
    ...    and End Date fields under the Parent |Medical History tab.
    [Tags]  JDNS-91     CDDR91    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT   TC008        
    Given User Login into the LSMV application    
    When The User navigates to the Case Listing module under Case Management   
    Then Verify Auto-calc PULSE-CDDR91 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Autocalc_PULSE_CDDR30_Primary_Reporter
    [Documentation]    This Test will validate PULSE Primary Reporter
    [Tags]  JDNS-30     CDDR30    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT   TC009    
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE-CDDR30 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-calc_PULSE-CDDR28_Hospitalization_Duration_Validation
    [Documentation]    The objective of this test case is to verify that in LSMV System if the Event seriousness for Caused/Prolonged Hospitalization.
    [Tags]    jdns-0028    autocalc    test    agent3    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC007
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE-CDDR28 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_DueDateRule
    [Documentation]    LSMV Auto-Calculator PULSE-DueDateRule
    [Tags]    jdns-0001    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC016
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Navigate to General Tab and Enter Company Unit, Latest Received Date, Sender Organization and Primary Source Country
    Then Verify Autocalc Pulse-DueDateRule
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR13_Vaccine_Facility_Final_Review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR13 Nullflavor values - Vaccine Facility Final Review
    [Tags]    jdns-13    autocalc    agent5
    [Setup]    Read Test Data From Excel For RCT    TC006_1
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR13 with Vaccine Facility 3
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR13_Vaccine_Facility_Final_Review_three
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR13 Nullflavor values - Vaccine Facility Final Review
    [Tags]    jdns-013    autocalc    agent5
    [Setup]    Read Test Data From Excel For RCT    TC006
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR13 with Vaccine Facility
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV Auto-Calculator PULSE-CDDR43 Route of Admin_Unknown_Null flavor_Accounts group_Fully Automated Case
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR43 Route of Admin_Unknown_Null flavor_Accounts group_Fully Automated Case
    [Tags]    jdns-43    autocalc    agent5
    [Setup]    Read Test Data From Excel For RCT    TC010
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify the Auto-Calculator PULSE-CDDR43 Route of Admin
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR07_Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review For Suspect
    [Documentation]   LSMV Auto-Calculator Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review
    [Tags]    JDNS-0007     CDDR07    autocalc    Agent2
    [Setup]    Read Test Data From Excel For RCT   TC0157        
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR07 With Populate No Information Nullflavor Vaccine More Minor Change and Final Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR07_Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review For Interacting
    [Documentation]   LSMV Auto-Calculator Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review
    [Tags]    JDNS-0007     CDDR07_1    autocalc    Agent2
    [Setup]    Read Test Data From Excel For RCT   TC0157_1    
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR07 With Populate No Information Nullflavor Vaccine More Minor Change and Final Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR07_Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review For Drug Not Administered
    [Documentation]   LSMV Auto-Calculator Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review
    [Tags]    JDNS-0007     CDDR07_2    autocalc    Agent2
    [Setup]    Read Test Data From Excel For RCT   TC0157_2    
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR07 With Populate No Information Nullflavor Vaccine More Minor Change and Final Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR04_Patient_Age_Group_Sex
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR04 Patient Age Group and Sex
    [Tags]    jdns-0004    autocalc    test    agent3    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-153
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR04 with Patient Age Group and Sex
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}


LSMV_Auto-Calculator_PULSE-CDDR08_E2B_Case_References_in_Previous_Transmissions
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR08 E2B Case References in Previous Transmissions
    [Tags]    jdns-0008    autocalc    APPROVED    agent3
    [Setup]    Read Test Data From Excel For RCT    TC-271
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR08 with E2B Case References in Previous Transmissions
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR09_Patient ID_Populate NF_Asked But Unknown_Fully_Automated_Case
    [Documentation]    The objective of this test case is to verify that, upon completion of Initial Workflow activity, when an E2B case is received from the Fully_Automated account group, the Patient ID [B.1.1][D.1][Pa.1] is populated with "Asked but Unknown" null flavor when blank, and when the following conditions are met:
    ...    Field is blank
    ...    Field contains the literal "UNKNOWN"
    ...    Field contains the literal "UNK"
    ...    Field has a value that contains any literal like "UNK"
    [Tags]    jdns-0009    cddr09_1   APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-155
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR09 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR18_Copy_patient_data_patient_information
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR18 Copy patient data patient information
    [Tags]    jdns-18    cddr18    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC0290
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR18 Copy patient data patient information
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto_Calculator_PULSE_PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_Spontaneous
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR20 Reporter Company Causality Possible On Save Spontaneous
    [Tags]    jdns-20    cddr20    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC0279
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_Spontaneous
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto_Calculator_PULSE_PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_other
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR20 Reporter Company Causality Possible On Save Other
    [Tags]    jdns-20    cddr20_1    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC0279_1
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_Spontaneous
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto_Calculator_PULSE_PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_Not_Available
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR20 Reporter Company Causality Possible On Save Not Available
    [Tags]    jdns-20    cddr20_1git    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC0279_2
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_Spontaneous
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR15_Report Classification_Non-AE_US or and EMA_Final Review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR15 Report Classification Non-AE US or and EMA Final Review
    [Tags]    jdns-15    cddr15_fr    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC0293
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR15 With Report Classification Non-AE US or and EMA Final Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR15_Report Classification_Non-AE_US or and EMA Minor Change
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR15 Report Classification Non-AE US or and EMA Minor Change
    [Tags]    jdns-15    cddr15_mc    autocalc    Agent2    APPROVED    
    [Setup]    Read Test Data From Excel For RCT    TC0293_1
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR15 With Report Classification Non-AE US or and EMA Minor Change
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR23_SUSAR_product_event_Type_Labeling_Seriousness_Causality
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR23 SUSAR_product_event combination_Report type_Study Type_Labeling_Seriousness_Causality
    [Tags]    jdns-23    cddr23    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC174
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR23_SUSAR_product_event_Type_Labeling_Seriousness_Causality
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR10_1_Autopsy Done_Auto_Null Flavor_Fully Automated
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR10_1 Autopsy Done Auto Null Flavor Fully Automated
    [Tags]    jdns-010    cddr10_1    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC168
    Given User Login into the LSMV application
    Then Verify Auto-calc PULSE_CDDR10_Autopsy_Done_Auto_Null_Flavor_Fully_Automated
    And User Logout from the LSMV application

    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR09_Patient ID_Populate_Asked But Unknown_Inbound UnStructured Automation Final Review
    [Documentation]   The objective of this test case is to verify that, upon completion of Final Review or Minor Change WF activities, the Patient ID [B.1.1][D.1][Pa.1] field, in the Full Data Entry Form, is:
    ...    populated with "Asked but Unknown" null flavor when blank, and when the following conditions are met:
    ...    Field is blank
    ...    Field contains the literal "UNKNOWN"
    ...    Field contains the literal "UNK"
    ...    Field has a value that contains any literal like "UNK"
    ...    Not populated with "Asked but Unknown" null flavor when a null flavor value is already populated in the field:
    ...    Not Applicable
    ...    Not Asked
    [Tags]    JDNS-9    CDDR09  Test    Agent4    APPROVED
    [Setup]    Read Test Data From Excel For RCT   TC-158   
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR09 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    And User Logout from the LSMV application 
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}       

LSMV_Auto-Calculator_PULSE-CDDR32_Product_Action_Taken_With_Drug_Copy_to_Causality_Screen
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR32 Product Action Taken With Drug Copy to Causality Screen
    [Tags]    JDNS-0032    autocalc  Test    regression    Agent3
    [Setup]    Read Test Data From Excel For RCT   TC-178
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR32 with Product Action Taken With Drug Copy to Causality Screen
    And User Logout from the LSMV application
    [Teardown]     Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR38_Case_Significance_Follow_up_Version
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR38 Case Significance Follow-up Version
    [Tags]    JDNS-0038    autocalc   Agent4    APPROVED
    [Setup]    Read Test Data From Excel For RCT   TC-338
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR38 Case Significance Follow-up Version
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}       

LSMV_Auto-Calculator_PULSE-CDDR42_1_Form of Admin_ Auto_Unknown_ Nullflavour
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR42_1 Form of Admin Auto Unknown Nullflavour
    [Tags]    jdns-0042    autocalc    APPROVED    agent3
    [Setup]    Read Test Data From Excel For RCT    TC-451
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Autocalc Pluse-CDDR42_1 Form of Admin Auto Unknown Nullflavour
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR_11_Lot_Batch_Unknown_Nullflavor
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR11 Lot/Batch No Unknown/Nullflavor
    [Tags]    jdns-11    autocalc    agent6    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC023
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR11 Scenario for Unknown/Nullflavor validation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR11_1_Lot_Batch.
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR11-1 Lot/Batch No Populate
    [Tags]    jdns-11_1    autocalc    agent6    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC024
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE-CDDR11 Scenario for therapy validation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR11_1_Lot_Batch
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR11-1 Lot/Batch No Populate
    [Tags]    jdns-11_1-2    autocalc    agent6    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-11_1
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE-CDDR11 Scenario for therapy validation for Inbound_Structured/Unstructured_Automation_account
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto_Calculator_PULSE_CDDR34_Investigational Product Blinded
    [Documentation]    LSMV Auto-Calculator PULSE_CDDR34_Investigational Product Blinded
    [Tags]    jdns-34    autocalc    agent6
    [Setup]    Read Test Data From Excel For RCT    TC021
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR34 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR46_Reporter_Company_Causality_Mapping_from_E2B Causalities
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR46 Reporter Company Causality Mapping from E2B Causalities
    [Tags]    jdns-0046    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-286
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR46 Reporter Company Causality Mapping from E2B Causalities
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR39_Company_Received_Date
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR39 Company Received Date
    [Tags]    jdns-39    cddr39    autocalc    agent7    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-187
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE_CDDR39_Company_Received_Date
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR37_Remove_Causality_WHO_DD_On_Save
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR37 Remove Causality WHO DD On Save
    [Tags]    jdns-37    cddr37    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC417
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR37_Remove_Causality_WHO_DD_On_Save
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR31_Product_Auto_Ranking
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR31 Product Auto Ranking
    [Tags]    jdns-31    cddr31    autocalc    Agent2
    [Setup]    Read Test Data From Excel For RCT    TC186
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR31_Product_Auto_Ranking_On_Save
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR60_Processing_unit_Populate_Company_Unit
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR60 Processing unit Populate Company Unit
    [Tags]    jdns-60    cddr60    autocalc    agent9
    [Setup]    Read Test Data From Excel For RCT    TC-272
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE_CDDR60_Processing_unit_Populate_Company_Unit
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR103_Study_Registration
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR103 Study Registration Should Auto Populate
    [Tags]    jdns-103    cddr103    autocalc    agent9    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-517
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDD103 Study Registration
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR29_Contact_Email Address_First name_Last name
    [Documentation]    LSMV ACT PULSE-CDDR29_Contact_Email Address_First name_Last name
    [Tags]    jdns-29    cddr29    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-147
    Given User Login Into The LSMV Application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify ACT_PULSE-CDDR29_Contact_Email Address_First name_Last name
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR41_Event_Onset_Date_End_Date
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR41-1 Event Onset Date and End Date
    [Tags]    jdns-41    cddr41    autocalc    agent6
    [Setup]    Read Test Data From Excel For RCT    TC020
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR41 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR56_Populate_Reporter_Country_Final Review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR56 Populate Reporter Country
    [Tags]    jdns-56    cddr56_1    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-287
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR56 Populate Reporter Country Final Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR59_Company_No_Authority_No_move_to_Reference_No
    [Documentation]    LSMV_Auto-Calculator_PULSE-CDDR59 Company_No Authority_No move to Reference_No
    [Tags]    jdns-059    cddr59    autocalc    agent10
    [Setup]    Read Test Data From Excel For RCT    TC-189
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify the Auto-Calculator PULSE-CDDR59_Company_No_Authority_No_move_to_Reference_No
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR107_Causality_Blank
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR107 Automatically Populate Reporter Causality and Company Causality as Blank when Inactive Code Present
    [Tags]    jdns-107    cddr107    autocalc    agent9    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-656
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDD107 Causality Blank
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR16_Product_Flag_populate_drug_WHODD not blank
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR16 validates that the Product Flag auto-populates when Drug WHODD code/name is not blank
    [Tags]    jdns-16    cddr16    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-173
    Given User Login Into The LSMV Application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR16_Product_Flag_populate_drug_WHODD not blank
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR96_Sender Organization as Coded_CCVUSA
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR96 Company Unit And Processing Unit As GMSCP And    Sender Organization As Coded    CCVUSA
    [Tags]    jdns-96    cddr96    autocalc    agent9
    [Setup]    Read Test Data From Excel For RCT    TC-622
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR96 Sender Organization as Coded CCVUSA
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR82_Additional_Source
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR82 Additional Source
    [Tags]    jdns-82    cddr82    autocalc    agent7    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-196
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR82_Additional_Source
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR61_Dechallenge_Rechallenge
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR61 Dechallenge Rechallenge
    [Tags]    jdns-61    cddr61    autocalc    Agent2
    [Setup]    Read Test Data From Excel For RCT    TC-274
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR61_Dechallenge_Rechallenge
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR06_Populate_ASKU_Reporter_State_Final_review_Minor_Change_Suspect_Drug_Not_Adminstation_Intreacting
    [Documentation]    This Test will validate the ASKU Reporter State in Final review and minor change workflow
    [Tags]    jdns-6    autocalc    agent5
    [Setup]    Read Test Data From Excel For RCT    TC-166
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR06 Populate ASKU Reporter State Suspect Intraction Drug not adminstation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR22_Causality_Populate_Start Latency1
    [Documentation]    Verify that the system correctly calculates Start Latency as the difference between the Earliest Therapy Start Date and the Event Onset Date following specified logic rules,
    ...    including unit conversion to days, minutes, or hours, with appropriate handling of blank or invalid dates.
    [Tags]    jdns-22    autocalc    agent5
    [Setup]    Read Test Data From Excel For RCT    TC-658
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR22_Causality_Populate_Start Latency1
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR33_Literature Document Name
    [Documentation]    Verify Autocalc PULSE-CDDR33_Literature Document Name
    [Tags]    JDNS-33    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-423
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR33_Literature Document Name
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR43_1_Route of Admin_Unknown_Null flavor_Accounts group
    [Documentation]    Verify    Auto-Calculator PULSE-CDDR43_1 the Route of admin.[B.4.k.8][G.k.4.r.10.1] to Unknown (null flavor) upon completion of Initial workflow activity,
    ...    if the fields is left blank in any therapy record across all products in the case. If any null flavor is populated in the field, then the field value is not autocalculated to Null flavor.
    [Tags]    JDNS-43    autocalc    agent5
    [Setup]    Read Test Data From Excel For RCT    TC-183
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR43_1_Route of Admin_Unknown_Null flavor_Accounts group
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR48_Event_Outcome_Default
    [Documentation]    Verify    Auto-Calculator PULSE-CDDR48 the Event Outcome field [B.4.j.5][G.k.4.q.6] to Default value of 'Unknown' upon completion of Initial workflow activity,
    [Tags]    JDNS-48    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-185
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR48 Event Outcome Default
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR62_Gestational_Age_At_Event
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR62 Gestational Age At Event
    [Tags]    jdns-62    cddr62    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-190
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR62_Gestational_Age_At_Event
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR106_Report Receiving Medium_Async API
    [Documentation]    Verify    Auto-Calculator PULSE-CDDR106_Report Receiving Medium_Async API
    [Tags]    jdns-106    cddr106    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-623
    Given User Login Into The LSMV Application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR106_Report Receiving Medium_Async API
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR25_Initial_Version_Case Significance_Manual_Field
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR25 Initial Version Case Significance Manual Field
    [Tags]    jdns-25    cddr25    autocalc    agent7    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-177
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR25_Initial_Version_Case Significance_Manual_Field
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR50_Post_Marketed_USA_Approval_Spontaneous
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR50 Post Marketed USA Approval Spontaneous
    [Tags]    jdns-50    cddr50    autocalc    agent9
    [Setup]    Read Test Data From Excel For RCT    TC-285
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR50 Post Marketed USA Approval Spontaneous
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR51_IND approval_Clinical_Trial case
    [Documentation]   This Case will Validate The LSMV system must automatically populate an IND approval for a case with Study Type="Clinical Trial" and when there is a study product in the product tab with Product Characterization (G.k.1)=Suspect or Interacting or Drug not adminstered or Similar Device and if only one active US IND approval exists in the Study Product Dictionary under the same LTN and Formulation provided if there is no active US IND approval already exists in the case.
    ...    Following fields needs to be populated from the Study Product Dictionary for the IND Approval:
    ...    1. Trade/Brand Name , 2. Product Flag, 3. Marketing Authorization Holder to MAH as Coded at case level, 4. Marketing Authorization Holder to MAH as Reported at case level
    ...    5. Approval Type = "IND Number", 6. Authorization Country = "United States of America", 7. Authorization Number[B.4.k.4.1][G.k.3.1], 8. License status=Active
    [Tags]    jdns-51    cddr51    autocalc    agent10    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-660
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR51 IND approval Clinical Trial case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR77_CT_EU Labeling
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR77 CT EU labeling
    [Tags]    jdns-0077    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-209
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Autocalc Pluse-CDDR77 CT EU labeling
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR80_Report Classification_Non Case_Duplicate
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR80 Report Classification Non Case Duplicate
    [Tags]    jdns-80    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-144
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR80 Report Classification Non Case Duplicate
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR52_Race_Ethnicity
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR52 Race Ethnicity
    [Tags]    jdns-0052    autocalc    APPROVED    agent6
    [Setup]    Read Test Data From Excel For RCT    TC022
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR52 Race Ethnicity
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR53_Fatal_Outcome_Roll_up
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR53 Fatal Outcome Roll-up
    [Tags]    jdns-0053    autocalc   APPROVED    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-289
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR53 Fatal Outcome Roll-up
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR94_Additional Documents_Re-Calculation
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR94 Additional Documents Re-Calculation
    [Tags]    jdns-94    cddr94    autocalc    agent9    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-414
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR94 Additional Documents Re-Calculation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR63_Event_Received
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR63 Event Received
    [Tags]    jdns-63    cddr63    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC-421
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE_CDDR63_Event_Received_Date
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR105_Coding_Class
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR105 Coding Class
    [Tags]    jdns-105    cddr105    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-850
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR105_Coding_Class
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR92_DO_NOT_USE_ANG_FROM_PARENT_CASE
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR92 DO NOT USE ANG FROM PARENT CASE
    [Tags]    jdns-92    cddr92    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-203
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR92_DO_NOT_USE_ANG_FROM_PARENT_CASE
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR69_Event_Received_Korean_Evaluation_KRCT_EVALUATION_RESULT
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR69 Event Received Korean Evaluation KRCT EVALUATION RESULT In
    ...    In Final Review and minor Stage
    [Tags]    jdns-69    cddr69    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-273
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR69_Event_Received_Korean_Evaluation_KRCT_EVALUATION_RESULT
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_Nullification_Reason_Followup
    [Documentation]    LSMV Auto-Calculator PULSE_Nullification_Reason_Followup
    [Tags]    jdns-69    cddr01    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-01
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_Nullification_Reason_Followup
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR131_Scheduler_With_Schedule_Name
    [Documentation]    The system should automatically set the Status of the schedule FUQ to "Closed"
    ...    for the schedule with Schedule Name ='' Literature_Ex_US_COE".
    [Tags]    jdns-69    cddr131    autocalc    Agent2    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-131
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR131_Scheduler_With_Schedule_Name
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR90_Medical history_disease type
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR90 Medical history_disease type
    [Tags]    jdns-90    cddr90    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-207
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR90_Medical history_disease type
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR114_Auto_Populate_Event_Type
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR114 Auto Populate Event Type
    [Tags]    jdns-114    cddr114    autocalc    agent9    APPROVED
    [Setup]    Read Test Data From Excel For RCT    CDDR-114
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Autocalc Pulse-CDDR114 Auto Populate Event Type
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR26_Fully_Automated_Additional Documents_Available_Final_Review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR26 Fully Automated Additional Documents Available Final Review
    [Tags]    jdns-26    cddr26    autocalc    agent7    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-295
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE_CDDR26_Fully_Automated_Additional Documents_Available_Final_Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR54_Study Patient Number
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR54 Study Patient Number
    [Tags]    jdns-0054    autocalc    test    regression    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-290
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Autocalc Pluse-CDDR54 Study Patient Number
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR49_Account Type_Prefix_Event Description
    [Documentation]    Verify Auto-Calculator PULSE-CDDR49. This test case ensures the correct prefix is populated in the Event Description field based on the Account Type.[Documentation]    Verify Auto-Calculator PULSE-CDDR49. This test case ensures the correct prefix is populated in the Event Description field based on the Account Type.
    [Tags]    jdns-49    cddr49    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-291
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR49 Account Type Prefix Event Description
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR55_Indication_Blank_Default_Product_Used_For_Unknown_Indication
    [Documentation]    This test verifies Indication Term [B.4.k.11b][G.k.7.r.1] defaults to "Product used for unknown indication" or remains unchanged based on blank fields, null flavors, and Sender Organization matching Account Name in Account Group.
    [Tags]    JDNS-55    cddr55    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-269
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR55 Indication Blank Default Product Used For Unknown Indication
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR57_Automation_Account group_Country_Regional State_and_State_For_Spain
    [Documentation]    Verify LSMV Auto-Calculator PULSE-CDDR57 Regional State as Unknown for blank fields with specific reporter types and countries Spain.
    [Tags]    JDNS-57    cddr57    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-415
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR57 Automation Account group Country Regional State and State For Spain
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR57_Automation_Account group_Country_Regional State_and_State_For_Italy
    [Documentation]    Verify LSMV Auto-Calculator PULSE-CDDR57 Regional State as Unknown for blank fields with specific reporter types and countries Italy.
    [Tags]    JDNS-57    cddr57    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-415_1
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR57 Automation Account group Country Regional State and State For Italy
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR47_NF_Unknown_Medical History_Co-med
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR47 NF Unknown Medical History Co-med
    [Tags]    JDNS-47    autocalc  APPROVED    Agent3
    [Setup]    Read Test Data From Excel For RCT   TC-294
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR47 NF Unknown Medical History Co-med
    And User Logout from the LSMV application 
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}       


LSMV_Auto-Calculator_PULSE-CDDR47_1_NF_Unknown_Medical History_Co-med
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR47 NF Unknown Medical History Co-med
    [Tags]    jdns-047    cddr47_1    autocalc    test    regression    agent3
    [Setup]    Read Test Data From Excel For RCT    TC-297
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR47 NF Unknown Medical History Co-med
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_PULSE_CDDR58_Reporter_Qualification
    [Documentation]    Verify LSMV Auto-Calculator PULSE-CDDR58_Reporter_Qualification_Default_Value_For_Blank_Field_After_Initial_Review
    [Tags]    JDNS-58    cddr58    autocalc    agent5    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-336
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR58 Reporter Qualification Default Value For Blank Field After Initial Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR74_Local Criteria Report Type_Locally Expedited_Blank
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR74 Local Criteria Report Type Locally Expedited Blank
    [Tags]    jdns-74    autocalc    APPROVED    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-212
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR74 Local Criteria Report Type Locally Expedited Blank
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR65_Chinese_Evaluation_E2B_Causality_Result_INITIAL_REPORTER_MAH_EVALUATION_RESULTS
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR65 Chinese Evaluation E2B Causality Result INITIAL REPORTER MAH'S EVALUATION RESULTS
    [Tags]    jdns-65    cddr65    autocalc    agent9
    [Setup]    Read Test Data From Excel For RCT    TC-199
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR65 Chinese Evaluation E2B Causality Result INITIAL REPORTER MAH EVALUATION RESULTS
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR127_Report_Category
    [Documentation]    This test verifies that The system should automatically populate the Report Category as "Adverse event" when the Report Category values are popuated with 07 or 02
    [Tags]    jdns-127    cddr127    autocalc    agent10    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-127
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR127 Report Category
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR75_Lab_Result Unstructured_Populate_More Info_Initial and Final activity
    [Documentation]    LSMV_Auto-Calculator_PULSE-CDDR75_Lab_Result Unstructured_Populate_More Info_Initial and Final activity
    [Tags]    jdns-75    regression    autocalc    agent6    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-213
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Autocalc PULSE-CDDR75 Lab Result Unstructured Populate More Info Initial and Final activity
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR125_Regional_State_And_State_As_Unknown
    [Documentation]   This test verifies the system should automatically populate the Regional State[A.2.1.2e][C.2.r.2.5] to code list value of "Unknown" and State [A.2.1.2e][C.2.r.2.5] as "Unknown" 
    ...    when Regional State[A.2.1.2e][C.2.r.2.5]  field is populated with Null flavor as "MSK" or "NI" 
    ...    The system should ensure that the current values in the Regional State[A.2.1.2e][C.2.r.2.5]  and  State[A.2.1.2e][C.2.r.2.5] fields are cleared before updating the value of "Unknown"
    [Tags]    jdns-125    cddr125    autocalc    agent10    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-125
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR125 Regional State and State As Unknown
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR56_Populate_Reporter_Country_In_Initial_Case_With_blank_Value
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR56 Populate Reporter Country for Initial case with blank Value
    [Tags]    jdns-0056    cddr56    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-188
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR56 Populate Reporter Country for Initial case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR56_Populate_Reporter_Country_Initial_Case_With_Value
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR56 Populate Reporter Country for Initial case with Value
    [Tags]    jdns-561    cddr56    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-1881
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR56 Populate Reporter Country for Initial case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR83_Term Highlighted_Auto population
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR83 validates that the Term Highlighted auto-populates when blank for any event(Serious/Not Serious)
    [Tags]    jdns-83    cddr83    autocalc    Agent1    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-208
    Given User Login Into The LSMV Application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR83_Term Highlighted auto-populate
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR83_Case_deletion_Term Highlighted_Auto population
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR83 validates that the Term Highlighted auto-populates when blank for any event(Serious/Not Serious)
    [Tags]    jdns-083    cddr83_1    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC208
    Given User Login Into The LSMV Application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR83_Case_deletion_Term Highlighted auto-populate
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR123_Case_Documents_Options
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR123 Case Documents Is local options validation
    [Tags]    jdns-0123    cddr123    autocalc    APPROVED    agent4
    [Setup]    Read Test Data From Excel For RCT    TC-123
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR123 Case Documents Is local options validation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR81_Additional_documents_available_yes
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR81 Additional documents_available_yes and Final review
    [Tags]    jdns-81    cddr81_1    autocalc    agent10
    [Setup]    Read Test Data From Excel For RCT    TC-202
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR81 upload results
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR121_Expected_IsLocal_Checkbox_Autopopulation
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR121 Study Patient Number
    [Tags]    jdns-121    cddr121    autocalc    agent7
    [Setup]    Read Test Data From Excel For RCT    TC-6000
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR121-Expected_IsLocal_Checkbox_Autopopulation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR93_Case_Due_Date_Condition_1_and_Condition_3
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR93 Case Due Date for Condition 1 and Condition 3 in FDE, Quality Review and Final Review stages
    [Tags]    jdns-93    cddr93-1    autocalc    agent8
    [Setup]    Read Test Data From Excel For RCT    TC-540
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR93 Case Due Date Condition 1
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR93_Case_Due_Date_Condition_2_FDE_and_Quality_Review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR93 Case Due Date for Condition 2 in FDE and Quality Review stages
    [Tags]    jdns-93    cddr93-2    autocalc    agent8
    [Setup]    Read Test Data From Excel For RCT    TC-5401
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR93 Case Due Date Condition 2
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR93_Case_Due_Date_Condition_2_remaining conditions
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR93 Case Due Date for Condition 2 in Final Review stage
    [Tags]    JDNS-93    CDDR93-3    autocalc   Agent8
    [Setup]    Read Test Data From Excel For RCT   TC-5402
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR93 Case Due Date Condition 3
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR119_Initial_Received_Date_Populated_As_Latest_Received_Date
    [Documentation]   This Test Case verify that The system should automatically populate the Initial Received Date 
    ...     from Latest Received Date if the Report Receiving Medium is Copy and the receipt is unassessed.
    [Tags]    jdns-119    cddr119    autocalc    agent10    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-119
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR119 Initial Received Date Populated As Latest Received Date
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR112_Removal_of_timestamp_from_LRD_and_IRD
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR112 Removal of timestamp from Current Date
    [Tags]    jdns-112    cddr112    autocalc    agent7    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-7000
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Autocalc Pulse-CDDR112 Removal of timestamp from Current Date
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR95_Coding Class_Non-Blinded Case
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR95 validates that the TLSMV system automatically removes the data in the Coding Class for the product copied from Non-Blinded Study
    [Tags]    jdns-95    cddr95    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-197
    Given User Login Into The LSMV Application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR95_Coding Class_Non-Blinded Case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR116_Auto_Populate_Event_Type_In_FDE
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR116 Auto Populate Event Type In Full Data Entry
    [Tags]    jdns-116    cddr116    autocalc    agent9    APPROVED
    [Setup]    Read Test Data From Excel For RCT    CDDR-116
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR116 Auto Populate Event Type
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR108_Litrature_Document_category
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR108 Literature Document Category
    [Tags]    jdns-108    cddr108    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC-817
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR108_Litrature_Document_category
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR108_Litrature_Document_category_final_review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR108 Literature Document Category
    [Tags]    jdns-108-fr    cddr108    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC817
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR108_Litrature_Document_category_final_review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR109_Auto_Populate_Parent_gender_FR_DT_MR
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR109 Auto Populate Parent gender in Final/Minor changes
    [Tags]    jdns-109    cddr109    autocalc    Agent1
    [Setup]    Read Test Data From Excel For RCT    TC-843
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR109 Auto Populate Parent gender
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV Validator PULSE-CDDR14 for Regulatory Clock Start Date Validation
    [Documentation]    Regulatory Clock Start Date validation in LSMV Application
    [Tags]    jdns-00140    autocalc    agent6    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC019
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR14 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR71_E2B Causality_Clean up
    [Documentation]    LSMV_Auto-Calculator_PULSE-CDDR71_E2B Causality_Clean up
    [Tags]    jdns-71    regression    autocalc    agent6    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-215
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR71 E2B Causality_Clean up
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR52_1_Race_Ethnicity
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR52_1 Race Ethnicity
    [Tags]    jdns-0052_1    autocalc    APPROVED    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-214
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR52_1 Race Ethnicity
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR98_1_Schedule_No_follow_up_required_Fully_Automated_case
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR98.1 validates that the Follow-up Required field is auto-populated to 'No follow-up required' for Fully Automated cases when Schedule is set to 'Yes'
    [Tags]    jdns-98    cddr98_1    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-206
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR98_1_Schedule_No follow up required_Fully Automated case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR98_2_Schedule_No_follow_up_required_Condition_1
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR98.1 validates that the Follow-up Required field is auto-populated to 'No follow-up required' for Non-Fully Automated cases when Schedule is set to 'Yes'
    [Tags]    jdns-98_2_1    cddr98_2_1    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-205
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR98_2_Schedule_No follow up required_Condition_1
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR98_2_Schedule_No_follow_up_required_Condition_2
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR98.1 validates that the Follow-up Required field is auto-populated to 'No follow-up required' for Non-Fully Automated cases when Schedule is set to 'Yes'
    [Tags]    jdns-98_2_2    cddr98_2_2    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-210
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR98_2_Schedule_No follow up required_Condition_2
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR98_2_Schedule_No_follow_up_required_Condition_3
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR98.1 validates that the Follow-up Required field is auto-populated to 'No follow-up required' for Non-Fully Automated cases when Schedule is set to 'Yes'
    [Tags]    jdns-98_2_3    cddr98_2_3    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-2050
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR98_2_Schedule_No follow up required_Condition_3
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR98_3_Schedule_Unable_to_follow_up_required
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR98.1 validates that the Follow-up Required field is auto-populated to 'No follow-up required' for Non-Fully Automated cases when Schedule is set to 'Yes'
    [Tags]    jdns-98_3    cddr98_3    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-194
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR98_3_Unable_to_follow_up_required
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR117_Check_MeDRA_hierarchy
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR117 Check MeDRA hierarchy
    [Tags]    cddr117    autocalc    agent7
    [Setup]    Read Test Data From Excel For RCT    TC-8000
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE-CDDR117 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR117_Check_MeDRA_hierarchy_in_FR_NC_MC_CD
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR117 Check MeDRA hierarchy
    [Tags]    cddr117_1    autocalc    agent7
    [Setup]    Read Test Data From Excel For RCT    TC-8000_1
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR117 Scenario_in_FR_NC_MC_CD
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR72_Person Type_Patient_for_multiple_reporters
    [Documentation]    LSMV_Auto-Calculator_PULSE-CDDR72_Person Type_Patient
    [Tags]    jdns-72    autocalc    test    regression    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-216
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR72 Person Type Patient
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR72_Person Type_Patient
    [Documentation]    LSMV_Auto-Calculator_PULSE-CDDR72_Person Type_Patient
    [Tags]    jdns-72_1    autocalc    test    regression    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-216_1
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR72 Person Type Patient
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR130_Additional_Comments
    [Documentation]   This Test case Verify that Transfer the Event Description (H.1) in any non-English language to 
    ...    the Additional Comments field in the same language.
    [Tags]    jdns-130    cddr130    autocalc    agent10    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-130
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR130 Additional Comments
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR129_Auto_populate_constituent_products
    [Documentation]    LSMV_Auto-Calculator PULSE-CDDR129 Auto populate constituent products
    [Tags]    jdns-129    cddr129    autocalc    agent8    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-192
    Given User Login into the LSMV application
    When The User navigates to New Full Data Entry Form under Case Management
    Then Verify Auto-calc PULSE-CDDR129 auto populate constituent products
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR04_1_Inbound_Unstructured_Automation_Patient Age group_Sex
    [Documentation]    The objective of this test case is to verify that when an E2B case is received from the Inbound_Unstructured_Automation_account group, the Patient Age Group[B.1.2.3][D.2.3] and Sex[B.1.5][D.5] fields:
    [Tags]    jdns-4    autocalc    test    agent3    APPROVED
    [Setup]    Read Test Data From Excel For RCT    TC-154
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR04_1 with Patient Age Group and Sex
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR115_Auto_Populate_Subject_ID_from_Investigation_Number_and_vice_versa
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR115 Auto Populate Subject ID from Investigation Number and vice versa
    [Tags]    jdns-115    cddr115    autocalc    agent9    APPROVED
    [Setup]    Read Test Data From Excel For RCT    CDDR-115
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR115 Auto Populate Subject ID from Investigation Number and vice versa
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR09_Patient ID_Populate_Asked But Unknown_Inbound UnStructured Automation Minor Change
    [Documentation]   The objective of this test case is to verify that, upon completion of Final Review or Minor Change WF activities, the Patient ID [B.1.1][D.1][Pa.1] field, in the Full Data Entry Form, is:
    ...    populated with "Asked but Unknown" null flavor when blank, and when the following conditions are met:
    ...    Field is blank
    ...    Field contains the literal "UNKNOWN"
    ...    Field contains the literal "UNK"
    ...    Field has a value that contains any literal like "UNK"
    ...    Not populated with "Asked but Unknown" null flavor when a null flavor value is already populated in the field:
    ...    Not Applicable
    ...    Not Asked
    [Tags]    JDNS-09    CDDR09  Test    Agent4
    [Setup]    Read Test Data From Excel For RCT   TC-161   
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR09 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    And User Logout from the LSMV application 
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}       

LSMV_Auto-Calculator_PULSE-CDDR111
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR111
    [Tags]    CDDR111    autocalc    Agent10
    [Setup]    Read Test Data From Excel For RCT   TC-1111
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pulse-CDDR111 upload results
    AND User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR124_Causality_reporter_validation
    [Documentation]   The objective of this test case is to verify that the Reporter 
    ...    Causality automatically populated with the value "not reported" for Products coded 
    ...    to Product Dictionary with Product Characterization (G.k.1) is equal to Suspect or Interacting or DNA when reporter causality is left blank or when reporter causality is unknown.
    [Tags]    JDNS-124    autocalc  Test    regression    Agent1
    [Setup]    Read Test Data From Excel For RCT   TC-124
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR124 Causality reporter validation
    And User Logout from the LSMV application 
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}   

LSMV_Auto-Calculator_PULSE-CDDR122_Autopopulate_product_indication_term
    [Documentation]   The objective of this test case is to verify that the indication term for 
    ...    Concomitant products automatically populated once the case is moved to FR activity.
    [Tags]    JDNS-122    CDDR122  autocalc  Agent1    APPROVED
    [Setup]   Read Test Data From Excel For RCT   TC-129
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR122 auto populate product indication term
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}        

LSMV_Auto-Calculator_PULSE-CDDR128_Check_Vaccine_Anatomical_Approach_Site_Field
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR128 Check Vaccine Anatomical Approach Site Field
    [Tags]    CDDR128    autocalc    Agent7    APPROVED
    [Setup]    Read Test Data From Excel For RCT   TC-9000
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR128 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR85 _WHO DD _Generic name _Chinese
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR85 WHO DD Generic name Chinese
    [Tags]    JDNS-0085    CDDR85    autocalc  Test    regression    Agent3
    [Setup]    Read Test Data From Excel For RCT   TC-198
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR85 WHO DD Generic name Chinese
    And User Logout from the LSMV application
    [Teardown]     Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR38_Case_Significance_Follow_up_Version_for_Review_Stage
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR38 Case Significance Follow-up Version for Review Stage
    [Tags]    JDNS-038   autocalc  Test    regression    Agent4
    [Setup]    Read Test Data From Excel For RCT   TC-3381
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR38 Case Significance Follow-up Version
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}       

LSMV_Validator_PULSE-0033_Medical_Review_Supplemental_Review
    [Documentation]    This Test will validate Validator0033 from Medical review to Supplemental review
    [Tags]  JDNS-0033     validator    Agent3
    [Setup]    Read Test Data From Excel For RCT   TC0033
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Validator-0033 where Validation should fire when a case has been advanced from Medical Review to Supplemental Review
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR05_1_Reporter_Populate_ASKU_Nullflavor_Initial_Fully_Automated_Case
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR05 Populate ASKU Nullflavor Initial Fully Automated Case
    [Tags]    jdns-0005    autocalc    test    regression    agent3
    [Setup]    Read Test Data From Excel For RCT    TC-145
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR05 with Populate ASKU Nullflavor Initial Fully Automated Case
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR05_Populate_ASKU_Reporter_Nullflavor_For_FR_CD_MC
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR05 Populate ASKU Reporter Nullflavor for Final Review, Case Deletion and Minor Change
    [Tags]    JDNS-0005    autocalc  Test    Agent3    regression
    [Setup]    Read Test Data From Excel For RCT   TC-840    
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR05 with Populate ASKU Reporter Nullflavor for FR,MC and FDE Case Deletion
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR89_DME_flag_calculation
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR116 for DME flag calculation
    [Tags]    JDNS-89    CDDR89    autocalc   Agent3
    [Setup]    Read Test Data From Excel For RCT   TC89
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR89 DME_flag_calculation
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR41_1_Event_Onset_Date_End_Date
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR41-1 Event Onset Date and End Date
    [Tags]    jdns-41_1    cddr41    autocalc    agent6
    [Setup]    Read Test Data From Excel For RCT    TC041_1
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR41_1 Scenario
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDD132_Brand_Name
    [Documentation]   This testcase verifies that auto-populates the Brand Name Field from Blank to 'No Information' upon completion of the activity.
    ...  This auto-calculator applies to Final Review, Minor Change and Case Deletion.
    [Tags]    JDNS-132  CDDR132    autocalc    Agent5   APPROVED
    [Setup]    Read Test Data From Excel For RCT   TC-0132
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc PULSE-CDDR132 Brand name
    And User Logout from the LSMV application
    [Teardown]     Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE_CDDR68_CORE labeling _copy_CHINA labeling
    [Documentation]  Verify LSMV Auto-Calculator PULSE-CDDR68 _CORE labeling _copy_CHINA labeling
    [Tags]    JDNS-68    CDDR68    autocalc    Agent5
    [Setup]    Read Test Data From Excel For RCT   TC-419
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc PULSE-CDDR68 CORE labeling copy CHINA labeling
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}    

LSMV_Auto-Calculator_PULSE-CDDR54_Study Patient Number.
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR54 Study Patient Number
    [Tags]    jdns-0054_2    autocalc    test    regression    agent6
    [Setup]    Read Test Data From Excel For RCT    TC-54_2
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Autocalc Pluse-CDDR54 Study Patient Number
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}

LSMV_Auto-Calculator_PULSE-CDDR113_Authority_Number_Blank
    [Documentation]   This test verifies that The system should automatically populate the Authority Number as Blank
    [Tags]    JDNS-113    CDDR113    autocalc    agent10
    [Setup]    Read Test Data From Excel For RCT   TC-1353
    Given User Login into the LSMV application
    When The User navigates to the Case Listing module under Case Management
    Then Verify Auto-calc Pulse-CDDR113_Authority_No_Blank
    And User Logout from the LSMV application
    [Teardown]    Release Dynamic Username And Password    ${Tag}    ${Test Case ID}