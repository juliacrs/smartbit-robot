*** Settings ***
Documentation       Açoes e elementos da pagina de barra de navegaçao

Library    Browser

*** Keywords ***
User is logged informado
    [Arguments]    ${email}

    ${elemeent}    Set Variable    css=.logged-user

    Wait For Elements State    ${elemeent}    visible    5
    Get Text                   ${elemeent}    equal      ${email}
    
Go to memberships
    Click        css=a[href="/memberships"]
    Wait For Elements State    css=h1 >> text=Matrículas    visible    5

