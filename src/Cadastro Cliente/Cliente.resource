*** Settings ***
Library    Browser
Library    ../../libs/GeradorDocumento.py
Library    ../../libs/ChatGPTLibrary.py    api_key=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    modo_teste=${MODO_TESTE}
Library    ../../libs/BuscarCepAleatorio.py
*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False
*** Keywords ***
Acessar cadastro de cliente
    Click    xpath=//button[@data-slot="button" and contains(., "Cadastros")]
    Click    xpath=//button[@data-slot="button" and contains(., "Clientes")]
    Click    text=Novo Cliente

Cadastrar cliente
    ${f_ou_j}=    ChatGPT    Escolha aleatoriamente entre J ou F. Responda apenas com J ou F. As chances deverão ser as mesmas para ambas as opções
    Log To Console    ${f_ou_j}
    Click    css=button#natureza
    
    IF    '${f_ou_j}' == 'F'
        Click    xpath=//div[@role='option' and contains(., 'Física')]
        ${documento}=    Gerar CPF Valido
        Fill text    css=input[placeholder="Informe o CPF"]    ${documento}
        ${nome}=     ChatGPT    Gere um nome brasileiro simples com no mínimo 5 caracteres. Retorne apenas o nome, sem mais nada
        Fill Text    css=input[placeholder="Nome"]    ${nome}
        Fill Text    css=input[placeholder="dd/mm/aaaa"]    23/05/2024
        ${sexo}=     ChatGPT    Gere um sexo (masculino ou feminino). Retorne M ou F.
        Click    css=button#sexo
        IF    '${sexo}' == 'M'
            Click    xpath=//div[@role='option' and contains(., 'Masculino')]
        ELSE
            Click    xpath=//div[@role='option' and contains(., 'Feminino')]
        END
    ELSE
        Click    xpath=//div[@role='option' and contains(., 'Jurídica')]
        ${documento}=    Gerar CNPJ Valido
        Fill text    css=input[placeholder="Informe o CNPJ"]    ${documento}
         ${nome}=     ChatGPT    Gere um nome brasileiro simples com no mínimo 5 caracteres. Retorne apenas o nome, sem mais nada
        Fill Text    css=input[placeholder="Nome fantasia"]    ${nome}
        Fill Text    css=#razaoSocial    ${nome}
    END
    
    ${email}=    ChatGPT    Gere um email simples baseado no nome ${nome}. Retorne apenas o email, sem mais nada    

    Fill Text    css=input[placeholder="E-mail"]    ${email}
    Click    text=Salvar

    