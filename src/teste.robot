*** Settings ***    

Library    Browser
Library    String
Library    AppiumLibrary
Library    OperatingSystem
*** Variables ***
${URL}    https://www.emcsistemas.com/


*** Keywords ***
Abrir navegador
    New Browser    chromium    headless=False
    New Page    ${URL}

Clicar no botão 
    Click    text=Quero conhecer

Preencher Formulario
    Fill Text    css=#contato input[placeholder="CNPJ"]:visible    04.507.969/0001-04
    Fill Text    css=#contato input[placeholder="Nome"]    kaique
    Fill Text    css=#contato input[placeholder="E-mail"]    kaiquerennan@gmail.com
    Fill Text    css=#contato input[placeholder="Celular"]    31971454510
    Sleep    5s
    Close Browser
*** Test Cases ***
Abrir página da emc sistemas
    Abrir navegador
    Clicar no botão
    Preencher Formulario
