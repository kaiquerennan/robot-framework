*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/sidebar.resource
Resource    Produto.resource

Test Teardown    Close Browser

*** Test Cases ***
Cadastrar novo produto
    [Documentation]    Realiza login e cadastra um novo produto com preco
    [Tags]    cadastro    produto
    Abrir navegador
    Preencher Login
    Cadastrar produto

Editar produto existente
    [Documentation]    Realiza login, acessa lista de produtos e edita o preco de um
    [Tags]    edicao    produto
    Abrir navegador
    Preencher Login
    Editar produto existente

Validar campos obrigatorios no cadastro de produto
    [Documentation]    Tenta salvar um produto vazio e verifica mensagem de erro
    [Tags]    validacao    produto    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar cadastro de produto
    Validar campo obrigatorio produto

Buscar produto inexistente
    [Documentation]    Busca um produto que nao existe e valida que nenhum resultado e retornado
    [Tags]    busca    produto
    Abrir navegador
    Preencher Login
    ${qtd}=    Buscar produto por nome    ZZZPRODUTOQUENOEXISTE999
    Should Be Equal As Integers    ${qtd}    0    Deveria retornar 0 resultados para busca inexistente
