*** Settings ***    
Resource    ../Resources Genericos/generico.resource
Library    Browser
Library    Collections


*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/
${MODO_TESTE}    False

*** Keywords ***
Acessar tela de estoque
    Click         text=Estoque >> nth=0
    Click         text=Estoque de produtos
    Sleep    0.5s
    Reload

Escolher algum produto
    ${produtos}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_produtos}=    Get Length    ${produtos}
    Log to console    quantidade encontrada: ${qtd_produtos}
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_produtos} - 1)    random
    ${produto_aleatorio}=    Set Variable    ${produtos}[${indice_aleatorio}]
    Log To Console    produto: ${produto_aleatorio}
    ${codigo_produto}=     Get Text    ${produto_aleatorio} >> css=div.flex.justify-start.flex-1.px-1:first-child
    ${estoque_produto}=    Get Text    ${produto_aleatorio} >> css=div:nth-child(3)
    
    Log To Console    Produto: ${produto_aleatorio}
    Log To Console    Código: ${codigo_produto}
    Log To Console    Estoque: ${estoque_produto}
    Set Global Variable    ${PRODUTO_CODIGO}    ${codigo_produto}
    Set Global Variable    ${PRODUTO_ESTOQUE}    ${estoque_produto}
    Set Global Variable    ${PRODUTO}    ${produto_aleatorio}

 
Vender produto escolhido
    Click   xpath=/html/body/div/div[2]/div[2]/div/div[1]/div[2]/form/div[2]/div[3]/button
    Click   xpath=(//div[contains(@class,"cursor-pointer")])[last()]
    Sleep    0.5s
    Click    xpath=(//div[contains(@class,'gridListSaleProd')])[2]//div[contains(@class,'gridRow') and .//div[contains(@class,'flex') and contains(@class,'justify-start') and contains(@class,'px-1') and text()=${PRODUTO_CODIGO}]]
    Click    text=Confirmar >> nth=1
    ${quantidade}=    Evaluate    random.randint(1, 5)    random
    Log To Console    quantidade: ${quantidade}
    Fill Text    xpath=(//input[@id='quantidade'])[last()]    ${quantidade}
    Click    text=Salvar 
    Set Global Variable    ${quantidade}    ${quantidade}

Comparar estoque 
    Acessar tela de estoque
    ${novo_estoque}=    Get Text    ${PRODUTO} >> css=div:nth-child(3)
    Sleep    1s
    Log To Console    Estoque antigo: ${PRODUTO_ESTOQUE}
    Log To Console    \n
    Log To Console    Novo estoque: ${novo_estoque}
    ${estoque_esperado}=    Evaluate    int(${PRODUTO_ESTOQUE}) - int(${quantidade})
    Should Be Equal As Integers    ${novo_estoque}    ${estoque_esperado}    Estoque não foi atualizado corretamente!