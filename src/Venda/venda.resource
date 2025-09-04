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
${PAINEL_ATIVO}    css=[role="dialog"][data-state="open"]

*** Keywords ***

Acessar tela de venda
    Click         text=Vendas
    Click         text=Operações
    Click    text=Nova Venda
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

    ${produtos}=    Get Elements    css=div.flex.flex-col.w-3\\/4.h-full.overflow-y-auto > div.gridHeightSaleProd > div.gridListSaleProd > div.gridRow:not(.cursor-not-allowed):visible
    ${qtd_produtos}=    Get Length    ${produtos}
    Log to console    quantidade encontrada: ${qtd_produtos}
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_produtos} - 1)    random
    ${produto_aleatorio}=    Set Variable    ${produtos}[${indice_aleatorio}]
    Wait For Elements State    ${produto_aleatorio}    visible    10s
    Wait For Elements State    ${produto_aleatorio}    enabled    10s
    Click    ${produto_aleatorio}




