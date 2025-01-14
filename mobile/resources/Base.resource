*** Settings ***
Documentation        Arquivo principal do projeto de testes automatizados para Mobile

Library        AppiumLibrary
Library        JSONLibrary

Library        ../../libs/Database.py

Resource       ./actions/login.resource
Resource       ./actions/account.resource
Resource       ./actions/mybody.resource
Resource       ./actions/components/menu.resource
Resource       ./actions/components/popup.resource

Resource        ../../services/service.resource

*** Keywords ***
Start session
    
    Open Application
    ...    http://localhost:4723
    ...    platformName=Android
    ...    automationName=UIAutomator2
    ...    deviceName=Emulator
    ...    udid=emulator-5554
    ...    appPackage=br.com.qax.smartbit
    ...    appActivity=br.com.qax.smartbit.MainActivity
    ...    autoGrantPermissions=true

    Wait Until Page Contains    IP da API     30

Get Json fixture
    [Arguments]    ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/data.json
    ...    encoding=utf-8
    
    RETURN    ${data}[${scenario}]  # Traz o valor do cenario

Finish session
    Capture Page Screenshot
    Close Application

