*** Settings ***
Resource    venda.resource
Resource    ../Resources Genericos/generico.resource
Library    String

Test Teardown    Close Browser

*** Test Cases ***

# === VENDAS ===
Realizar venda sem cliente
    [Documentation]    Realiza uma venda direta sem selecionar cliente
    [Tags]    venda    sem_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Realizar Operação

Realizar venda com cliente
    [Documentation]    Realiza uma venda direta com um cliente selecionado
    [Tags]    venda    com_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

# === PRÉ-VENDAS ===
Realizar pre-venda sem cliente
    [Documentation]    Realiza uma pré-venda sem selecionar cliente
    [Tags]    pre_venda    sem_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de pré-venda
    Preencher vendedor
    Realizar Operação

Realizar pre-venda com cliente
    [Documentation]    Realiza uma pré-venda com um cliente selecionado
    [Tags]    pre_venda    com_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de pré-venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

# === PEDIDOS ===
Realizar pedido sem cliente
    [Documentation]    Realiza um pedido sem selecionar cliente
    [Tags]    pedido    sem_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de pedido
    Preencher vendedor
    Realizar Operação

Realizar pedido com cliente
    [Documentation]    Realiza um pedido com um cliente selecionado
    [Tags]    pedido    com_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de pedido
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

# === ORÇAMENTOS ===
Realizar orçamento sem cliente
    [Documentation]    Realiza um orçamento sem selecionar cliente
    [Tags]    orcamento    sem_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de orçamento
    Preencher vendedor
    Realizar Operação

Realizar orçamento com cliente
    [Documentation]    Realiza um orçamento com um cliente selecionado
    [Tags]    orcamento    com_cliente
    Abrir navegador
    Preencher Login
    Acessar tela de orçamento
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

# === VALIDAÇÕES NEGATIVAS ===
Tentar salvar venda sem produtos
    [Documentation]    Verifica que não é possível finalizar uma venda sem adicionar produtos
    [Tags]    venda    validacao    negativo
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Tentar salvar venda sem produtos

Tentar salvar venda sem vendedor
    [Documentation]    Verifica que não é possível finalizar uma venda sem selecionar vendedor
    [Tags]    venda    validacao    negativo
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Tentar salvar venda sem vendedor