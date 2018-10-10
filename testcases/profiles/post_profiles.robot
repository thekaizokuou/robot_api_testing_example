*** Settings ***
Resource    ../../resources/imports.robot
Resource    ../../keywords/customer_service/profiles_api_keywords.robot
Library    ../../pythonlibs/hash.py
Variables    ../../resources/testdata/${ENV}/profile_user.yaml

*** Test Cases ***
TC_07 Post profiles success
    [Documentation]    To verify post profiles api work correctly for new user
    ${request_transaction_id}    Generate uuid
    Post user profiles    ${post_profile_success['success']}    ${request_transaction_id}
    Verify post profiles success    ${request_transaction_id}

TC_08 Post profiles failed - card id not found
    [Documentation]    To verify post profiles api work correct when card id not found
    ${request_transaction_id}    Generate uuid
    Post user profiles    ${post_profile_failed['card_not_found']}    ${request_transaction_id}
    Verify post profiles failed card id not found

TC_09 Post profiles failed - card id already used
    [Documentation]    To verify post profiles api work correct when card id already used
    ${request_transaction_id}    Generate uuid
    Post user profiles    ${post_profile_failed['card_already_used']}    ${request_transaction_id}
    Verify post profiles failed card id already used