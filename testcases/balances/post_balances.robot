*** Settings ***
Resource    ../../resources/imports.robot
Resource    ../../keywords/customer_service/balances_api_keywords.robot
Library    ../../pythonlibs/hash.py
Variables    ../../resources/testdata/${ENV}/profile_user.yaml

*** Test Cases ***
TC_10 Post profiles success
    [Documentation]    To verify post profiles api work correctly for new user
    ${request_transaction_id}    Generate uuid
    Post balances    ${post_balance_success['success']}    ${request_transaction_id}    ${basic_auth['username']}    ${basic_auth['password']}
    Verify post balances success    ${request_transaction_id}

TC_11 Post profiles failed - card id not found
    [Documentation]    To verify post profiles api work correct when card id not found
    ${request_transaction_id}    Generate uuid
    Post balances    ${post_balance_failed['card_not_found']}    ${request_transaction_id}    ${basic_auth['username']}    ${basic_auth['password']}
    Verify post balances failed card id not found

TC_12 Post profiles failed - card id already used
    [Documentation]    To verify post profiles api work correct when card id already used
    ${request_transaction_id}    Generate uuid
    Post balances    ${post_balance_success['success']}    ${request_transaction_id}    user    password
    Verify post balances failed authorization failed