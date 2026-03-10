*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/variaveis.resource
Resource    ../Resources Genericos/sidebar.resource

Test Teardown    Close Browser

*** Test Cases ***

Verificar categorias principais visíveis após login
    [Documentation]    Após login, verifica que as categorias da sidebar estão visíveis
    [Tags]    navegacao    dashboard
    Abrir navegador
    Preencher Login
    Wait For Elements State    xpath=//h3[contains(text(),'Comercial')]    visible    timeout=${TIMEOUT_CURTO}
    Wait For Elements State    xpath=//h3[contains(text(),'Administração')]    visible    timeout=${TIMEOUT_CURTO}
    Wait For Elements State    xpath=//h3[contains(text(),'Estoque')]    visible    timeout=${TIMEOUT_CURTO}

Acessar tela de Clientes via menu
    [Documentation]    Navega pelo menu até a tela de clientes e verifica que carregou
    [Tags]    navegacao    clientes
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Clientes
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')] | text=Nenhum registro    attached    timeout=${TIMEOUT_CURTO}

Acessar tela de Produtos via menu
    [Documentation]    Navega pelo menu até a tela de produtos e verifica que carregou
    [Tags]    navegacao    produtos
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Produtos
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')] | text=Nenhum registro    attached    timeout=${TIMEOUT_CURTO}

Acessar tela de Fornecedores via menu
    [Documentation]    Navega pelo menu até a tela de fornecedores e verifica que carregou
    [Tags]    navegacao    fornecedores
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Fornecedores
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')] | text=Nenhum registro    attached    timeout=${TIMEOUT_CURTO}

Acessar tela de Estoque via menu
    [Documentation]    Navega pelo menu até a tela de estoque e verifica que carregou
    [Tags]    navegacao    estoque
    Abrir navegador
    Preencher Login
    Acessar Gestão de Estoque
    Sleep    0.5s
    Click    text=Estoque de produtos
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')] | text=Nenhum registro    attached    timeout=${TIMEOUT_CURTO}

Acessar tela de Vendas via menu
    [Documentation]    Navega pelo menu até a tela de vendas e verifica que carregou
    [Tags]    navegacao    vendas
    Abrir navegador
    Preencher Login
    Acessar Operações Comercial
    Sleep    0.5s
    Click    text=Vendas
    Wait For Elements State    text=Nova Venda    visible    timeout=${TIMEOUT_CURTO}
