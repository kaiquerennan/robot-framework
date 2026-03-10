*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource
Library    Browser
Library    Collections


*** Keywords ***
Acessar tela de estoque
    Acessar Gestão de Estoque
    Sleep    0.5s
    Click    text=Estoque de produtos
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
    Reload
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}

Escolher algum produto
    ${produtos}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_produtos}=    Get Length    ${produtos}
    Log To Console    Quantidade encontrada: ${qtd_produtos}
    IF    ${qtd_produtos} == 0
        Skip    Nenhum produto encontrado no estoque
    END
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_produtos} - 1)    random
    ${produto_aleatorio}=    Set Variable    ${produtos}[${indice_aleatorio}]
    Log To Console    Produto: ${produto_aleatorio}
    ${codigo_produto}=    Get Text    ${produto_aleatorio} >> css=div.flex.justify-start.flex-1.px-1:first-child
    ${estoque_produto}=    Get Text    ${produto_aleatorio} >> css=div:nth-child(3)
    IF    int(${estoque_produto}) <= 0
        Skip    Produto sem estoque, pulando teste
    END
    Log To Console    Código: ${codigo_produto}
    Log To Console    Estoque: ${estoque_produto}
    Set Global Variable    ${PRODUTO_CODIGO}    ${codigo_produto}
    Set Global Variable    ${PRODUTO_ESTOQUE}    ${estoque_produto}
    Set Global Variable    ${PRODUTO}    ${produto_aleatorio}

Vender produto escolhido
    [Documentation]    Busca o produto pelo código e adiciona à venda
    # Digitar o código do produto no campo de busca
    Fill Text    css=[data-testid="input-codigo-produto"]    ${PRODUTO_CODIGO}
    Press Keys    css=[data-testid="input-codigo-produto"]    Enter
    Sleep    0.5s
    # Preencher quantidade
    ${quantidade}=    Evaluate    random.randint(1, 5)    random
    Log To Console    Quantidade vendida: ${quantidade}
    Fill Text    css=[data-testid="input-quantidade-produto"]    ${quantidade}
    # Confirmar o item
    Click    css=[data-testid="btn-confirmar-item-produto"]
    Sleep    0.3s
    # Finalizar a venda
    Click    text=Continuar
    Sleep    1s
    Set Global Variable    ${QUANTIDADE_VENDIDA}    ${quantidade}

Comparar estoque
    Acessar tela de estoque
    ${novo_estoque}=    Get Text    ${PRODUTO} >> css=div:nth-child(3)
    Log To Console    Estoque antigo: ${PRODUTO_ESTOQUE}
    Log To Console    Novo estoque: ${novo_estoque}
    ${estoque_esperado}=    Evaluate    int(${PRODUTO_ESTOQUE}) - int(${QUANTIDADE_VENDIDA})
    Should Be Equal As Integers    ${novo_estoque}    ${estoque_esperado}    Estoque não foi atualizado corretamente!

Validar botão Excluir desabilitado
    Reload
    Acessar Cadastros Comercial
    Sleep    0.5s
    FOR    ${i}    IN RANGE    1    9
        Click    xpath=(//nav//button[@data-slot='button'])[${i}]
        Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
        ${itens}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
        ${qtd_itens}=    Get Length    ${itens}
        Log To Console    Quantidade encontrada: ${qtd_itens}
        IF    ${qtd_itens} == 0    CONTINUE
        ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_itens} - 1)    random
        ${item_aleatorio}=    Set Variable    ${itens}[${indice_aleatorio}]
        Click    ${item_aleatorio}
        Wait For Elements State    xpath=//button[text()='Excluir']    visible    timeout=${TIMEOUT_CURTO}
        ${estado}=    Get Element States    xpath=//button[text()='Excluir']
        Should Contain    ${estado}    disabled
        Sleep    0.5s
    END

Validar botão Salvar desabilitado
    Reload
    Acessar Cadastros Comercial
    Sleep    0.5s
    FOR    ${i}    IN RANGE    1    9
        Click    xpath=(//nav//button[@data-slot='button'])[${i}]
        Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    attached    timeout=${TIMEOUT_CURTO}
        ${itens}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
        ${qtd_itens}=    Get Length    ${itens}
        Log To Console    Quantidade encontrada: ${qtd_itens}
        IF    ${qtd_itens} == 0    CONTINUE
        ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_itens} - 1)    random
        ${item_aleatorio}=    Set Variable    ${itens}[${indice_aleatorio}]
        Click    ${item_aleatorio}
        Wait For Elements State    xpath=//button[text()='Salvar']    visible    timeout=${TIMEOUT_CURTO}
        ${estado}=    Get Element States    xpath=//button[text()='Salvar']
        Should Contain    ${estado}    disabled
        Sleep    0.5s
    END

Validar botão Inserir desabilitado
    Reload
    Acessar Cadastros Comercial
    Sleep    0.5s
    FOR    ${i}    IN RANGE    1    9
        Click    xpath=(//nav//button[@data-slot='button'])[${i}]
        Wait For Elements State    text=Nov    visible    timeout=${TIMEOUT_CURTO}
        ${estado}=    Get Element States    text=Nov
        Should Contain    ${estado}    disabled
        Sleep    0.5s
    END
