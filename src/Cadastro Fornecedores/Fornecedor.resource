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
    ${f_ou_j}=    Evaluate    random.randint(1, 2)    random
    Click    css=button#natureza

    IF    '${f_ou_j}' == '1'
        Click    xpath=(//div[@role='option'])[1]
        ${nome_fornecedor}=    Gerar Nome Pessoa
        ${documento_fornecedor}=    Gerar CPF Valido
        Wait For Elements State    css=input[maxlength="14"]    visible    timeout=${TIMEOUT_CURTO}
        Fill Text    css=input[maxlength="14"]    ${documento_fornecedor}
    ELSE
        Click    xpath=(//div[@role='option'])[2]
        ${nome_fornecedor}=    Gerar Nome Fornecedor
        ${documento_fornecedor}=    Gerar CNPJ Valido
        Wait For Elements State    css=input[maxlength="18"]    visible    timeout=${TIMEOUT_CURTO}
        Fill Text    css=input[maxlength="18"]    ${documento_fornecedor}
        Fill Text    css=#razaoSocial    ${nome_fornecedor}
    END

    Fill Text    css=#nome    ${nome_fornecedor}

Editar fornecedor existente
    [Documentation]    Seleciona um fornecedor existente e atualiza seu email
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
    ${fornecedores}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd}=    Get Length    ${fornecedores}
    IF    ${qtd} == 0
        Skip    Nenhum fornecedor encontrado para editar
    END
    ${indice}=    Evaluate    random.randint(0, ${qtd} - 1)    random
    ${fornecedor}=    Set Variable    ${fornecedores}[${indice}]
    Click    ${fornecedor}
    Wait For Elements State    css=#nome    visible    timeout=${TIMEOUT_CURTO}
    ${novo_email}=    Gerar Email
    Click    text=E-mails
    Click    text=Adicionar >> visible=true
    Wait For Elements State    xpath=//div[contains(@class,'dialog') or @role='dialog']//input[not(@disabled)]    visible    timeout=${TIMEOUT_CURTO}
    ${campos}=    Get Elements    xpath=//div[contains(@class,'dialog') or @role='dialog']//input[not(@disabled)]
    ${qtd_campos}=    Get Length    ${campos}
    IF    ${qtd_campos} > 1
        ${identificacao}=    Gerar Identificacao
        Fill Text    ${campos}[0]    ${identificacao}
        Fill Text    ${campos}[1]    ${novo_email}
    ELSE
        Fill Text    ${campos}[0]    ${novo_email}
    END
    Click    xpath=(//div[contains(@class,'dialog') or @role='dialog']//button[contains(text(),'Salvar') or contains(text(),'Confirmar')])[last()]
    Click    text=Salvar >> visible=true
    Wait For Elements State    text=Fornecedor atualizado    state=visible    timeout=${TIMEOUT_CURTO}

Validar campo obrigatorio fornecedor
    [Documentation]    Tenta salvar um fornecedor sem preencher campos obrigatorios
    Click    text=Salvar >> visible=true
    Wait For Elements State    xpath=//*[contains(text(),'obrigat') or contains(text(),'Obrigat') or contains(text(),'required') or contains(@class,'error')]    visible    timeout=${TIMEOUT_CURTO}
