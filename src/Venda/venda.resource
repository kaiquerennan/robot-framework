*** Settings ***
Library    ../../libs/ChatGPTLibrary.py    api_key=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    modo_teste=${MODO_TESTE}
Library    Browser
Library    Collections
Library    OperatingSystem
Library    BuiltIn

*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False
${PAINEL_ATIVO}    css=[role="dialog"][data-state="open"]

*** Keywords ***

Acessar tela de venda
    Click         text=Vendas
    Click         text=Operações
    Click        text=Nova Venda
    Sleep    0.5s
    Reload

Escolher venda
    Click         css=#origemVenda
    Click         xpath=(//div[@role="option"])[1]

Escolher pré-venda
    Reload
    Click         css=#origemVenda
    Click         xpath=(//div[@role="option"])[2]

Escolher pedido
    Click         css=#origemVenda
    Click         xpath=(//div[@role="option"])[3]

Escolher orçamento
    Click         css=#origemVenda
    Click         xpath=(//div[@role="option"])[4]


Preencher vendedor
    Click         xpath=//body
    Sleep         0.5s
    Press Keys    css=input[placeholder="Código"]   3
    Sleep    0.3s 


Escolher cliente
    Click         xpath=(//div[contains(@class,"cursor-pointer")])[2]
    ${numero}=   Evaluate    random.randint(1, 20)    random
    Sleep    0.1s
    ${clientes}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_clientes}=    Get Length    ${clientes}
    Log to console    quantidade encontrada: ${qtd_clientes}
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_clientes} - 1)    random
    ${cliente_aleatorio}=    Set Variable    ${clientes}[${indice_aleatorio}]
    Log To Console    cliente: ${cliente_aleatorio}
    Click    ${cliente_aleatorio}



Realizar Operação
    ${numero}=    Evaluate    random.randint(8, 8)    random
    Log To Console    quantidade: ${numero}
    FOR    ${i}    IN RANGE    1    ${numero}+1
    Click         xpath=/html/body/div/div[2]/div[2]/div/div[1]/div[2]/form/div[2]/div[3]/button
    Click         xpath=(//div[contains(@class,"cursor-pointer")])[last()]
    ${produtos}=    Get Elements    xpath=(//div[contains(@class,'gridListSaleProd')])[2]//div[contains(@class,'gridRow') and not(contains(@class,'cursor-not-allowed'))]
    ${qtd_produtos}=    Get Length    ${produtos}
    Log to console    quantidade encontrada: ${qtd_produtos}
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_produtos} - 1)    random
    ${produto_aleatorio}=    Set Variable    ${produtos}[${indice_aleatorio}]
    Log To Console    produto: ${produto_aleatorio}
    Click    ${produto_aleatorio}
    Click    text=Confirmar >> nth=1
    ${quantidade}=    Evaluate    random.randint(1, 8)    random
    Log To Console    quantidade: ${quantidade}
    Fill Text    xpath=(//input[@id='quantidade'])[last()]    ${quantidade}
    END
    Click    text=Salvar 
    Sleep    1.5s




    
