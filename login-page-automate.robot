*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                           https://automate-test.stpb-digital.com/login/
${BROWSER}                       gc
${locator_email}                 id=email
${locator_password}              name=password
${locator_btn_login}             id=btn-login
${locator_msg_invalid_email}     css=#__next > div.layout-wrapper.MuiBox-root.css-33gw4 > div > div > div > div > div > form > div.MuiFormControl-root.MuiFormControl-fullWidth.css-m5bgtg > p
${locator_msg_invalid_format}    css=#__next > div.layout-wrapper.MuiBox-root.css-33gw4 > div > div > div > div > div > form > div.MuiFormControl-root.MuiFormControl-fullWidth.css-m5bgtg > p
${locator_msg_invalid_pw}        css=#__next > div.layout-wrapper.MuiBox-root.css-33gw4 > div > div > div > div > div > form > div.MuiFormControl-root.MuiFormControl-fullWidth.css-tzsjye > p
${locator_hyperlink_createacc}   css=#__next > div.layout-wrapper.MuiBox-root.css-33gw4 > div > div > div > div > div > form > div.MuiBox-root.css-z0xj7h > p.MuiTypography-root.MuiTypography-body1.css-azsy9a > a

*** Keywords ***
Open Web Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Data for Login Page
    Input Text        ${locator_email}       user.test@krupbeam.com
    Input Text        ${locator_password}    123456789
    Click Element     ${locator_btn_login}

Input Data for Login Page Fail
    Input Text       ${locator_email}        user.admin@krupbeam.com
    Input Text       ${locator_password}     123456789
    Click Element    ${locator_btn_login}

Input Data for Login Page Invalid Format @
    Input Text       ${locator_email}        Beam1234gmail.com
    Click Element    ${locator_password}

Input Data for Login Page Invalid Format Thai
    Input Text       ${locator_email}        ไทย
    Click Element    ${locator_password}

Input Data for Login Page Invalid Format Number
    Input Text        ${locator_email}       09912345678
    Click Element    ${locator_password}

Input Data for Login Page Invalid Format Password number
    Input Text       ${locator_password}     123
    Click Element    ${locator_btn_login}

Input Data for Login Page Invalid Format Password Text
    Input Text       ${locator_password}     beam
    Click Element    ${locator_btn_login}

Input Empthy Data for Login Page
    Input Text       ${locator_email}       ${EMPTY}
    Input Text       ${locator_password}    ${EMPTY}
    Click Element    ${locator_btn_login}

*** Test Cases ***
TC001-login Positive
    Open Web Browser
    Input Data for Login Page
    Wait Until Page Contains    Kru P' Beam
    Close Browser

TC002-Login Negative
    Open Web Browser
    Input Data for Login Page Fail
    ${txt}    Get Text    ${locator_msg_invalid_email}
    Should Be Equal As Strings   ${txt}    Email or Password is invalid
    Close Browser

TC003-Recheck Login Page Name
    Open Web Browser
    Wait Until Page Contains    Kru P' Beam
    Close Browser

TC004-Login Invalid Format @ Email
    Open Web Browser
    Input Data for Login Page Invalid Format @
    ${txt}    Get Text    ${locator_msg_invalid_format}
    Should Be Equal As Strings   ${txt}    email must be a valid email
    Close Browser  

TC005-Login Invalid Format Number Email
    Open Web Browser
    Input Data for Login Page Invalid Format Number
    ${txt}    Get Text    ${locator_msg_invalid_format}
    Should Be Equal As Strings   ${txt}    email must be a valid email
    Close Browser  

TC006-Login Invalid Format Thai Email
    Open Web Browser
    Input Data for Login Page Invalid Format Thai
    ${txt}    Get Text    ${locator_msg_invalid_format}
    Should Be Equal As Strings   ${txt}    email must be a valid email
    Close Browser

TC007-login Invalid Format Password
    Open Web Browser
    Input Data for Login Page Invalid Format Password number
    ${txt}    Get Text    ${locator_msg_invalid_pw}
    Should Be Equal As Strings   ${txt}    password must be at least 5 characters
    Close Browser

TC008-login Invalid Format Password Txt
    Open Web Browser
    Input Data for Login Page Invalid Format Password Text
    ${txt}    Get Text    ${locator_msg_invalid_pw}
    Should Be Equal As Strings   ${txt}    password must be at least 5 characters
    Close Browser

TC009-login Rq Field Empthy
    Open Web Browser
    Input Empthy Data for Login Page
    ${txt}    Get Text    ${locator_msg_invalid_format}
    Should Be Equal As Strings   ${txt}    email is a required field
    ${txt}    Get Text    ${locator_msg_invalid_pw}
    Should Be Equal As Strings    ${txt}    password must be at least 5 characters
    Close Browser

TC010-Login Page Hyperlink Create acc
    Open Web Browser
    Click Link    ${locator_hyperlink_createacc}
    Wait Until Page Contains    Kru P' Beam
    Close Browser
