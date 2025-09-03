*** Settings ***
Library    ../../libs/ChatGPTLibrary.py    api_key=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    modo_teste=${MODO_TESTE}
Library    Browser
Library    Collections
Library    OperatingSystem
Library    AppiumLibrary
Library    BuiltIn

*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False

*** Keywords ***

Acessar tela de venda
    Click         text=Vendas
    Click         text=Nova venda
    Sleep    2s
    Reload
    Click         css=#origemVenda
    Click         xpath=(//div[@role="option"])[2]
    Click         xpath=//body
    Sleep         0.5s
    Press Keys    css=input[placeholder="Código"]   3 
    Sleep         1s
    Click         xpath=/html/body/div/div[2]/div[2]/div/div[1]/div[2]/form/div[2]/div[3]/button
    Sleep         1s
    Click         xpath=(//div[contains(@class,"cursor-pointer")])[last()]
    Sleep    1s
    ${rows}=    Get Elements    css=.gridRow:not(.opacity-50):not(.cursor-not-allowed)
    ${num_rows}=    Get Length    ${rows}
    Should Be True    ${num_rows} > 0    Nenhum produto habilitado encontrado
    ${random_index}=    Evaluate    random.randint(0, ${num_rows} - 1)    modules=random
    ${random_product_row}=    Set Variable    ${rows}[${random_index}]
    Scroll To Element    ${random_product_row}
    Wait For Elements State    ${random_product_row}    visible    5s
    Wait For Elements State    ${random_product_row}    enabled    5s
    Click    ${random_product_row}
    Click    xpath=//div[contains(@class,"cursor-pointer") and normalize-space(text())="Confirmar" and not(contains(@class,"disabled"))]