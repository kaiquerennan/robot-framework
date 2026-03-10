*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/sidebar.resource
Resource    Produto.resource

Test Teardown    Close Browser

*** Test Cases ***
Cadastrar novo produto
    [Documentation]    Realiza login e cadastra um novo produto com preço
    [Tags]    cadastro    produto
    Abrir navegador
    Preencher Login
    Cadastrar Produtos

Editar produto existente
    [Documentation]    Realiza login, acessa lista de produtos e edita o preço de um
    [Tags]    edicao    produto
    Abrir navegador
    Preencher Login
    Editar produto existente

Validar campos obrigatórios no cadastro de produto
    [Documentation]    Tenta salvar um produto vazio e verifica mensagem de erro
    [Tags]    validacao    produto    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Produtos
    Click    text=Novo Produto
    Validar campo obrigatório produto

Buscar produto inexistente
    [Documentation]    Busca um produto que não existe e valida que nenhum resultado é retornado
    [Tags]    busca    produto
    Abrir navegador
    Preencher Login
    ${qtd}=    Buscar produto por nome    ZZZPRODUTOQUENOEXISTE999
    Should Be Equal As Integers    ${qtd}    0    Deveria retornar 0 resultados para busca inexistente
