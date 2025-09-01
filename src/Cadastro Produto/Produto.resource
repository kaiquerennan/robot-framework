*** Settings ***
Library    ../../libs/GeradorDocumento.py
Library    ../../libs/ChatGPTLibrary.py    api_key=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    modo_teste=${MODO_TESTE}
Library    Browser
*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False

*** Keywords ***

Cadastrar Produtos
    Click    xpath=//button[@data-slot="button" and contains(., "Cadastros")]
    Click    xpath=//button[@data-slot="button" and contains(., "Produtos")]
    Click    text=Novo Produto
    ${nome}=     ChatGPT    Gere um nome de produtos famosos simples com no mínimo 5 caracteres. Retorne apenas 1(um) nome, sem mais nada. Sem ser grande
    Fill Text    css=#descricao   ${nome}
    Fill Text    css=#descricaoResumida    ${nome}
    Click    text=Gerenciar
    Click    css=#n1
    Click    xpath=(//div[@role="option"])[1]
    Click    css=div.btn-default.bg-primary >> text=Salvar
    Click    css=#unidadeComercialId
    Click    xpath=(//div[@role="option"])[2]
    Click    text=Preços / Custos
    Fill Text    css=#precoPadrao    20,00
    Click    text=Salvar
