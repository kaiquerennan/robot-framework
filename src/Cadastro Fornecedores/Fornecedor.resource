*** Settings ***
Library    ../../libs/GeradorDocumento.py
Library    ../../libs/ChatGPTLibrary.py    api_key=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    modo_teste=${MODO_TESTE}
Library    Browser
Library    ../../libs/BuscarCepAleatorio.py

*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False

*** Keywords ***

Acessar cadastro de fornecedor
    Click    xpath=//button[@data-slot="button" and contains(., "Cadastros")]
    Click    xpath=//button[@data-slot="button" and contains(., "Fornecedores")]

Cadastrar fornecedor
    ${nome_fornecedor}    ChatGPT    Gere um nome simples de fornecedor brasileiro que faça sentido, com no mínimo 5 caracteres. Retorne apenas o nome do fornecedor
    ${cnpj_fornecedor}    Gerar CNPJ Valido
    Fill Text   css=#nome     ${nome_fornecedor}
    Fill Text   css=#documentoNumero   ${cnpj_fornecedor}
    Fill Text   css=#razaoSocial   ${nome_fornecedor}
    ${email}    ChatGPT    Gere um endereço de email ficticio com base no nome ${nome_fornecedor}, utilizando o nome do fornecedor. Retorne apenas o email.
    Fill Text    css=input[placeholder="email"]    ${email}
