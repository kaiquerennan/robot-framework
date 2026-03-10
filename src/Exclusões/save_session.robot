*** Settings ***
Library    Browser
Library    OperatingSystem

*** Test Cases ***
Salvar Sessao Do Sistema
    New Browser    browser=chromium    headless=False
    New Context
    New Page       https://emc-frontend-hml.emcsistemas.com.br/venda/operacoes/venda
    
    Log To Console    \nFaca o login e selecione a loja.
    Log To Console    Quando terminar, pressione ENTER no terminal para continuar...
    
    Evaluate    input("Pressione ENTER para salvar a sessao...")    modules=builtins
    
    ${state_path}=    Save Storage State
    Copy File    ${state_path}    ${CURDIR}${/}state.json
    
    Log To Console    Estado salvo em: ${CURDIR}${/}state.json
    Close Browser