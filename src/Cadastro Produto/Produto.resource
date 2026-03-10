*** Settings ***
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource

*** Keywords ***

Cadastrar Produtos
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Produtos
    Click    text=Novo Produto
    ${nome}=    Gerar Nome Produto
    Fill Text    css=#descricao    ${nome}
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
    Wait For Elements State    text=Produto cadastrado    state=visible    timeout=${TIMEOUT_CURTO}

Editar produto existente
    [Documentation]    Seleciona um produto existente e altera seu preço
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Produtos
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
    ${produtos}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_produtos}=    Get Length    ${produtos}
    IF    ${qtd_produtos} == 0
        Skip    Nenhum produto encontrado para editar
    END
    ${indice}=    Evaluate    random.randint(0, ${qtd_produtos} - 1)    random
    ${produto}=    Set Variable    ${produtos}[${indice}]
    Click    ${produto}
    Wait For Elements State    text=Preços / Custos    visible    timeout=${TIMEOUT_CURTO}
    Click    text=Preços / Custos
    ${novo_preco}=    Evaluate    f"{random.randint(10, 500)},00"    random
    Fill Text    css=#precoPadrao    ${novo_preco}
    Click    text=Salvar
    Wait For Elements State    text=Produto atualizado    state=visible    timeout=${TIMEOUT_CURTO}

Validar campo obrigatório produto
    [Documentation]    Tenta salvar um produto sem preencher campos obrigatórios
    Click    text=Salvar
    Wait For Elements State    xpath=//*[contains(text(),'obrigatório') or contains(text(),'Obrigatório') or contains(text(),'required') or contains(@class,'error')]    visible    timeout=${TIMEOUT_CURTO}

Buscar produto por nome
    [Documentation]    Pesquisa um produto pelo nome no campo de busca
    [Arguments]    ${nome_busca}
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Produtos
    Wait For Elements State    css=input[placeholder="Pesquisar"]    visible    timeout=${TIMEOUT_CURTO}
    Fill Text    css=input[placeholder="Pesquisar"]    ${nome_busca}
    Sleep    1s
    ${resultados}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd}=    Get Length    ${resultados}
    Log To Console    Resultados encontrados para "${nome_busca}": ${qtd}
    RETURN    ${qtd}
