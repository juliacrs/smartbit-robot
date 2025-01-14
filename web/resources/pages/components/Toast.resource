*** Settings ***
Documentation       Açoes e elementos do Componente Toast

Library    Browser

*** Keywords ***
Toast should be
    [Arguments]    ${expected_text}

    ${selector}    Set Variable   .Toastify__toast-body
     # Obter o codigo html  para validar TOAST (msg rapida na tela) 
  # e salvar em um arq para buscar o elemente desejado
    # Sleep    3
    # ${temp}    Get Page Source
    # Log    ${temp}
    Wait For Elements State    css=${selector}    visible    5
    Get Text    css=${selector}    equal    ${expected_text}

    Take Screenshot    selector=${selector}
