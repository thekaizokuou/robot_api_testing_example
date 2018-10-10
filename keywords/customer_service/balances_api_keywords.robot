*** Settings ***
Resource    ../../resources/imports.robot
Variables    ../../resources/testdata/common/balances_api_message.yaml

*** Keywords ***
Post balances
    [Arguments]    ${card_id}    ${transaction_id}    ${username}    ${password}
    Create Http Context    ${customer_service_url}    ${customer_service_protocol}
    Set Basic Auth    ${username}    ${password}
    Next Request May Not Succeed
    Set request body    {"card_identification":"${card_id}","request_transaction_id":"${transaction_id}"}
    HttpLibrary.HTTP.Post    ${post_balances_uri}
    ${response}    Get Response Body
    ${response}    json.loads    ${response}
    Set Test Variable    ${response}

Verify response node status
    [Arguments]    ${expected_code}    ${expected_header}    ${expected_description}
    Should Be Equal As Integers    ${response['status']['code']}    ${expected_code}
    Should Be Equal    ${response['status']['header']}    ${expected_header}
    Should Be Equal    ${response['status']['description']}    ${expected_description}

Verify get balances response status
    [Arguments]    ${http_status_code}    ${expected_code}    ${expected_header}    ${expected_description}
    Response Status Code Should Equal    ${http_status_code}
    Verify response node status    ${expected_code}    ${expected_header}    ${expected_description}

Verify node data should be empty
    Should Be Empty    ${response['data']}

Verify post balances success
    [Arguments]    ${expected_request_transaction_id}
    Verify get balances response status    200    ${code_success}    ${success_message}    ${success_message}
    Should be equal    ${response['data']['request_transaction_id']}    ${expected_request_transaction_id}
    should not be empty    ${response['data']['response_uuid']}
    should be true  0 <= ${response['data']['balance']}

Verify post balances failed card id not found
    Verify get balances response status    200    ${code_card_not_exist}    ${error_card_not_exist}    ${error_card_not_exist}

Verify post balances failed authorization failed
    Verify get balances response status    200    ${code_authorize_failed}    ${error_authorize_failed}    ${error_authorize_failed}
