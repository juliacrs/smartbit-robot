*** Settings ***
Documentation        Cenarios de testes do Login SAC

Resource             ../resources/Base.resource

Test Setup           Start session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve logar como Gestor de Academia
    [Tags]    smoke

    Go to login page
    Submit login form          sac@smartbit.com    pwd123
    User is logged informado   sac@smartbit.com 

Não deve logar com senha incorreta
    [Tags]    inv_pass

    Go to login page
    Submit login form      sac@smartbit.com    abc123
    Toast should be        As credenciais de acesso fornecidas são inválidas. Tente novamente!
 
Não deve logar com email não cadastrado
    [Tags]    email_404

    Go to login page
    Submit login form      404@smartbit.com    abc123
    Toast should be        As credenciais de acesso fornecidas são inválidas. Tente novamente!
 
Tentativa de login com dados incorretos
    [Template]    Login with verify Notice

    ${EMPTY}            ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}            pwd123      Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    www.teste.com       pwd123      Oops! O email informado é inválido
    sac&smartbit.com    pwd123      Oops! O email informado é inválido
    sac@smartbit        pwd123      Oops! O email informado é inválido
    smartbit.com        pwd123      Oops! O email informado é inválido

*** Keywords ***
Login with verify Notice
    [Arguments]        ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form    ${email}    ${password}
    Notice should be     ${output_message}