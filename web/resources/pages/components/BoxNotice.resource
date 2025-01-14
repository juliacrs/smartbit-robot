** Settings ***
Documentation       Açoes e elementos do Componente de caixa de notificaçao

Library    Browser

*** Keywords ***
Notice should be
    [Arguments]    ${Mensagem}
    
    ${element}     Set Variable    css=form .notice

    Wait For Elements State    ${element}    visible    5
    Get Text                   ${element}    equal    ${Mensagem}