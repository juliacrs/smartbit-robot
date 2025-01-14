*** Settings ***
Documentation    Açoes e elementos da LANDING PAGE

Library    Browser

*** Keywords ***
Submit signup form
    [Arguments]    ${account}

    Get Text       css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text      id=name         ${account}[name]
    Fill Text      id=email        ${account}[email]
    Fill Text      id=cpf          ${account}[cpf]
    # Click          xpath=//button[text()="Cadastrar"]
    # Click          text=Cadastrar
    Click          css=button >> text=Cadastrar        #c Combinaçao de estrategia


