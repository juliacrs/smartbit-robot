*** Settings ***
Documentation       Açoes e elementos da pagina de matricula

Library    Browser

*** Keywords ***
Create new membership
    [Arguments]    ${data}

    Go to memberships form
    Select account        ${data}[account][name]    ${data}[account][cpf]    # para mostrar o cpf no html, gerar o arq
    Select plan           ${data}[plan][name]
    Fill payment card     ${data}[credit_card]

    Click                css=button[type="submit"] >> text=Cadastrar

Go to memberships form
    Click        css=a[href="/memberships/new"]
    Wait For Elements State    css=h1 >> text=Nova matrícula    visible    5

Select account
    [Arguments]    ${name}    ${cpf}
    Fill Text    css=input[aria-label="select_account"]    ${name}
    # # buscar a selecao do combobox
    # Sleep        2
    # ${html}      Get Page Source
    # Log          ${html}
    Click        css=[data-testid="${cpf}"]

Select plan
    [Arguments]    ${plano}

    Fill Text    css=input[aria-label="select_plan"]    ${plano}     # para mostrar o cpf no html, gerar o arq
    # Click        css=div[id*=option] >> text=${plano}
    Click        css=div[class$=option] >> text=${plano}        # regex $ = termina com    

Fill payment card
    [Arguments]    ${card}

    Fill Text    css=input[name=card_number]    ${card}[number]
    Fill Text    css=input[name=card_holder]    ${card}[holder]
    Fill Text    css=input[name=card_month]     ${card}[month]
    Fill Text    css=input[name=card_year]      ${card}[year]
    Fill Text    css=input[name=card_cvv]       ${card}[cvv]

Search by name
    [Arguments]    ${name}

    Fill Text    css=input[placeholder^="Busque por nome"]    ${name}
    Wait For Elements State    css=strong >> text=Total: 1    visible    5

Should filter by name
    [Arguments]    ${name}

    Wait For Elements State    css=table tbody tr >> text=${name}    visible    5

Request removal by name
    [Arguments]    ${name}

    Click                xpath=//td[text()="${name}"]/..//button

Membership should not be visible
    [Arguments]    ${name}

    Wait For Elements State    css=table tbody tr >> text=${name}    detached    5