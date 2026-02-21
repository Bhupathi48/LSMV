*** Settings ***
Documentation       Executes Web test support.

Resource            ../../Support.robot


*** Keywords ***
User Login into the LSMV application
    [Documentation]    Login to LSMV application as operator
    Login to the LSMV application using the Automation user account, and confirm the user's profile information.
    

User Logout from the LSMV application
    [Documentation]    Logout from LSMV application
    Logout From LSMV Application

The User navigates to New Full Data Entry Form under Case Management
    [Documentation]    Click on New Case and Full data entry form
    User navigates to New Full Data Entry Form under Case Management

Verify Auto-calc PULSE-CDDR91 Scenario
    [Documentation]    Verify auto calculate the Duration when the Precise dates are provided in Start Date and End Date fields under the Parent
    Craete RCT and Verify Auto-calc PULSE-CDDR91

Verify Auto-calc PULSE-CDDR30 Scenario
    [Documentation]    Verify Primary Source For Regulatory Purposes and Primary Reporter
    Create RCT and Verify Auto-calc PULSE-CDDR30

Navigate to General Tab and Enter Company Unit, Latest Received Date, Sender Organization and Primary Source Country
    [Documentation]    Navigate to the General tab and enter the required information
    Enter details in Enter Company Unit, Latest Received Date, Sender Organization and Primary Source Country
    ...    ${company_unit_value}
    ...    ${sender_organ_value}
    ...    ${latest_receview_date}
    ...    ${report_type}
    ...    ${primary_source_country_val}

Verify Autocalc Pulse-DueDateRule
    [Documentation]    Verify Autocalc Pulse-DueDateRule
    Get Data From Excel Sheet for Auto-calc Pulse DueDateRule    ${scenario_sheet_name}

The User navigates to the Case Listing module under Case Management
    [Documentation]    Click on Case Listing
    User navigated to the Case Listing module under Case Management

Verify Auto-calc PULSE-CDDR07 With Populate No Information Nullflavor Vaccine More Minor Change and Final Review
    [Documentation]    This Test will validate Auto-Calculator Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review
    Validate Pulse-CDDR-07 For Final Review

Verify Validator PULSE-0114 With Patient DOB and Death Date
    [Documentation]    Verify Validator003 With Patient DOB and Death Date
    Create RCT and verify Patient's Date Of Death and Patient date of birth

Verify Validator005 With Patient Weight
    [Documentation]    Verify Validator005 With Patient Weight
    Verify Validator 005

Verify Auto-calc PULSE-CDDR28 Scenario
    [Documentation]    Verify auto calculate the Duration when the hospitalization dates are provided in Start Date and End Date fields under the Event
    Verify Auto-calc PULSE-CDDR28

Verify Validator0027 with different ages
    [Documentation]    Verify Validator0027 With different age groups
    # [Arguments]    ${TcID}
    Create RCT and verify the age group with different time frame

Verify Validator0027 with different ages for Final review
    [Documentation]    Verify Validator0027 With different age groups    for Final review
    Validator0027 with different ages for Final review

Verify Validator0027 with different ages for Minor Change
    [Documentation]    Verify Validator0027 With different age groups    for Minor Change
    Validator0027 with different ages for Minor Change

Verify Validator0027 with different ages for Non case
    [Documentation]    Verify Validator0027 With different age groups    for Non case
    # [Arguments]    ${TcID}
    Create RCT and verify the age group with different time frame for Non case

Verify Validator0035 with different nullification and amendment values
    [Documentation]    Verify Validator0035 with different nullification and amendment values
    Verify Validator0035

Verify Validator0035 for non followup case
    [Documentation]    Verify Validator0035 with different nullification and amendment values    for non followup case
    Verify Validator0035 for non followup rct

Verify Validator0010 with remedial action combination
    [Documentation]    Verify Validator0010 with remedial action
    New Create RCT
    clasify the RCT to retrieve the AER number
    Get Data From RCT Excel Sheet validator0010    ${scenario_sheet_name}

Verify Validator0010 with remedial action medical device
    [Documentation]    Verify Validator0010 with remedial action
    New Create RCT
    clasify the RCT to retrieve the AER number
    Get Data From RCT Excel Sheet validator0010    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR13 with Vaccine Facility 3
    [Documentation]    Auto-Calculator PULSE-CDDR13 Nullflavor values - Vaccine Facility
    Verify import AER data and retrieve RCT number    Pulse-CDDR13
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_json}
    Get Data From Excel Sheet Autocalc PULSE-CDDR13 3

Verify Autocalc Pluse-CDDR13 with Vaccine Facility
    [Documentation]    Auto-Calculator PULSE-CDDR13 Nullflavor values - Vaccine Facility
    Verify XML import and retrieve RCT number from queue
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_xml}
    Get Data From Excel Sheet Autocalc PULSE-CDDR13

Verify the Auto-Calculator PULSE-CDDR43 Route of Admin
    [Documentation]    Auto-Calculator PULSE-CDDR43 Route of Admin
    Verify XML import and retrieve RCT number from queue
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_xml}
    Get Data From Excel Sheet Autocalc PULSE-CDDR43

Verify Autocalc Pluse-CDDR04 with Patient Age Group and Sex
    [Documentation]    Verify Autocalc Pluse-CDDR04 with Patient Age Group and Sex fields
    Validate Auto-calc PULSE-CDDR04 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR08 with E2B Case References in Previous Transmissions
    [Documentation]    Verify Autocalc Pluse-CDDR08 with E2B Case References in Previous Transmissions
    Validate Auto-calc PULSE-CDDR08 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR05 with Populate ASKU Nullflavor Initial Fully Automated Case
    [Documentation]    Verify Autocalc Pluse-CDDR05 with Populate ASKU Nullflavor Initial Fully Automated Case
    Validate Auto-calc PULSE-CDDR05_1 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR09 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    [Documentation]    Verify Autocalc Pluse-CDDR09 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    Validate Auto-calc PULSE-CDDR09 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR18 Copy patient data patient information
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR18 Copy patient data patient information
    Create RCT That In the Final Review Stage Pulse-CDDR-18

Verify Auto-calc PULSE_CDDR20_Reporter_Company_Causality_Possible_On_Save_Spontaneous
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR20 Reporter Company Causality Possible On Save Spontaneous
    Create RCT And Verify Pulse-CDDR-20

Verify Auto-calc PULSE-CDDR15 With Report Classification_Non-AE_US or and EMA_Final Review
    [Documentation]    This Test will validate Auto-Calculator Populate_No Information_Nullflavor_Vaccine More_Minor Change and Final Review
    Create RCT That In the Final Review Stage Pulse-CDDR-15

Verify Auto-calc PULSE-CDDR15 With Report Classification Non-AE US or and EMA Minor Change
    [Documentation]    This Test will validate Auto-Calculator Populate_No Information_Nullflavor_Vaccine More_Minor Change
    Create RCT That In the Final Review Stage Pulse-CDDR-15

Verify Auto-calc PULSE_CDDR23_SUSAR_product_event_Type_Labeling_Seriousness_Causality
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR23 SUSAR_product_event combination_Report type_Study Type_Labeling_Seriousness_Causality
    Create RCT That In the Full Data Stage Pulse-CDDR-23

Verify Autocalc Pluse-CDDR32 with Product Action Taken With Drug Copy to Causality Screen
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR32 Product Action Taken With Drug Copy to Causality Screen
    Validate Auto-calc PULSE-CDDR32 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR09_1 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    [Documentation]    Verify Autocalc Pluse-CDDR09_1 with Patient ID_Populate NF Asked But Unknown Fully Automated case
    Validate Auto-calc PULSE-CDDR09 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR38 Case Significance Follow-up Version
    [Documentation]    Verify Autocalc Pluse-CDDR38 Case Significance Follow-up Version
    Validate Auto-calc PULSE-CDDR38 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR42_1 Form of Admin Auto Unknown Nullflavour
    [Documentation]    Verify Autocalc Pluse-CDDR42_1 Form of Admin Auto Unknown Nullflavour
    Validate Auto-calc PULSE-CDDR42_1 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR10_Autopsy_Done_Auto_Null_Flavor_Fully_Automated
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR10 Autopsy Done
    Validate Auto-calc PULSE-CDDRR10 Scenario

Verify Auto-calc PULSE-CDDR11 Scenario for Unknown/Nullflavor validation
    [Documentation]    Verify Auto-calc PULSE-CDDR11 Scenario for Unknown/Nullflavor validation
    Create RCT and Validate Pulse-CDDR-11 For Unknown/Nullflavor

Import aer and navigate to Final review from Home page for CDDR-11
    [Documentation]    Import aer and navigate to Final review from Home page for CDDR-11
    ${aer}=    Verify json import and retrieve RCT number for CDDR-11 in final review workflow
    RETURN    ${aer}

Verify Auto-calc PULSE-CDDR11 Scenario for therapy validation
    [Documentation]    Verify auto calculate the Duration when the Precise dates are provided in Start Date and End Date fields
    ...    under the Parent
    Create RCT and Validate Pulse-CDDR-11_1 For Therapy for Fully_Automated/GCO E2B_account
Verify Auto-calc PULSE-CDDR11 Scenario for therapy validation for Inbound_Structured/Unstructured_Automation_account
    [Documentation]    Verify auto calculate the Duration when the Precise dates are provided in Start Date and End Date fields
    ...    under the Parent
    Create RCT and Validate Pulse-CDDR-11_1 For Therapy for Inbound_Structured/Unstructured_Automation_account
Verify Auto-calc PULSE-CDDR34 Scenario
    [Documentation]    Verify if the Investigational Product Blinded is blank and Coding class is Blank or not equal to Blinded
    Create RCT and Validate Pulse-CDDR-34

Import aer and navigate to Case Listing from Home page for CDDR-34
    [Documentation]    Import aer and navigate to Case Listing from Home page for CDDR-34
    ${aer}=    Verify json import and retrieve RCT number for CDDR-34
    RETURN    ${aer}

Verify json import and retrieve RCT number for CDDR-34
    [Documentation]    Verify Json Import And Retrieve RCT Number
    ${aer}=    Upload AER Data    ${EXECDIR}/Resource/Json/CDDR34.json
    Search for AER    ${aer}
    RETURN    ${aer}

# Verify Auto-calc PULSE-CDDR14 Scenario
#    [Documentation]    Validates that the Regulatory Clock Start Date matches the Latest Received Date in the LSMV application.
#    # [Arguments]    ${TestCaseName}
#    # Create RCT and Verify Auto-calc PULSE-CDDR14
#    Validate Auto-calc PULSE-CDDR14 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR46 Reporter Company Causality Mapping from E2B Causalities
    [Documentation]    Verify Autocalc Pluse-CDDR46 Reporter Company Causality Mapping from E2B Causalities
    Validate Auto-calc PULSE-CDDR46 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR39_Company_Received_Date
    [Documentation]    To validate the correct autopopulation of Company Received Date
    Validate Auto-calc PULSE-CDDR39 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR37_Remove_Causality_WHO_DD_On_Save
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR37 Remove Causality WHO DD On Save
    Validate Auto-calc PULSE-CDDR37 Scenario

Verify Auto-calc PULSE_CDDR31_Product_Auto_Ranking_On_Save
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR31 Product Auto Ranking On Save
    Validate Auto-calc PULSE-CDDR31 Scenario

Verify Autocalc Pluse-CDDR47 NF Unknown Medical History Co-med
    [Documentation]    Verify Autocalc Pluse-CDDR47 NF Unknown Medical History Co-med
    Validate Auto-calc PULSE-CDDR47 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR60_Processing_unit_Populate_Company_Unit
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR60 Processing unit Populate Company Unit
    Create RCT And Verify Pulse-CDDR-60    ${scenario_sheet_name}

Verify Autocalc Pulse-CDD103 Study Registration
    [Documentation]    Verify Auto-calc PULSE-CDDR103 Study Registration Should Auto Populate
    Validate Auto-calc PULSE-CDDR103 Scenario    ${scenario_sheet_name}

Verify ACT_PULSE-CDDR29_Contact_Email Address_First name_Last name
    [Documentation]    This test will validate    ACT_PULSE-CDDR29_Contact_Email Address_First name_Last name
    Get Data From Excel Sheet ACT_PULSE-CDDR29    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR41 Scenario
    [Documentation]    Auto calculator PULSE-CDDR41_1 Event_Onset_Date_End_Date validation
    Create RCT And Verify Auto-calc PULSE-CDDR41_Event_Onset_Date_End_Date

Verify Autocalc Pluse-CDDR56 Populate Reporter Country
    [Documentation]    Verify Autocalc Pluse-CDDR56 Populate Reporter Country
    Validate Auto-calc PULSE-CDDR56 Scenario    ${scenario_sheet_name}

Verify the Auto-Calculator PULSE-CDDR59_Company_No_Authority_No_move_to_Reference_No
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR59 Company_No Authority_No move to Reference_No
    Get Data From Excel Sheet Autocalc PULSE-CDDR59    ${scenario_sheet_name}

Verify Autocalc Pulse-CDD107 Causality Blank
    [Documentation]    Verify Auto-calc PULSE-CDDR107 Causality Blank Should Auto Populate the Reporter Causality and Company Causality as Blank when Inactive Code Present
    Validate Auto-calc PULSE-CDDR107 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR16_Product_Flag_populate_drug_WHODD not blank
    [Documentation]    This test will validate    Auto-calc PULSE-CDDR16_Product_Flag_populate_drug_WHODD not blank
    Get Data From Excel Sheet Autocalc PULSE-CDDR16    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR61_Dechallenge_Rechallenge
    [Documentation]    Verify Auto-calc PULSE_CDDR61 Dechallenge Rechallenge
    Create RCT That In the Final Review Stage Pulse-CDDR-61

Verify Autocalc Pulse-CDDR96 Sender Organization as Coded CCVUSA
    [Documentation]    Verify Auto-calc PULSE-CDDR96 Company Unit And Processing Unit As GMSCP And    Sender Organization As Coded    CCVUSA When Case From PQMS
    Validate Auto-calc PULSE-CDDR96 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR82_Additional_Source
    [Documentation]    Verify Auto-calc PULSE_CDDR82 Additional Source Scenario
    Validate Auto-calc PULSE-CDDR82 Scenario    ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR06 Populate ASKU Reporter State Suspect Intraction Drug not adminstation
    [Documentation]    Verify auto calculate the ASKU Reporter State in Final review workflow and minor change workflow
    Verify import AER data and retrieve RCT number    PULSE-CDDR06
    ${RCT_No}=    Upload AER Data    ${EXECDIR}/Resource/Json/final_review_stage_RCT.json
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_json}
    Get Data From Excel Sheet Autocalc PULSE-CDDR06

Verify Autocalc PULSE-CDDR22_Causality_Populate_Start Latency1
    [Documentation]    Ensure Start Latency is calculated accurately based on specified date difference logic and unit conversions.
    Verify the Autocalc PULSE-CDDR22_Causality_Populate_Start Latency1

Verify the Autocalc PULSE-CDDR22_Causality_Populate_Start Latency1
    [Documentation]    Ensure Start Latency is calculated accurately based on specified date difference logic and unit conversions.
    Verify import AER data and retrieve RCT number    PULSE-CDDR22
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_json}
    Get Data From Excel Sheet Autocalc PULSE-CDDR22

Verify Autocalc PULSE-CDDR33_Literature Document Name
    [Documentation]    Verify Autocalc PULSE-CDDR33_Literature Document Name
    Verify Auto-calc PULSE-CDDR33 Scenario Literature Document Name

Verify Auto-calc PULSE-CDDR33 Scenario Literature Document Name
    [Documentation]    Verify Auto-calc PULSE-CDDR33 Scenario
    Verify import AER data and retrieve RCT number    PULSE-CDDR33
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_json}
    Get Data From Excel Sheet Autocalc PULSE-CDDR33

Verify Autocalc PULSE-CDDR43_1_Route of Admin_Unknown_Null flavor_Accounts group
    [Documentation]    Verify Autocalc PULSE-CDDR43_1_Route of Admin_Unknown_Null flavor_Accounts group
    Verify Auto-calc PULSE-CDDR43_1 Scenario Route of Admin Unknown Null flavor Accounts group

Verify Auto-calc PULSE-CDDR43_1 Scenario Route of Admin Unknown Null flavor Accounts group
    [Documentation]    Verify Auto-calc PULSE-CDDR43_1 Scenario
    Verify import AER data and retrieve RCT number    PULSE_CDDR43_1_EMEA
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_json}
    Get Data From Excel Sheet Autocalc PULSE-CDDR43_1

Verify Autocalc PULSE-CDDR48 Event Outcome Default
    [Documentation]    Verify Autocalc PULSE-CDDR48 Event Outcome Default
    Verify Auto-calc PULSE-CDDR48 Scenario Event Outcome Default

Verify Auto-calc PULSE-CDDR48 Scenario Event Outcome Default
    [Documentation]    Verify Auto-calc PULSE-CDDR48 Scenario
    Verify import AER data and retrieve RCT number    PULSE-CDDR48
    User navigated to the Case Listing module under Case Management
    Navigate to Complaint Management and Select RCT    ${rct_number_json}
    Get Data From Excel Sheet Autocalc PULSE-CDDR48

Verify Auto-calc PULSE_CDDR62_Gestational_Age_At_Event
    [Documentation]    Verify Auto-calc PULSE_CDDR62 Gestational Age At Event
    Create RCT That In the Full Data Stage And Validate Pulse-CDDR-62

Verify Autocalc PULSE-CDDR106_Report Receiving Medium_Async API
    [Documentation]    This test will validate    Autocalc PULSE-CDDR106_Report Receiving Medium_Async API
    Get Data From Excel Sheet Autocalc PULSE-CDDR106    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR25_Initial_Version_Case Significance_Manual_Field
    [Documentation]    This Test will validate Auto-Calculator PULSE_CDDR25 Initial Version Case Significance Manual Field
    Validate Auto-calc PULSE-CDDR25 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR50 Post Marketed USA Approval Spontaneous
    [Documentation]    Verify Auto-calc PULSE-CDDR50 Post Marketed USA Approval Spontaneous Scenario
    Validate Auto-calc PULSE-CDDR50 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR51 IND approval Clinical Trial case
    [Documentation]    Verify Autocalc Pluse-CDDR51 IND approval Clinical Trial case
    Validate Auto-calc PULSE-CDDR51 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR77 CT EU labeling
    [Documentation]    Verify Autocalc Pluse-CDDR77 CT EU labeling
    Validate Auto-calc PULSE-CDDR77 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR80 Report Classification Non Case Duplicate
    [Documentation]    Verify Autocalc Pluse-CDDR80 Report Classification Non Case Duplicate
    Validate Auto-calc PULSE-CDDR80 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR52 Race Ethnicity
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR52 Race Ethnicity
    Validate Auto-calc PULSE-CDDR52 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR53 Fatal Outcome Roll-up
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR53 Fatal Outcome Roll-up
    Validate Auto-calc PULSE-CDDR53 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR94 Additional Documents Re-Calculation
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR94 Additional Documents Re-Calculation
    Validate Auto-calc PULSE-CDDR94 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR63_Event_Received_Date
    [Documentation]    Verify Auto-calc PULSE_CDDR63 Event Received Date
    Create RCT And Validate Pulse-CDDR-63

Verify Auto-calc PULSE_CDDR69_Event_Received_Korean_Evaluation_KRCT_EVALUATION_RESULT
    [Documentation]    Verify Auto-calc PULSE_CDDR69 Event Received Korean Evaluation KRCT EVALUATION RESULT
    Validate Pulse-CDDR69 In Final Review and Minor Stage

Verify Auto-calc PULSE_CDDR92_DO_NOT_USE_ANG_FROM_PARENT_CASE
    [Documentation]    Verify Auto-calc PULSE_CDDR92 DO NOT USE ANG FROM PARENT CASE
    Validate Pulse-CDDR92 For DO NOT USE ANG FROM PARENT CASE

Verify Auto-calc PULSE_CDDR105_Coding_Class
    [Documentation]    Verify Auto-calc PULSE_CDDR105 Coding Class
    Validate Pulse-CDDR105

Verify Auto-calc PULSE-CDDR90_Medical history_disease type
    [Documentation]    This Test will validate Auto-Calculator PULSE-CDDR90 Medical history_disease type
    Get Data From Excel Sheet Autocalc PULSE-CDDR90    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR114 Auto Populate Event Type
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR114 Auto Populate Event Type
    Validate Auto-calc PULSE-CDDR114 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_CDDR26_Fully_Automated_Additional Documents_Available_Final_Review
    [Documentation]    This Test will validate Auto-Calculator PULSE_CDDR26 Fully Automated Additional Documents Available Final Review
    Validate Auto-calc PULSE-CDDR26 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR54 Study Patient Number
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR54 Study Patient Number
    Validate Auto-calc PULSE-CDDR54 Scenario    ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR49 Account Type Prefix Event Description
    [Documentation]    Verify Autocalc PULSE-CDDR49 Account Type Prefix Event Description
    Verify Auto-calc PULSE-CDDR49 Scenario Account Type Prefix Event Description

Verify Auto-calc PULSE-CDDR49 Scenario Account Type Prefix Event Description
    [Documentation]    Verify Auto-calc PULSE-CDDR49 Scenario
    Get Data From Excel Sheet Autocalc PULSE-CDDR49

Verify Autocalc PULSE-CDDR55 Indication Blank Default Product Used For Unknown Indication
    [Documentation]    Verify Autocalc PULSE-CDDR55 Indication Blank Default Product Used For Unknown Indication
    Verify Auto-calc PULSE-CDDR55 Scenario Indication Blank Default Product Used For Unknown Indication

Verify Auto-calc PULSE-CDDR55 Scenario Indication Blank Default Product Used For Unknown Indication
    [Documentation]    Verify Auto-calc PULSE-CDDR55 Scenario
    Get Data From Excel Sheet Autocalc PULSE-CDDR55

Verify Autocalc PULSE-CDDR57 Automation Account group Country Regional State and State For Spain
    [Documentation]    Verify Autocalc PULSE-CDDR57 Automation Account group Country Regional State
    Verify Auto-calc PULSE-CDDR57 Scenario Automation Account group Country Regional State and State For Spain

Verify Auto-calc PULSE-CDDR57 Scenario Automation Account group Country Regional State and State For Spain
    [Documentation]    Verify Auto-calc PULSE-CDDR57 Scenario
    Get Data From Excel Sheet Autocalc PULSE-CDDR57

Verify Autocalc PULSE-CDDR57 Automation Account group Country Regional State and State For Italy
    [Documentation]    Verify Autocalc PULSE-CDDR57 Automation Account group Country Regional State
    Verify Auto-calc PULSE-CDDR57 Scenario Automation Account group Country Regional State and State For Italy

Verify Auto-calc PULSE-CDDR57 Scenario Automation Account group Country Regional State and State For Italy
    [Documentation]    Verify Auto-calc PULSE-CDDR57 Scenario
    Get Data From Excel Sheet Autocalc PULSE-CDDR57

Verify Autocalc PULSE-CDDR58 Reporter Qualification Default Value For Blank Field After Initial Review
    [Documentation]    Verify Autocalc PULSE-CDDR58 Reporter Qualification Default Value For Blank Field After Initial Review
    Verify Autocalc PULSE-CDDR58 Scenario Reporter Qualification Default Value For Blank Field After Initial Review

Verify Autocalc PULSE-CDDR58 Scenario Reporter Qualification Default Value For Blank Field After Initial Review
    [Documentation]    Verify Auto-calc PULSE-CDDR58 Scenario
    Get Data From Excel Sheet Autocalc PULSE-CDDR58

Verify Autocalc PULSE-CDDR74 Local Criteria Report Type Locally Expedited Blank
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR74 Local Criteria Report Type Locally Expedited Blank
    Validate Auto-calc PULSE-CDDR74 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR65 Chinese Evaluation E2B Causality Result INITIAL REPORTER MAH EVALUATION RESULTS
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR65 Chinese Evaluation E2B Causality Result INITIAL REPORTER MAH EVALUATION RESULTS
    Validate Auto-calc PULSE-CDDR65 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR127 Report Category
    [Documentation]    Verify Autocalc Pulse-CDDR127 Report Category
    Validate Auto-calc PULSE-CDDR127 Scenario    ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR75 Lab Result Unstructured Populate More Info Initial and Final activity
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR75 Lab Result Unstructured Populate More Info Initial and Final activity
    Validate Auto-calc PULSE-CDDR75 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR125 Regional State and State As Unknown
    [Documentation]    Verify Autocalc Pulse-CDDR125 Regional State and State As Unknown
    Validate Auto-calc PULSE-CDDR125 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR56 Populate Reporter Country for Initial case
    [Documentation]    Verify Autocalc Pluse-CDDR56 Populate Reporter Country for Initial case
    Validate Auto-calc PULSE-CDDR56 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR56 Populate Reporter Country Final Review
    [Documentation]    Verify Autocalc Pluse-CDDR56 Populate Reporter Country
    Validate Auto-calc PULSE-CDDR56 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR83_Term Highlighted auto-populate
    [Documentation]    Verify Auto-calc PULSE-CDDR83 Term Highlighted auto-populate
    Verify Auto-calc PULSE-CDDR83 Scenario Term Highlighted auto-populate

Verify Auto-calc PULSE-CDDR83 Scenario Term Highlighted auto-populate
    [Documentation]    Verify Auto-calc PULSE-CDDR83 Scenario
    Verify import AER data and retrieve RCT number    CDDR83
    User navigated to the Case Listing module under Case Management
    Search for AER    ${rct_number_json}
    Mark the case as new case
    Complete confirmation Activity
    Validate term highlighted values for final/Minor change review

Verify Auto-calc PULSE-CDDR83_Case_deletion_Term Highlighted auto-populate
    [Documentation]    Verify Auto-calc PULSE-CDDR83 Case deletion Term Highlighted auto-populate
    Verify Auto-calc PULSE-CDDR83 Scenario Case deletion Term Highlighted auto-populate

Verify Auto-calc PULSE-CDDR83 Scenario Case deletion Term Highlighted auto-populate
    [Documentation]    Verify Auto-calc PULSE-CDDR83 Scenario Case deletion
    Verify import AER data and retrieve RCT number    CDDR83_Case_Deletion
    User navigated to the Case Listing module under Case Management
    Search for AER    ${rct_number_json}
    Mark the case as new case
    Complete confirmation Activity
    Validate term highlighted values for case deletion

Verify Autocalc Pluse-CDDR123 Case Documents Is local options validation
    [Documentation]    Verify Autocalc Pluse-CDDR123 Case Documents Is local options validation
    Validate Auto-calc PULSE-CDDR123 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR81 upload results
    [Documentation]    Verify Autocalc Pulse-CDDR16 with Product Characterization, WHO DD Code, and Product Flag fields
    Validate Auto-calc PULSE-CDDR81 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR121-Expected_IsLocal_Checkbox_Autopopulation
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR121 Expected IsLocal Checkbox Autopopulation
    Validate Auto-calc PULSE-CDDR121 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR93 Case Due Date Condition 1
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR93 Case Due Date Condition 1
    Get Data From Excel Sheet Autocalc PULSE-CDDR93_Condition 1    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR93 Case Due Date Condition 2
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR93 Case Due Date Condition 2
    Get Data From Excel Sheet Autocalc PULSE-CDDR93_Condition 2    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR93 Case Due Date Condition 3
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR93 Case Due Date Condition 3
    Get Data From Excel Sheet Autocalc PULSE-CDDR93_Condition 3  ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR119 Initial Received Date Populated As Latest Received Date
    [Documentation]    Verify Autocalc Pulse-CDDR119 Initial Received Date Populated As Latest Received Date
    Get Data From Excel Sheet Autocalc PULSE-CDDR119    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR112 Removal of timestamp from Current Date
    [Documentation]    Verify Autocalc Pulse-CDDR112 Removal of timestamp from Current Date
    Validate Auto-calc PULSE-CDDR112 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR95_Coding Class_Non-Blinded Case
    [Documentation]    Verify Auto-calc PULSE-CDDR95 Coding Class Non-Blinded Case
    Get Data From Excel Sheet Autocalc PULSE-CDDR95    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR116 Auto Populate Event Type
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR116 Auto Populate Event Type in Full Data Entry
    Validate Auto-calc PULSE-CDDR116 Scenario    ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR108_Litrature_Document_category
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR108_Litrature_Document_category
    Validate Auto-calc PULSE-CDDR108 Scenario Literature Document category

Verify Autocalc PULSE-CDDR108_Litrature_Document_category_final_review
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR108_Litrature_Document_category_final_review
    Validate Auto-calc PULSE-CDDR108 Scenario Literature Document category final review

# Verify Autocalc Pluse-CDDR116 Auto Populate Event Type
#    [Documentation]    LSMV Auto-Calculator PULSE-CDDR116 Auto Populate Event Type in Full Data Entry
#    Validate Auto-calc PULSE-CDDR116 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR109 Auto Populate Parent gender
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR109 Auto Populate Parent gender in Final/Minor changes
    Validate Auto-calc PULSE-CDDR109 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR14 Scenario
    [Documentation]    Validates that the Regulatory Clock Start Date matches the Latest Received Date in the LSMV application.
    # [Arguments]    ${TestCaseName}
    # Create RCT and Verify Auto-calc PULSE-CDDR14
    Validate Auto-calc PULSE-CDDR14 Scenario    ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR71 E2B Causality_Clean up
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR71 E2B Causality Clean up
    Validate Auto-calc PULSE-CDDR71 Scenario    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR52_1 Race Ethnicity
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR52 Race Ethnicity
    Validate Auto-calc PULSE-CDDR52_1 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE_Nullification_Reason_Followup
    [Documentation]    This Test will validate Auto-Calculator PULSE_Nullification_Reason_Followup
    Validate Pulse-Nullification_Reason_Followup

Verify Auto-calc PULSE_CDDR131_Scheduler_With_Schedule_Name
    [Documentation]    This Test will validate Auto-Calculator PULSE_CDDR131 Scheduler With Schedule Name
    Validate Pulse-CDDR131_Scheduler_With_Schedule_Name         

Verify Auto-calc PULSE-CDDR98_1_Schedule_No follow up required_Fully Automated case
    [Documentation]    Verify Auto-calc PULSE-CDDR98_1 Schedule No follow up required Fully Automated case
    Get Data From Excel Sheet Autocalc PULSE-CDDR98_1    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR98_2_Schedule_No follow up required_Condition_1
    [Documentation]    Verify Auto-calc PULSE-CDDR98_2 Schedule No follow up required Condition 1
    Get Data From Excel Sheet Autocalc PULSE-CDDR98_2_1    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR98_2_Schedule_No follow up required_Condition_2
    [Documentation]    Verify Auto-calc PULSE-CDDR98_2 Schedule No follow up required Condition 2
    Get Data From Excel Sheet Autocalc PULSE-CDDR98_2_2    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR98_2_Schedule_No follow up required_Condition_3
    [Documentation]    Verify Auto-calc PULSE-CDDR98_2 Schedule No follow up required Condition 3
    Get Data From Excel Sheet Autocalc PULSE-CDDR98_2_3    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR98_3_Unable_to_follow_up_required
    [Documentation]    Verify Auto-calc PULSE-CDDR98_3 Schedule Unable to follow up
    Get Data From Excel Sheet Autocalc PULSE-CDDR98_3    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR117 Scenario
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR117 Verify MeDRA hierarchy
    Validate Auto-calc PULSE-CDDR117 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR117 Scenario_in_FR_NC_MC_CD
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR117 Verify MeDRA hierarchy in Final Review, Minor Change and Case Deletion
    Create RCT and verify PULSE-CDDR117_1    ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR72 Person Type Patient
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR72 Person Type Patient
    Validate Auto-calc PULSE-CDDR72 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR130 Additional Comments
    [Documentation]    Verify Autocalc Pulse-CDDR130 Additional Comments
    Validate Auto-calc PULSE-CDDR130 Scenario    ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR129 auto populate constituent products
    [Documentation]    Verify Auto-calc PULSE-CDDR129 auto populate constituent products
    Get Data From Excel Sheet Autocalc PULSE-CDDR129    ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR04_1 with Patient Age Group and Sex
    [Documentation]    Verify Autocalc Pluse-CDDR04 with Patient Age Group and Sex fields
    Validate Auto-calc PULSE-CDDR04 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR115 Auto Populate Subject ID from Investigation Number and vice versa
    [Documentation]    LSMV Auto-Calculator PULSE-CDDR115 Auto Populate Subject ID from Investigation Number and vice versa
    Validate Auto-calc PULSE-CDDR115 Scenario    ${scenario_sheet_name}

Verify Autocalc Pulse-CDDR111 upload results
    [Documentation]    Verify Autocalc Pulse-CDDR111 with Product Characterization, WHO DD Code, and Product Flag fields
    Validate Auto-calc PULSE-CDDR111 Scenario     ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR124 Causality reporter validation
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR124 Causality reporter validation
    Validate Auto-calc PULSE-CDDR124 Scenario     ${scenario_sheet_name}

Verify Auto-calc PULSE-CDDR122 auto populate product indication term
    [Documentation]    Verify Auto-calc PULSE-CDDR122 auto populate product indication term
    Get Data From Excel Sheet Autocalc PULSE-CDDR122    ${scenario_sheet_name}    

Verify Validator0029 for nullification
    [Documentation]    Nullification validation in LSMV Application
    Create RCT and verify Nullification validation0029

Verify Validator0029 for nullification_part2
    [Documentation]    Nullification validation in LSMV Application - part2
    Create RCT and verify Nullification validation0029_part2     
    
Verify Auto-calc PULSE-CDDR128 Scenario
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR128 Vaccine Anatomical Approach Site field value population
    Validate Auto-calc PULSE-CDDR128 Scenario     ${scenario_sheet_name}

Verify Autocalc Pluse-CDDR85 WHO DD Generic name Chinese
    [Documentation]    Verify Autocalc Pluse-CDDR85 WHO DD Generic name Chinese
    Validate Auto-calc PULSE-CDDR85 Scenario     ${scenario_sheet_name}

Verify Validator-0033 where Validation should fire when a case has been advanced from Medical Review to Supplemental Review
    [Documentation]     Verify Validator-0033 where Validation should fire when a case has been advanced from Medical Review to Supplemental Review
    Validate Validator-0033 where Validation should fire when a case has been advanced from Medical Review to Supplemental Review

Verify Autocalc Pluse-CDDR05 with Populate ASKU Reporter Nullflavor for FR,MC and FDE Case Deletion
    [Documentation]    Verify Autocalc Pluse-CDDR05 with Populate ASKU Reporter Nullflavor Final Review
    Validate Auto-calc PULSE-CDDR05 Scenario     ${scenario_sheet_name}

Verify Autocalc PULSE-CDDR89 DME_flag_calculation
    [Documentation]     Verify Autocalc PULSE-CDDR89 DME_flag_calculation
    Create RCT and Verify Autocalc PULSE-CDDR89

Verify Auto-calc PULSE-CDDR41_1 Scenario
    [Documentation]    Auto calculator PULSE-CDDR41_1 Event_Onset_Date_End_Date validation
    Create RCT And Verify Auto-calc PULSE-CDDR41_1_Event_Onset_Date_End_Date

Verify Auto-calc PULSE-CDDR132 Brand name
    [Documentation]   LSMV Auto-Calculator PULSE-CDDR132 Brand name
   Get Data From Excel Sheet Autocalc PULSE-CDDR132    

Verify Autocalc PULSE-CDDR68 CORE labeling copy CHINA labeling
    [Documentation]    Verify Autocalc PULSE-CDDR68 CORE labeling copy CHINA labeling
    Validate Auto-calc PULSE-CDDR68 Scenario   

Verify Auto-calc Pulse-CDDR113_Authority_No_Blank
    [Documentation]    Verify the Auto-Calculator PULSE-CDDR113 Authority No Blank
    Validate Auto-calc PULSE-CDDR113 Scenario     ${scenario_sheet_name}