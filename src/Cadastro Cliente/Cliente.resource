*** Settings ***
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource

*** Keywords ***
Acessar cadastro de cliente
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Clientes
    Click    text=Novo Cliente

Cadastrar cliente
    ${f_ou_j}=    Evaluate    random.randint(1, 2)    random
    Log To Console    Natureza: ${f_ou_j}
    Click    css=button#natureza

    IF    '${f_ou_j}' == '1'
        Click    xpath=//div[@role='option' and contains(., 'Física')]
        ${documento}=    Gerar CPF Valido
        Fill Text    css=input[placeholder="Informe o CPF"]    ${documento}
        ${nome}=    Gerar Nome Pessoa
        Fill Text    css=input[placeholder="Nome"]    ${nome}
        Fill Text    css=input[placeholder="dd/mm/aaaa"]    23/05/2024
        ${sexo}=    Evaluate    random.randint(1, 2)    random
        Click    css=button#sexo
        IF    '${sexo}' == '1'
            Click    xpath=//div[@role='option' and contains(., 'Masculino')]
        ELSE
            Click    xpath=//div[@role='option' and contains(., 'Feminino')]
        END
    ELSE
        Click    xpath=//div[@role='option' and contains(., 'Jurídica')]
        ${documento}=    Gerar CNPJ Valido
        Fill Text    css=input[placeholder="Informe o CNPJ"]    ${documento}
        ${nome}=    Gerar Nome Empresa
        Fill Text    css=input[placeholder="Nome fantasia"]    ${nome}
        Fill Text    css=#razaoSocial    ${nome}
    END

    ${email}=    Gerar Email Para Nome    ${nome}
    Fill Text    css=input[placeholder="E-mail"]    ${email}
    Click    text=Salvar
    Wait For Elements State    text=Cliente cadastrado    state=visible    timeout=${TIMEOUT_CURTO}

Editar cliente existente
    [Documentation]    Seleciona um cliente existente e edita seu email
    ${clientes}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_clientes}=    Get Length    ${clientes}
    IF    ${qtd_clientes} == 0
        Skip    Nenhum cliente encontrado para editar
    END
    ${indice}=    Evaluate    random.randint(0, ${qtd_clientes} - 1)    random
    ${cliente}=    Set Variable    ${clientes}[${indice}]
    Click    ${cliente}
    Wait For Elements State    css=input[placeholder="E-mail"]    visible    timeout=${TIMEOUT_CURTO}
    ${novo_email}=    Gerar Email
    Fill Text    css=input[placeholder="E-mail"]    ${novo_email}
    Click    text=Salvar
    Wait For Elements State    text=Cliente atualizado    state=visible    timeout=${TIMEOUT_CURTO}

Buscar cliente por nome
    [Documentation]    Pesquisa um cliente pelo nome no campo de busca
    [Arguments]    ${nome_busca}
    Wait For Elements State    css=input[placeholder="Pesquisar"]    visible    timeout=${TIMEOUT_CURTO}
    Fill Text    css=input[placeholder="Pesquisar"]    ${nome_busca}
    Sleep    1s
    ${resultados}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd}=    Get Length    ${resultados}
    Log To Console    Resultados encontrados para "${nome_busca}": ${qtd}
    RETURN    ${qtd}

Validar campo obrigatório cliente
    [Documentation]    Tenta salvar um cliente sem preencher campos obrigatórios e valida mensagem de erro
    Click    text=Salvar
    Wait For Elements State    xpath=//*[contains(text(),'obrigatório') or contains(text(),'Obrigatório') or contains(text(),'required') or contains(@class,'error')]    visible    timeout=${TIMEOUT_CURTO}