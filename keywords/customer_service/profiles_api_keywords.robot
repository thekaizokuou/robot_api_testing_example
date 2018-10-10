*** Settings ***
Resource    ../../resources/imports.robot
Variables    ../../resources/testdata/common/profiles_api_message.yaml

*** Keywords ***
Get profiles
    [Arguments]    ${user_id}
    Create Http Context    ${customer_service_url}    ${customer_service_protocol}
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${get_profiles_uri}${user_id}
    ${response}    Get Response Body
    ${response}    json.loads    ${response}
    Set Test Variable    ${response}

Post user profiles
    [Arguments]    ${card_id}    ${transaction_id}
    Create Http Context    ${customer_service_url}    ${customer_service_protocol}
    Next Request May Not Succeed
    Set request body    {"card_identification":"${card_id}","request_transaction_id":"${transaction_id}"}
    HttpLibrary.HTTP.Post    ${post_profiles_uri}
    ${response}    Get Response Body
    ${response}    json.loads    ${response}
    Set Test Variable    ${response}

Verify response node status
    [Arguments]    ${expected_code}    ${expected_header}    ${expected_description}
    Should Be Equal As Integers    ${response['status']['code']}    ${expected_code}
    Should Be Equal    ${response['status']['header']}    ${expected_header}
    Should Be Equal    ${response['status']['description']}    ${expected_description}

Verify get profiles response status
    [Arguments]    ${http_status_code}    ${expected_code}    ${expected_header}    ${expected_description}
    Response Status Code Should Equal    ${http_status_code}
    Verify response node status    ${expected_code}    ${expected_header}    ${expected_description}

Verify node data should be empty
    Should Be Empty    ${response['data']}

Verify get profiles success
    [Arguments]    ${expected_first_name}    ${expected_last_name}    ${expected_card_identification}
    Verify get profiles response status    200    ${code_success}    ${success_message}    ${success_message}
    Should Be Equal    ${response['data']['first_name']}    ${expected_first_name}
    Should Be Equal    ${response['data']['last_name']}    ${expected_last_name}
    Should Be Equal    ${response['data']['card_identification']}    ${expected_card_identification}

Verify get profiles failed user not found
    Verify get profiles response status    404    ${code_user_not_found}    ${failed_message}    ${error_user_not_found}
    Verify node data should be empty

Verify get profiles failed user frozen
    Verify get profiles response status    500    ${code_user_frozen}    ${failed_message}    ${error_user_frozen}
    Verify node data should be empty

Verify get profiles failed user dormant
    Verify get profiles response status    500    ${code_user_dormant}    ${failed_message}    ${error_user_dormant}
    Verify node data should be empty

Verify get profiles failed user inactive
    Verify get profiles response status    500    ${code_user_inactive}    ${failed_message}    ${error_user_inactive}
    Verify node data should be empty

Verify get profiles failed user suspend
    Verify get profiles response status    500    ${code_user_suspend}    ${failed_message}    ${error_user_suspend}
    Verify node data should be empty

Verify post profiles success
    [Arguments]    ${expected_request_transaction_id}
    Verify get profiles response status    200    ${code_success}    ${success_message}    ${success_message}
    Should be equal    ${response['data']['request_transaction_id']}    ${expected_request_transaction_id}
    should not be empty    ${response['data']['response_uuid']}
    should not be empty  ${response['data']['create_date']}

Verify post profiles failed card id not found
    Verify get profiles response status    200    ${code_card_not_exist}    ${error_card_not_exist}
    ...    ${error_card_not_exist}
    Verify node data should be empty

Verify post profiles failed card id already used
    Verify get profiles response status    200    ${code_card_already_used}    ${error_card_already_used}
    ...    ${error_card_already_used}
    Verify node data should be empty