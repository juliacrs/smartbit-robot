*** Settings ***
Documentation        Camada de integraçao com a API

Library      RequestsLibrary

Variables    Env.py

*** Keywords ***
Set user token
    
    ${payload}    Create Dictionary
    ...        email=sac@smartbit.com
    ...        password=pwd123

    ${resp}    POST       
    ...        url=${API_URL}/sessions        # url=http://localhost:3333/sessions
    ...        json=${payload}

    ${token}    Set Variable    Bearer ${resp.json()}[token]

    Set Suite Variable    ${token}

Get account by nome
    [Arguments]    ${name}

    ${headers}    Create Dictionary
    ...        Authorization=${token}
    
    ${params}    Create Dictionary
    ...        name=${name}


    ${resp}    GET
    ...    url=${API_URL}/accounts
    ...    params=${params}
    ...    headers=${headers}

    RETURN    ${resp.json()}[data][0]        # retorna todos os dados do primeiro registro
