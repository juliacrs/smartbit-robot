*** Settings ***
Documentation        Açoes e elementos do componente menu de navegaçao

Library        AppiumLibrary

*** Keywords ***
Touch my body
    Click Element    xpath=//android.widget.TextView[@text="Meu corpo"]

Touch my account
    Click Element    xpath=//android.widget.TextView[@text="Minha conta"]
