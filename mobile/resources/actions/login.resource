*** Settings ***
Documentation        Açoes e elementos da tela de login

Library        AppiumLibrary

*** Keywords ***
SignIn with Documentation
    [Arguments]    ${cpf}

    Input Text       xpath=//android.widget.EditText[@resource-id="ipAddress"]    172.30.64.1
    Input Text       xpath=//android.widget.EditText[@resource-id="cpf"]          ${cpf}
    Click Element    xpath=//android.view.ViewGroup[@resource-id="btnLogin"]

