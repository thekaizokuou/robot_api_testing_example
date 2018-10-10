*** Settings ***
Resource    ../../resources/imports.robot
Resource    ../../keywords/customer_service/profiles_api_keywords.robot
Variables    ../../resources/testdata/${ENV}/profile_user.yaml

*** Test Cases ***
TC_01 Get profiles Success
    [Documentation]    To verify get profiles api work success
    Get profiles    ${get_profile_success['success']}
    Verify get profiles success    ${get_profile_success['first_name']}    ${get_profile_success['last_name']}
    ...    ${get_profile_success['card_identification']}

TC_02 Get profiles failed - user not found
    [Documentation]    To verify get profiles api work correct when user not found
    Get profiles    ${get_profile_failed['not_found']}
    Verify get profiles failed user not found

TC_03 Get profiles failed - user dormant
    [Documentation]    To verify get profiles api work correct when user is dormant
    Get profiles    ${get_profile_failed['dormant']}
    Verify get profiles failed user dormant

TC_04 Get profiles failed - user inactive
    [Documentation]    To verify get profiles api work correct when user is inactive
    Get profiles    ${get_profile_failed['inactive']}
    Verify get profiles failed user inactive

TC_05 Get profiles failed - user suspend
    [Documentation]    To verify get profiles api work correct when user is suspend
    Get profiles    ${get_profile_failed['suspend']}
    Verify get profiles failed user suspend

TC_06 Get profiles failed - user frozen
    [Documentation]    To verify get profiles api work correct when user is frozen
    Get profiles    ${get_profile_failed['frozen']}
    Verify get profiles failed user frozen

TC_02-06 Use testcases template
    [Template]  Get user profiles failed
    ${get_profile_failed['not_found']}    404    ${code_user_not_found}    ${failed_message}    ${error_user_not_found}
    ${get_profile_failed['dormant']}    500    ${code_user_dormant}    ${failed_message}    ${error_user_dormant}
    ${get_profile_failed['inactive']}    500    ${code_user_inactive}    ${failed_message}    ${error_user_inactive}
    ${get_profile_failed['suspend']}    500    ${code_user_suspend}    ${failed_message}    ${error_user_suspend}
    ${get_profile_failed['frozen']}    500    ${code_user_frozen}    ${failed_message}    ${error_user_frozen}

*** Keywords ***
Get user profiles failed
    [Arguments]    ${user_id}    ${http_status_code}    ${expected_status_code}
    ...    ${expected_header}     ${expected_description}
    Get profiles    ${user_id}
    Verify get profiles response status    ${http_status_code}    ${expected_status_code}
    ...    ${expected_header}    ${expected_description}
    Verify node data should be empty