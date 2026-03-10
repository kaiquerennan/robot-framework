*** Settings ***
Resource    venda.resource
Resource    ../Resources Genericos/generico.resource
Library    String

Test Teardown    Close Browser

*** Test Cases ***

# =============================================================================
#  FLUXO COMPLETO (happy path) — cada tipo de operação × com/sem cliente
# =============================================================================
Realizar venda sem cliente
    [Documentation]    Realiza uma venda direta sem selecionar cliente
    [Tags]    venda    sem_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Realizar Operação

Realizar venda com cliente
    [Documentation]    Realiza uma venda direta com um cliente selecionado
    [Tags]    venda    com_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

Realizar pre-venda sem cliente
    [Documentation]    Realiza uma pré-venda sem selecionar cliente
    [Tags]    pre_venda    sem_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de pré-venda
    Preencher vendedor
    Realizar Operação

Realizar pre-venda com cliente
    [Documentation]    Realiza uma pré-venda com um cliente selecionado
    [Tags]    pre_venda    com_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de pré-venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

Realizar pedido sem cliente
    [Documentation]    Realiza um pedido sem selecionar cliente
    [Tags]    pedido    sem_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de pedido
    Preencher vendedor
    Realizar Operação

Realizar pedido com cliente
    [Documentation]    Realiza um pedido com um cliente selecionado
    [Tags]    pedido    com_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de pedido
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

Realizar orçamento sem cliente
    [Documentation]    Realiza um orçamento sem selecionar cliente
    [Tags]    orcamento    sem_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de orçamento
    Preencher vendedor
    Realizar Operação

Realizar orçamento com cliente
    [Documentation]    Realiza um orçamento com um cliente selecionado
    [Tags]    orcamento    com_cliente    smoke
    Abrir navegador
    Preencher Login
    Acessar tela de orçamento
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}

# =============================================================================
#  CANCELAR OPERAÇÃO — Sair como rascunho antes de finalizar
# =============================================================================
Cancelar venda e salvar como rascunho
    [Documentation]    Inicia uma venda, adiciona produtos e cancela. O sistema deve
    ...                 salvar a operação com situação RASCUNHO.
    [Tags]    venda    rascunho    regra_negocio
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Escolher cliente
    Adicionar produtos ao carrinho
    Cancelar operacao como rascunho

Cancelar pre-venda e salvar como rascunho
    [Documentation]    Inicia uma pré-venda, adiciona produtos e cancela como rascunho.
    [Tags]    pre_venda    rascunho    regra_negocio
    Abrir navegador
    Preencher Login
    Acessar tela de pré-venda
    Preencher vendedor
    Adicionar produtos ao carrinho
    Cancelar operacao como rascunho

# =============================================================================
#  PAGAMENTO PARCIAL — tentar salvar pagando menos que o total
# =============================================================================
Tentar salvar venda com pagamento parcial
    [Documentation]    Adiciona produtos, chega na tela de pagamento e lança um valor menor
    ...                 que o total. O sistema não deve permitir salvar.
    [Tags]    venda    pagamento    regra_negocio    negativo
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Realizar Operação Ate Pagamento
    Lancar pagamento parcial
    Validar que botao salvar esta desabilitado

# =============================================================================
#  BUSCAR PRODUTO POR CÓDIGO — inserir direto no campo sem abrir sheet
# =============================================================================
Realizar venda buscando produto por codigo
    [Documentation]    Ao invés de abrir o sheet de busca, digita o código do produto
    ...                 direto no campo e confirma. Valida o fluxo alternativo de adição.
    [Tags]    venda    produto_codigo    regra_negocio
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Adicionar produto por codigo
    Realizar Operação Apos Produtos

# =============================================================================
#  VALIDAR VENDA NA LISTAGEM — após finalizar, a venda deve aparecer na lista
# =============================================================================
Validar venda finalizada aparece na listagem
    [Documentation]    Realiza uma venda completa e após finalizar, navega até a listagem
    ...                 de vendas para verificar que a venda aparece como FINALIZADA.
    [Tags]    venda    listagem    regra_negocio
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação    tem_cliente=${TRUE}
    Validar venda na listagem    FINALIZADA

# =============================================================================
#  VALIDAÇÕES NEGATIVAS — campos obrigatórios
# =============================================================================
Tentar salvar venda sem produtos
    [Documentation]    Verifica que não é possível finalizar uma venda sem adicionar produtos
    [Tags]    venda    validacao    negativo    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Tentar salvar venda sem produtos

Tentar salvar venda sem vendedor
    [Documentation]    Verifica que não é possível finalizar uma venda sem selecionar vendedor
    [Tags]    venda    validacao    negativo    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Tentar salvar venda sem vendedor

Tentar salvar pre-venda sem produtos
    [Documentation]    Verifica que não é possível finalizar uma pré-venda sem adicionar produtos
    [Tags]    pre_venda    validacao    negativo    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar tela de pré-venda
    Preencher vendedor
    Tentar salvar venda sem produtos

Tentar salvar pedido sem produtos
    [Documentation]    Verifica que não é possível finalizar um pedido sem adicionar produtos
    [Tags]    pedido    validacao    negativo    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar tela de pedido
    Preencher vendedor
    Tentar salvar venda sem produtos

Tentar salvar orçamento sem produtos
    [Documentation]    Verifica que não é possível finalizar um orçamento sem adicionar produtos
    [Tags]    orcamento    validacao    negativo    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar tela de orçamento
    Preencher vendedor
    Tentar salvar venda sem produtos

# =============================================================================
#  TENTAR SALVAR SEM FORMA DE PAGAMENTO
# =============================================================================
Tentar salvar venda sem forma de pagamento
    [Documentation]    Adiciona produtos, chega na tela de pagamento mas tenta salvar
    ...                 sem lançar nenhuma forma. O botão salvar deve estar desabilitado.
    [Tags]    venda    pagamento    negativo    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Preencher vendedor
    Realizar Operação Ate Pagamento
    Validar que botao salvar esta desabilitado