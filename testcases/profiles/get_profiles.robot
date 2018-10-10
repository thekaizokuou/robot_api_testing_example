*** Settings ***
Resource    ../../resources/imports.robot
Resource    ../../keywords/customer_service/profile_api_keywords.robot
Variables    ../../resources/testdata/${ENV}/profile_user.yaml

*** Test Cases ***
TC_01 Get Profile Success
    [Documentation]    To verify get profile api work success
    Get profile    ${get_profile['success']}
    Verify get profile success

TC_02 Get profile failed - user not found
    [Documentation]    To verify get profile api work correct when user not found
    Get profile    ${get_profile['not_found']}
    Verify get profile failed user not found

TC_03 Get profile failed - user dormant
    [Documentation]    To verify get profile api work correct when user is dormant
    Get profile    ${get_profile['dormant']}
    Verify get profile failed user dormant

TC_04 Get profile failed - user inactive
    [Documentation]    To verify get profile api work correct when user is inactive
    Get profile    ${get_profile['inactive']}
    Verify get profile failed user inactive

TC_05 Get profile failed - user suspend
    [Documentation]    To verify get profile api work correct when user is suspend
    Get profile    ${get_profile['suspend']}
    Verify get profile failed user suspend

TC_06 Get profile failed - user frozen
    [Documentation]    To verify get profile api work correct when user is frozen
    Get profile    ${get_profile['frozen']}
    Verify get profile failed user frozen

TC_02-06 Use testcases template
    [Template]  Get user profile failed
    ${get_profile['not_found']}    404    1023    Failed    User not found
    ${get_profile['dormant']}    500    1036    Failed    User is Dormant
    ${get_profile['inactive']}    500    1037    Failed    User is Inactive
    ${get_profile['suspend']}    500    1038    Failed    User is Suspend
    ${get_profile['frozen']}    500    1039    Failed    User is Frozen

*** Keywords ***
Get user profile failed
    [Arguments]    ${user_id}    ${http_status_code}    ${expected_status_code}
    ...    ${expected_header}     ${expected_description}
    Get profile    ${user_id}
    Verify get profile response status    ${http_status_code}    ${expected_status_code}    ${expected_header}    ${expected_description}