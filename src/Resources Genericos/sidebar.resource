*** Settings ***
Resource    variaveis.resource

*** Variables ***
# Seletores base da sidebar
${SIDEBAR_NAV}                      xpath=//nav[contains(@class,'sidebarMenu')]

*** Keywords ***

# =============================================================================
#  CATEGORIAS (expandir/colapsar grupos)
# =============================================================================

Expandir categoria da sidebar
    [Documentation]    Expande uma categoria da sidebar clicando no div pai do h3.
    ...    Se já estiver expandida (height: auto), não faz nada.
    ...    Categorias colapsadas possuem height: 0px no div de conteúdo.
    [Arguments]    ${nome_categoria}
    ${div_clicavel}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//h3[contains(text(),'${nome_categoria}')]/ancestor::div[contains(@class,'cursor-pointer')]
    Wait For Elements State    ${div_clicavel}    visible    timeout=${TIMEOUT_CURTO}
    # Verificar se o conteúdo está colapsado (div irmão com overflow e height: 0px)
    ${div_conteudo}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//h3[contains(text(),'${nome_categoria}')]/ancestor::div[contains(@class,'mb-2')]//div[contains(@style,'overflow')]
    ${style}=    Get Style    ${div_conteudo}    height
    IF    '${style}' == '0px'
        Click    ${div_clicavel}
        # Aguardar a animação de expansão
        Sleep    0.5s
    END

# =============================================================================
#  NAVEGAÇÃO — ITENS DA SIDEBAR (com desambiguação por categoria)
# =============================================================================

Clicar item na categoria
    [Documentation]    Clica em um item dentro de uma categoria específica da sidebar.
    ...    Resolve a ambiguidade de itens com mesmo nome (Cadastros, Operações, Relatórios)
    ...    buscando o botão dentro do bloco mb-2 que contém o h3 da categoria.
    [Arguments]    ${nome_categoria}    ${texto_item}
    Expandir categoria da sidebar    ${nome_categoria}
    ${seletor}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//h3[contains(text(),'${nome_categoria}')]/ancestor::div[contains(@class,'mb-2')]//button[@data-slot='button' and .//span[text()='${texto_item}']]
    Wait For Elements State    ${seletor}    visible    timeout=${TIMEOUT_CURTO}
    Click    ${seletor}

Clicar item unico da sidebar
    [Documentation]    Clica em um item da sidebar que possui nome único (Dashboard, Precificação, etc.)
    [Arguments]    ${texto_item}
    ${seletor}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[text()='${texto_item}']]
    Wait For Elements State    ${seletor}    visible    timeout=${TIMEOUT_CURTO}
    Click    ${seletor}

# =============================================================================
#  NAVEGAÇÕES COMPOSTAS (Categoria + Item)
# =============================================================================

# --- COMERCIAL ---

Acessar Cadastros Comercial
    [Documentation]    Comercial > Cadastros (Clientes, Fornecedores, etc.)
    Clicar item na categoria    Comercial    Cadastros

Acessar Operações Comercial
    [Documentation]    Comercial > Operações (Vendas, etc.)
    Clicar item na categoria    Comercial    Operações

Acessar Precificação
    [Documentation]    Comercial > Precificação
    Clicar item na categoria    Comercial    Precificação

Acessar Comissões
    [Documentation]    Comercial > Comissões
    Clicar item na categoria    Comercial    Comissões

Acessar Relatórios Comercial
    [Documentation]    Comercial > Relatórios
    Clicar item na categoria    Comercial    Relatórios

Acessar Etiquetas
    [Documentation]    Comercial > Etiquetas
    Clicar item na categoria    Comercial    Etiquetas

# --- ESTOQUE & LOGÍSTICA ---

Acessar Cadastros Estoque
    [Documentation]    Estoque & Logística > Cadastros
    Clicar item na categoria    Estoque    Cadastros

Acessar Gestão de Estoque
    [Documentation]    Estoque & Logística > Gestão de Estoque
    Clicar item na categoria    Estoque    Gestão de Estoque

Acessar Relatórios Estoque
    [Documentation]    Estoque & Logística > Relatórios
    Clicar item na categoria    Estoque    Relatórios

# --- FINANCEIRO ---

Acessar Cadastros Financeiro
    [Documentation]    Financeiro > Cadastros
    Clicar item na categoria    Financeiro    Cadastros

Acessar Caixa
    [Documentation]    Financeiro > Caixa
    Clicar item na categoria    Financeiro    Caixa

Acessar Operações Financeiro
    [Documentation]    Financeiro > Operações
    Clicar item na categoria    Financeiro    Operações

Acessar Relatórios Financeiro
    [Documentation]    Financeiro > Relatórios
    Clicar item na categoria    Financeiro    Relatórios

# --- ADMINISTRAÇÃO ---

Acessar Institucional
    [Documentation]    Administração > Institucional
    Clicar item na categoria    Administração    Institucional

Acessar Configurações Admin
    [Documentation]    Administração > Configurações
    Clicar item na categoria    Administração    Configurações

# --- FISCAL & TRIBUTOS ---

Acessar Configurações Fiscal
    [Documentation]    Fiscal & Tributos > Configurações
    Clicar item na categoria    Fiscal    Configurações

Acessar Obrigações
    [Documentation]    Fiscal & Tributos > Obrigações
    Clicar item na categoria    Fiscal    Obrigações

Acessar Ferramentas Fiscal
    [Documentation]    Fiscal & Tributos > Ferramentas
    Clicar item na categoria    Fiscal    Ferramentas

# --- INTEGRAÇÕES ---

Acessar Terceiros
    [Documentation]    Integrações > Terceiros
    Clicar item na categoria    Integrações    Terceiros

# --- DASHBOARD ---

Acessar Dashboard
    [Documentation]    Principal > Dashboard
    Clicar item unico da sidebar    Dashboard
