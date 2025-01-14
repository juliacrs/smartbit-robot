*** Settings ***
Documentation        Arquivo para testar o consumo da API com tasks

Resource        service.resource

*** Tasks ***
Testando a API
    Set user token
    Get account by nome    Dominic Toreto