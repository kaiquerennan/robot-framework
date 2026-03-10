*** Settings ***
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource

*** Keywords ***

# =============================================================================
#  NAVEGAÇÃO — Acessar cada tipo de operação via submenu da sidebar
# =============================================================================

Acessar tela de venda
    [Documentation]    Navega: Comercial > Operações > submenu "Documentos de Venda" > Vendas > Nova venda
    Acessar Operações Comercial
    Sleep    0.5s
    # Após clicar "Operações" a sidebar abre um submenu com categorias internas
    ${seletor_vendas}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[text()='Vendas']]
    Wait For Elements State    ${seletor_vendas}    visible    timeout=${TIMEOUT_CURTO}
    Click    ${seletor_vendas}
    Sleep    1s
    # Clica no botão "Nova venda" na listagem
    Click    xpath=//button[contains(text(),'Nova') and contains(text(),'enda')] | //a[contains(text(),'Nova') and contains(text(),'enda')] | //button[contains(text(),'Nova venda')] | //a[contains(text(),'Nova venda')]
    Wait For Elements State    css=[data-testid="input-codigo-produto"]    visible    timeout=${TIMEOUT_CURTO}

Acessar tela de pré-venda
    [Documentation]    Navega: Comercial > Operações > submenu "Documentos de Venda" > Pré-Vendas > Nova pré-venda
    Acessar Operações Comercial
    Sleep    0.5s
    ${seletor}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[contains(text(),'Vendas')]]
    Wait For Elements State    ${seletor}    visible    timeout=${TIMEOUT_CURTO}
    Click    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[contains(text(),'Pré-Vendas')]]
    Sleep    1s
    # Clica no botão "Nova pré-venda" na listagem
    Click    xpath=//button[contains(text(),'Nova')] | //a[contains(text(),'Nova')]
    Wait For Elements State    css=[data-testid="input-codigo-produto"]    visible    timeout=${TIMEOUT_CURTO}

Acessar tela de pedido
    [Documentation]    Navega: Comercial > Operações > submenu "Documentos de Venda" > Pedidos > Novo pedido
    Acessar Operações Comercial
    Sleep    0.5s
    ${seletor}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[text()='Pedidos']]
    Wait For Elements State    ${seletor}    visible    timeout=${TIMEOUT_CURTO}
    Click    ${seletor}
    Sleep    1s
    # Clica no botão "Novo pedido" na listagem
    Click    xpath=//button[contains(text(),'Nov')] | //a[contains(text(),'Nov')]
    Wait For Elements State    css=[data-testid="input-codigo-produto"]    visible    timeout=${TIMEOUT_CURTO}

Acessar tela de orçamento
    [Documentation]    Navega: Comercial > Operações > submenu "Documentos de Venda" > Orçamentos > Novo orçamento
    Acessar Operações Comercial
    Sleep    0.5s
    ${seletor}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[contains(text(),'amentos')]]
    Wait For Elements State    ${seletor}    visible    timeout=${TIMEOUT_CURTO}
    Click    ${seletor}
    Sleep    1s
    # Clica no botão "Novo orçamento" na listagem
    Click    xpath=//button[contains(text(),'Nov')] | //a[contains(text(),'Nov')]
    Wait For Elements State    css=[data-testid="input-codigo-produto"]    visible    timeout=${TIMEOUT_CURTO}

# =============================================================================
#  PREENCHIMENTO DO FORMULÁRIO DE VENDA
# =============================================================================

Preencher vendedor
    [Documentation]    Preenche o campo de vendedor pelo código
    Wait For Elements State    css=#codVendedor    visible    timeout=${TIMEOUT_CURTO}
    Fill Text    css=#codVendedor    3
    Press Keys    css=#codVendedor    Tab
    Sleep    0.5s

Escolher cliente
    [Documentation]    Busca e seleciona um cliente clicando no ícone de mouse-pointer-click do registro
    # Clica no ícone de busca do campo cliente para abrir o popup de seleção
    Click    css=#codCliente ~ div .lucide-search
    Sleep    1s
    # Cada registro (div.gridRow) tem um botão com ícone lucide-mouse-pointer-click na última coluna
    ${botoes_selecionar}=    Get Elements    css=.gridListSearch .gridRow button .lucide-mouse-pointer-click
    ${qtd}=    Get Length    ${botoes_selecionar}
    Log To Console    Botões de selecionar cliente: ${qtd}
    IF    ${qtd} == 0
        Fail    Nenhum botão de seleção de cliente encontrado!
    END
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd} - 1)    random
    Log To Console    Selecionando cliente no índice: ${indice_aleatorio}
    Click    ${botoes_selecionar}[${indice_aleatorio}]
    Sleep    0.5s

Adicionar produto
    [Documentation]    Adiciona um produto à venda evitando repetir produtos já selecionados.
    ...                 Navega entre páginas do sheet de busca se necessário.
    [Arguments]    ${indices_usados}=@{EMPTY}    ${pagina_atual}=1
    # Abre o sheet de busca de produtos
    Click    css=[data-testid="input-codigo-produto"] ~ div .lucide-search
    Sleep    0.8s
    # Se não estamos na página 1, navega até a página correta
    IF    ${pagina_atual} > 1
        FOR    ${p}    IN RANGE    1    ${pagina_atual}
            Avançar pagina produtos
        END
    END
    # Busca botões de seleção disponíveis na página atual do sheet
    ${botoes_produto}=    Obter botoes produto disponiveis
    ${qtd_produtos}=    Get Length    ${botoes_produto}
    Log To Console    Produtos disponíveis na página ${pagina_atual}: ${qtd_produtos}
    IF    ${qtd_produtos} == 0
        Press Keys    None    Escape
        RETURN    ${FALSE}    ${indices_usados}    ${pagina_atual}
    END
    # Monta lista de índices disponíveis (exclui os já usados nesta página)
    ${indices_disponiveis}=    Create List
    FOR    ${i}    IN RANGE    0    ${qtd_produtos}
        ${chave}=    Set Variable    p${pagina_atual}_${i}
        ${ja_usado}=    Evaluate    "${chave}" in ${indices_usados}
        IF    not ${ja_usado}
            Append To List    ${indices_disponiveis}    ${i}
        END
    END
    ${qtd_disponiveis}=    Get Length    ${indices_disponiveis}
    Log To Console    Produtos ainda não usados na página ${pagina_atual}: ${qtd_disponiveis}
    # Se acabaram os produtos desta página, tenta ir para a próxima
    IF    ${qtd_disponiveis} == 0
        ${tem_proxima}=    Tem proxima pagina
        IF    ${tem_proxima}
            Log To Console    Avançando para próxima página de produtos
            Avançar pagina produtos
            ${nova_pagina}=    Evaluate    ${pagina_atual} + 1
            # Fecha o sheet atual e reabre na próxima página via recursão
            Press Keys    None    Escape
            Sleep    0.3s
            ${result}    ${indices_usados}    ${pagina_atual}=    Adicionar produto    ${indices_usados}    ${nova_pagina}
            RETURN    ${result}    ${indices_usados}    ${pagina_atual}
        ELSE
            Log To Console    Sem mais páginas de produtos disponíveis
            Press Keys    None    Escape
            RETURN    ${FALSE}    ${indices_usados}    ${pagina_atual}
        END
    END
    # Escolhe um índice aleatório dentre os disponíveis
    ${rand}=    Evaluate    random.randint(0, ${qtd_disponiveis} - 1)    random
    ${indice}=    Get From List    ${indices_disponiveis}    ${rand}
    ${chave}=    Set Variable    p${pagina_atual}_${indice}
    Append To List    ${indices_usados}    ${chave}
    Log To Console    Selecionando produto índice ${indice} (página ${pagina_atual})
    Click    ${botoes_produto}[${indice}]
    Sleep    0.3s
    # Preenche quantidade
    ${quantidade}=    Evaluate    random.randint(1, 3)    random
    Log To Console    Quantidade: ${quantidade}
    ${tem_input_qtd}=    Run Keyword And Return Status
    ...    Get Element    css=[data-testid="input-quantidade-produto"]
    IF    ${tem_input_qtd}
        Fill Text    css=[data-testid="input-quantidade-produto"]    ${quantidade}
    ELSE
        Fill Text    css=input[placeholder="1"][type="text"], input[name*="qtd"], input[name*="quantidade"]    ${quantidade}
    END
    # Confirmar o item — botão azul "+"
    Click    css=[data-testid="btn-confirmar-item-produto"]
    Sleep    0.3s
    RETURN    ${TRUE}    ${indices_usados}    ${pagina_atual}

Obter botoes produto disponiveis
    [Documentation]    Retorna os botões de selecionar produto disponíveis no sheet de busca.
    # Tenta primeiro no sheet/dialog de busca, depois fallback para grid inline
    ${botoes}=    Get Elements    css=.saleProdListProd .gridRow:not(.cursor-not-allowed) button:not([disabled]) .lucide-mouse-pointer-click
    ${qtd}=    Get Length    ${botoes}
    IF    ${qtd} > 0
        RETURN    ${botoes}
    END
    # Fallback: tenta seletores genéricos do sheet de busca de produtos
    ${botoes}=    Get Elements    css=.gridRow:not(.cursor-not-allowed) button:not([disabled]) .lucide-mouse-pointer-click
    RETURN    ${botoes}

Tem proxima pagina
    [Documentation]    Verifica se existe próxima página no sheet de produtos.
    # O SVG da seta direita (próxima página) tem o path "M8.59 16.59"
    # Se o container pai tem disabled ou pointer-events-none, não há próxima
    ${seta_direita}=    Get Elements    xpath=//div[contains(@class,'btn-icon')][.//svg[./path[contains(@d,'M8.59 16.59')]]]
    ${qtd}=    Get Length    ${seta_direita}
    IF    ${qtd} == 0
        RETURN    ${FALSE}
    END
    # Verifica se o botão não está desabilitado
    ${classes}=    Get Attribute    ${seta_direita}[0]    class
    ${desabilitado}=    Evaluate    'disabled' in """${classes}""" or 'pointer-events-none' in """${classes}"""
    RETURN    ${${desabilitado} == False}

Avançar pagina produtos
    [Documentation]    Clica na seta direita para ir à próxima página de produtos.
    # O SVG da seta "próxima página" tem path com d="M8.59 16.59..."
    Click    xpath=//div[contains(@class,'btn-icon')][.//svg[./path[contains(@d,'M8.59 16.59')]]]
    Sleep    0.5s

Realizar Operação
    [Documentation]    Adiciona produtos, passa pelos ajustes finais e finaliza com forma de pagamento
    [Arguments]    ${tem_cliente}=${FALSE}
    # === ETAPA 1: Adicionar produtos ===
    ${numero}=    Evaluate    random.randint(2, 3)    random
    Log To Console    Quantidade de produtos a adicionar: ${numero}
    ${indices_usados}=    Create List
    ${pagina_atual}=    Set Variable    1
    FOR    ${i}    IN RANGE    1    ${numero}+1
        ${adicionou}    ${indices_usados}    ${pagina_atual}=    Adicionar produto    ${indices_usados}    ${pagina_atual}
        IF    not ${adicionou}
            Log To Console    Sem mais produtos disponíveis, finalizando adição de itens
            BREAK
        END
    END
    # === ETAPA 2: Clicar em Continuar → Ajustes finais ===
    Click    text=Continuar
    Sleep    1s
    # Aguarda a tela de "Ajustes finais" aparecer
    Wait For Elements State    xpath=//*[contains(text(),'Ajustes finais')]    visible    timeout=${TIMEOUT_CURTO}
    Log To Console    Tela de ajustes finais aberta
    # === ETAPA 3: Clicar em Continuar → Forma de pagamento ===
    Click    css=[data-testid="btn-movcaixa-salvar"]
    Sleep    1s
    # Aguarda o dropdown de forma de pagamento aparecer
    Wait For Elements State    css=#fmpagto    visible    timeout=${TIMEOUT_CURTO}
    Log To Console    Tela de forma de pagamento aberta
    # === ETAPA 4: Selecionar forma de pagamento ===
    Selecionar forma de pagamento
    # === ETAPA 5: Salvar ===
    Wait For Elements State    css=[data-testid="btn-salvar"]:not([disabled])    visible    timeout=${TIMEOUT_CURTO}
    Click    css=[data-testid="btn-salvar"]
    Sleep    1s
    # === ETAPA 6: Confirmar emissão de NF-e ===
    Confirmar emissao    ${tem_cliente}
    Log To Console    Operação finalizada com sucesso

Confirmar emissao
    [Documentation]    Trata o modal de confirmação de emissão de NF-e.
    ...                 Com cliente: clica em "Emitir agora"
    ...                 Sem cliente: clica em "Pendente de emissão"
    [Arguments]    ${tem_cliente}=${FALSE}
    # Aguarda o modal de confirmação aparecer
    ${modal_aberto}=    Run Keyword And Return Status
    ...    Wait For Elements State    xpath=//*[contains(text(),'Você tem certeza disso')]    visible    timeout=5s
    IF    not ${modal_aberto}
        Log To Console    Modal de confirmação de emissão não apareceu, seguindo...
        RETURN
    END
    Log To Console    Modal de confirmação de emissão detectado
    IF    ${tem_cliente}
        Log To Console    Com cliente — clicando em "Emitir agora"
        Click    xpath=//button[contains(text(),'Emitir agora')]
    ELSE
        Log To Console    Sem cliente — clicando em "Pendente de emissão"
        Click    xpath=//button[contains(text(),'Pendente de emiss')]
    END
    Sleep    1s

Selecionar forma de pagamento
    [Documentation]    Abre o dropdown de forma de pagamento, seleciona a primeira opção e confirma com o botão +
    # Clica no dropdown de forma de pagamento
    Click    css=#fmpagto
    Sleep    0.5s
    # Seleciona a primeira opção disponível no dropdown
    ${opcoes}=    Get Elements    css=[role="option"]
    ${qtd_opcoes}=    Get Length    ${opcoes}
    Log To Console    Formas de pagamento disponíveis: ${qtd_opcoes}
    IF    ${qtd_opcoes} == 0
        Fail    Nenhuma forma de pagamento disponível!
    END
    Click    ${opcoes}[0]
    Sleep    0.3s
    # O valor já vem preenchido automaticamente com o total da venda
    # Clica no botão "+" para confirmar o lançamento da forma de pagamento
    Click    css=[data-testid="btn-confirmar-forma-pagto"]
    Sleep    0.5s
    # Verifica se abriu o sheet de conta bancária (algumas formas exigem selecionar conta)
    Tratar sheet conta bancaria
    Log To Console    Forma de pagamento lançada

Tratar sheet conta bancaria
    [Documentation]    Se o sheet de conta bancária abrir, seleciona a primeira conta e salva.
    ${sheet_aberto}=    Run Keyword And Return Status
    ...    Wait For Elements State    css=[data-testid="btn-movbanco-salvar"]    visible    timeout=1s
    IF    not ${sheet_aberto}
        Log To Console    Sheet de conta bancária não apareceu, seguindo...
        RETURN
    END
    Log To Console    Sheet de conta bancária detectado, selecionando primeira conta
    # Clica no primeiro checkbox para selecionar a primeira conta bancária
    ${checkboxes}=    Get Elements    css=.pageContentSheet .gridRow button[role="checkbox"]
    ${qtd}=    Get Length    ${checkboxes}
    IF    ${qtd} == 0
        Fail    Nenhuma conta bancária disponível!
    END
    Click    ${checkboxes}[0]
    Sleep    0.3s
    # Aguarda o botão Salvar habilitar e clica
    Wait For Elements State    css=[data-testid="btn-movbanco-salvar"]:not([disabled])    visible    timeout=${TIMEOUT_CURTO}
    Click    css=[data-testid="btn-movbanco-salvar"]
    Sleep    0.5s
    Log To Console    Conta bancária selecionada e salva

# =============================================================================
#  VALIDAÇÕES NEGATIVAS
# =============================================================================

Tentar salvar venda sem produtos
    [Documentation]    Tenta finalizar uma venda sem adicionar nenhum produto
    Click    text=Continuar
    Wait For Elements State    xpath=//*[contains(text(),'produto') or contains(text(),'Produto') or contains(text(),'item') or contains(@class,'error') or contains(@class,'alert')]    visible    timeout=${TIMEOUT_CURTO}

Tentar salvar venda sem vendedor
    [Documentation]    Tenta finalizar uma venda sem selecionar vendedor
    # Limpa o campo vendedor
    Fill Text    css=#codVendedor    ${EMPTY}
    # Adiciona um produto primeiro
    ${indices}=    Create List
    ${adicionou}    ${indices}    ${pg}=    Adicionar produto    ${indices}
    IF    not ${adicionou}
        Skip    Nenhum produto disponível para o teste
    END
    Click    text=Continuar
    Wait For Elements State    xpath=//*[contains(text(),'vendedor') or contains(text(),'Vendedor') or contains(@class,'error') or contains(@class,'alert')]    visible    timeout=${TIMEOUT_CURTO}
