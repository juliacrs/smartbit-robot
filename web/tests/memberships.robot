*** Settings ***
Documentation        Suite de testes de adesoes de planos

Resource             ../resources/Base.resource

Test Setup           Start session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder realizar uma nova adesao
    
 # Salvo no arq json
    # ${account}     Create Dictionary    
    # ...    name=Paulo Cintura
    # ...    email=paulo@cintura.com.br
    # ...    cpf=37860578000
    
    # ${plan}    Set Variable    Plano Black

    # ${credit_card}     Create Dictionary    
    # ...    number=4242424242424242
    # ...    holder=Paulo Cintura
    # ...    month=12
    # ...    year=2030
    # ...    cvv=123

    # Delete Account By Email    ${account}[email]
    # Insert Account             ${account}

    ${data}    Get Json fixture    memberships    create

    Delete Account By Email    ${data}[account][email]
    Insert Account             ${data}[account]

    SignIn admin
    Go to memberships
    Create new membership    ${data}
    Toast should be          Matrícula cadastrada com sucesso.


Não deve realizar adesao duplicada
    [Tags]    dup

    ${data}    Get Json fixture    memberships    duplicate
    Insert Membership        ${data}

    SignIn admin
    Go to memberships
    Create new membership    ${data}
    # Sleep    8
    # Create new membership    ${data}
    Toast should be          O usuário já possui matrícula.
    
Deve buscar por nome
    [Tags]    search

    ${data}        Get Json fixture    memberships    search
    Insert Membership        ${data}

    SignIn admin
    Go to memberships
    Search by name           ${data}[account][name]
    Should filter by name    ${data}[account][name]

Deve excluir uma matricula
    [Tags]    remove

    ${data}        Get Json fixture    memberships    remove
    Insert Membership        ${data}

    SignIn admin
    Go to memberships
    
    Search by name       ${data}[account][name]
    
    Request removal by name    ${data}[account][name]
    Confirm removal

    Membership should not be visible    ${data}[account][name]
    
    Toast should be    Matrícula removida com sucesso.



