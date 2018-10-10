*** Settings ***
Resource    ../../resources/imports.robot

*** Keywords ***
Get profile
    [Arguments]    ${user_id}
    Create Http Context    ${customer_service_url}    ${customer_service_protocol}
    Next Request May Not Succeed
    HttpLibrary.HTTP.Get    ${get_profile_uri}${user_id}
    ${response}    Get Response Body
    ${response}    json.loads    ${response}
    Set Test Variable    ${response}

Verify get profile success
    Verify get profile response status    200    1000    Success    Success
    Verify node data should be empty

Verify get profile failed user not found
    Verify get profile response status    404    1023    Failed    User not found

Verify get profile failed user frozen
    Verify get profile response status    500    1039    Failed    User is Frozen

Verify get profile failed user dormant
    Verify get profile response status    500    1036    Failed    User is Dormant

Verify get profile failed user inactive
    Verify get profile response status    500    1037    Failed    User is Inactive

Verify get profile failed user suspend
    Verify get profile response status    500    1038    Failed    User is Suspend

Verify response node status
    [Arguments]    ${expected_code}    ${expected_header}    ${expected_description}
    Should Be Equal As Integers    ${response['status']['code']}    ${expected_code}
    Should Be Equal    ${response['status']['header']}    ${expected_header}
    Should Be Equal    ${response['status']['description']}    ${expected_description}

Verify get profile response status
    [Arguments]    ${http_status_code}    ${expected_code}    ${expected_header}    ${expected_description}
    Response Status Code Should Equal    ${http_status_code}
    Verify response node status    ${expected_code}    ${expected_header}    ${expected_description}

Verify node data should be empty
