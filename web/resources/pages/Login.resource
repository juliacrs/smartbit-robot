*** Settings ***
Documentation       Açoes e elementos da page de login

Variables   ../Env.py

Library    Browser

*** Keywords ***
Go to login page
    Go To    ${BASE_URL}/login

Submit login form
    [Arguments]    ${email}    ${password}

    Fill Text    css=input[name=email]       ${email}
    Fill Text    css=input[name=password]    ${password}
    Click        css=button >> text=Entrar

