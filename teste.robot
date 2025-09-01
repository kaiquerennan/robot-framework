*** Settings ***    

Library    Browser
*** Variables ***
${URL}    https://www.emcsistemas.com/


*** Keywords ***
Abrir navegador
    New Browser    chromium    headless=False
    New Page    ${URL}


*** Test Cases ***
Abrir página da emc sistemas
    Abrir navegador

