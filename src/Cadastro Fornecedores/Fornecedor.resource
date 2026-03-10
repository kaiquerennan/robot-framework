*** Settings ***
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource

*** Keywords ***

Acessar cadastro de fornecedor
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Fornecedores
    Click    text=Novo Fornecedor

Cadastrar fornecedor
    ${nome_fornecedor}=    Gerar Nome Fornecedor
    ${cnpj_fornecedor}=    Gerar CNPJ Valido
    Fill Text    css=#nome    ${nome_fornecedor}
    Fill Text    css=#documentoNumero    ${cnpj_fornecedor}
    Fill Text    css=#razaoSocial    ${nome_fornecedor}
    ${email}=    Gerar Email Para Nome    ${nome_fornecedor}
    Fill Text    css=input[placeholder="email"]    ${email}

Editar fornecedor existente
    [Documentation]    Seleciona um fornecedor existente e edita seu email
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
    ${fornecedores}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd}=    Get Length    ${fornecedores}
    IF    ${qtd} == 0
        Skip    Nenhum fornecedor encontrado para editar
    END
    ${indice}=    Evaluate    random.randint(0, ${qtd} - 1)    random
    ${fornecedor}=    Set Variable    ${fornecedores}[${indice}]
    Click    ${fornecedor}
    Wait For Elements State    css=input[placeholder="email"]    visible    timeout=${TIMEOUT_CURTO}
    ${novo_email}=    Gerar Email
    Fill Text    css=input[placeholder="email"]    ${novo_email}
    Click    text=Salvar >> visible=true
    Wait For Elements State    text=Fornecedor atualizado    state=visible    timeout=${TIMEOUT_CURTO}

Validar campo obrigatório fornecedor
    [Documentation]    Tenta salvar um fornecedor sem preencher campos obrigatórios
    Click    text=Salvar >> visible=true
    Wait For Elements State    xpath=//*[contains(text(),'obrigatório') or contains(text(),'Obrigatório') or contains(text(),'required') or contains(@class,'error')]    visible    timeout=${TIMEOUT_CURTO}
