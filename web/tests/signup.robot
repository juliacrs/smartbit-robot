*** Settings ***
Documentation        Cenarios de testes de pré-cadastro de clientes

Resource             ../resources/Base.resource
Library              DatabaseLibrary

Test Setup           Start session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke

    ${email}    Set Variable    auto_test@gmail.com

    # ${account}     Get Fake Account
    ${account}     Create Dictionary    
    ...    name=Automation TEST
    ...    email=${email}
    ...    cpf=12613005050

    Delete Account By Email    ${email}        # Usando a lib py

    # Conectar no Banco Postgres
    # Excluir a conta com base no email
    # ${rows_deleted}    Execute Sql String    DELETE FROM accounts WHERE email = '${email}'
    # # Verificar se a conta foi realmente excluída
    # ${result}    Query    SELECT * FROM accounts WHERE email = '${email}'
    # Should Be Empty    ${result}
    # Desconectar do Banco

    Submit signup form    ${account}
    Verify welcome message
    # Sleep          5

# Campo nome deve ser obrigatorio
#     [Tags]    required
    
#     ${account}     Create Dictionary    
#     ...    name=${EMPTY}
#     ...    email=teste@gmail.com
#     ...    cpf=12613005050

#     Submit signup form    ${account}
#     Notice should be      Por favor informe o seu nome completo
    
# Campo email deve ser obrigatorio
#     [Tags]    required
    
#     ${account}     Create Dictionary    
#     ...    name=Test Aut
#     ...    email=${EMPTY}
#     ...    cpf=12613005050

#     Submit signup form    ${account}
#     Notice should be      Por favor, informe o seu melhor e-mail

# Campo CPF deve ser obrigatorio
#     [Tags]    required
    
#     ${account}     Create Dictionary    
#     ...    name=Test Aut
#     ...    email=teste@gmail.com
#     ...    cpf=${EMPTY}

#     Submit signup form    ${account}
#     Notice should be      Por favor, informe o seu CPF

# Email no formato invalido
#     [Tags]    inv

#     ${account}     Create Dictionary    
#     ...    name=Test Aut
#     ...    email=teste*gmail.com
#     ...    cpf=12613005050

#     Submit signup form    ${account}
#     Notice should be      Oops! O email informado é inválido

# CPF no formato invalido
#     [Tags]    inv

#     ${account}     Create Dictionary    
#     ...    name=Test Aut
#     ...    email=teste@gmail.com
#     ...    cpf=1261300505a

#     Submit signup form    ${account}
#     Notice should be      Oops! O CPF informado é inválido


Tentativa de pré-cadastro
    [Template]    Attempt signup
    
    ${EMPTY}    teste@mgail.com    12613005050    Por favor informe o seu nome completo
    Test Aut    ${EMPTY}           12613005050    Por favor, informe o seu melhor e-mail
    Test Aut    teste@gmail.com    ${EMPTY}       Por favor, informe o seu CPF
    Test Aut    teste&gmail.com    12613005050    Oops! O email informado é inválido
    Test Aut    teste*gmail.com    12613005050    Oops! O email informado é inválido
    Test Aut    www.teste.com      12613005050    Oops! O email informado é inválido
    Test Aut    teste@gmail.com    126130050ab    Oops! O CPF informado é inválido
    Test Aut    teste@gmail.com    12613005111    Oops! O CPF informado é inválido
    Test Aut    teste@gmail.com    12613005       Oops! O CPF informado é inválido

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}     Create Dictionary    
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    Submit signup form    ${account}
    Notice should be      ${output_message}

Conectar no Banco Postgres
    Connect To Database
    ...    psycopg2
    ...    db_name=smartbit
    ...    db_user=postgres
    ...    db_password=QAx@123
    ...    db_host=localhost
    ...    db_port=15432

Desconectar do Banco
    Disconnect From Database