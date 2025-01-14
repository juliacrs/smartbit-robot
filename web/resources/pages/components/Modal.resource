*** Settings ***
Documentation       Açoes e elementos do componente modal (popup)

Library    Browser

*** Keywords ***
Confirm removal
    Click    css=button[class*=swal2-confirm]