*** Settings ***
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource
Resource    ../Resources Genericos/generico.resource

*** Variables ***
${BTN_SALVAR_CLIENTE}    css=button[type="submit"]

*** Keywords ***
Acessar cadastro de cliente
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Clientes
    Click    text=Novo Cliente

Cadastrar cliente
    ${f_ou_j}=    Evaluate    random.randint(1, 2)    random
    Click    css=button#natureza

    IF    '${f_ou_j}' == '1'
        Click    xpath=(//div[@role='option'])[1]
        ${nome}=    Gerar Nome Pessoa
        ${documento}=    Gerar CPF Valido
        Wait For Elements State    xpath=//div[@data-state='active' and @role='tabpanel']//button[@id='natureza']/ancestor::div[1]/following-sibling::div[1]//input[@maxlength='14']    visible    timeout=${TIMEOUT_CURTO}
        Fill Text    xpath=//div[@data-state='active' and @role='tabpanel']//button[@id='natureza']/ancestor::div[1]/following-sibling::div[1]//input[@maxlength='14']    ${documento}
        Fill Text    css=#nome    ${nome}
        ${tem_data}=    Run Keyword And Return Status    Wait For Elements State    xpath=//div[@data-state='active' and @role='tabpanel']//input[@maxlength='10']    visible    timeout=1s
        IF    ${tem_data}
            Fill Text    xpath=//div[@data-state='active' and @role='tabpanel']//input[@maxlength='10']    23/05/2024
        END
        ${tem_sexo}=    Run Keyword And Return Status    Wait For Elements State    css=button#sexo    visible    timeout=1s
        IF    ${tem_sexo}
            Click    css=button#sexo
            Click    xpath=(//div[@role='option'])[1]
        END
    ELSE
        Click    xpath=(//div[@role='option'])[2]
        ${nome}=    Gerar Nome Empresa
        ${documento}=    Gerar CNPJ Valido
        Wait For Elements State    xpath=//div[@data-state='active' and @role='tabpanel']//button[@id='natureza']/ancestor::div[1]/following-sibling::div[1]//input[@maxlength='18']    visible    timeout=${TIMEOUT_CURTO}
        Fill Text    xpath=//div[@data-state='active' and @role='tabpanel']//button[@id='natureza']/ancestor::div[1]/following-sibling::div[1]//input[@maxlength='18']    ${documento}
        Fill Text    css=#nome    ${nome}
        Fill Text    css=#razaoSocial    ${nome}
    END

    Preencher enderecos do cliente
    Preencher telefones do cliente
    Preencher emails do cliente

    Click    ${BTN_SALVAR_CLIENTE}

Preencher enderecos do cliente
    [Documentation]    Preenche a aba Endereços do cadastro de clientes usando a keyword genérica de CEP.
    Preencher CEP
    Click    [data-testid="btn-salvar"]

Preencher telefones do cliente
    [Documentation]    Preenche a aba Telefones do cadastro de clientes usando a keyword genérica do projeto.
    Cadastrar Telefone
    Click    [data-testid="btn-salvar"]

Preencher emails do cliente
    [Documentation]    Preenche a aba E-mails com uma identificação e um e-mail válidos.
    ${novo_email}=    Gerar Email
    ${identificacao}=    Gerar Identificacao
    Click    text=E-mails
    Click    text=Adicionar >> visible=true
    Fill Text    id=identificacao    ${identificacao}
    Fill Text    id=email    ${novo_email}
    Click    xpath=(//div[contains(@class,'dialog') or @role='dialog']//button[@type='button' and contains(.,'Salvar')])[last()]
Editar cliente existente
    [Documentation]    Seleciona um cliente existente e atualiza seu nome
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
    ${clientes}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_clientes}=    Get Length    ${clientes}
    IF    ${qtd_clientes} == 0
        Skip    Nenhum cliente encontrado para editar
    END
    ${indice}=    Evaluate    random.randint(0, ${qtd_clientes} - 1)    random
    ${cliente}=    Set Variable    ${clientes}[${indice}]
    Click    ${cliente}
    Wait For Elements State    css=#nome    visible    timeout=${TIMEOUT_CURTO}
    ${novo_nome}=    Gerar Nome Empresa
    Fill Text    css=#nome    ${novo_nome}
    Wait For Elements State    ${BTN_SALVAR_CLIENTE}:not([disabled])    visible    timeout=${TIMEOUT_CURTO}
    Click    ${BTN_SALVAR_CLIENTE}
    Wait For Elements State    text=Cliente atualizado    state=visible    timeout=${TIMEOUT_CURTO}

Buscar cliente por nome
    [Documentation]    Pesquisa um cliente pelo nome no campo de busca
    [Arguments]    ${nome_busca}
    Wait For Elements State    css=input[placeholder="Nome do cliente"]    visible    timeout=${TIMEOUT_CURTO}
    Fill Text    css=input[placeholder="Nome do cliente"]    ${nome_busca}
    Sleep    1s
    ${tem_mensagem_vazia}=    Run Keyword And Return Status
    ...    Wait For Elements State    xpath=//*[contains(text(),'Nenhum registro encontrado')]    visible    timeout=1s
    IF    ${tem_mensagem_vazia}
        Log To Console    Nenhum registro encontrado para "${nome_busca}"
        RETURN    ${0}
    END
    ${resultados}=    Get Elements    xpath=//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))]
    ${qtd}=    Get Length    ${resultados}
    Log To Console    Resultados encontrados para "${nome_busca}": ${qtd}
    RETURN    ${qtd}

Validar campo obrigatorio cliente
    [Documentation]    Tenta salvar um cliente sem preencher campos obrigatorios e valida mensagem de erro
    Wait For Elements State    ${BTN_SALVAR_CLIENTE}    visible    timeout=${TIMEOUT_CURTO}
    ${estados}=    Get Element States    ${BTN_SALVAR_CLIENTE}
    Log To Console    Estados do botão salvar cliente: ${estados}
    Should Contain    ${estados}    disabled    O botão Salvar deveria estar desabilitado com o cadastro vazio.
