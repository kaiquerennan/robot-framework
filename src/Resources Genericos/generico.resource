*** Settings ***
Library    Browser

*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False
*** Keywords ***
Abrir navegador 
    New Browser    chromium    headless=False
    ${context}=    New Context    ignoreHTTPSErrors=True    viewport={'width': 1920, 'height': 1080}
    New Page    ${URL}   
Preencher Login
    Fill Text    css=input[placeholder="Nome de usuário ou email"]    kaique
    Fill Text    css=input[placeholder="Sua senha"]    1234567
    Click    text=Entrar