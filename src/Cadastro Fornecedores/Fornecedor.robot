*** Settings ***
Resource    Fornecedor.resource
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/sidebar.resource

Test Teardown    Close Browser

*** Test Cases ***
Cadastrar Fornecedor
    [Documentation]    Realiza login e cadastra um novo fornecedor
    [Tags]    cadastro    fornecedor
    Abrir navegador
    Preencher Login
    Acessar cadastro de fornecedor
    Cadastrar fornecedor
    Click    text=Salvar >> visible=true


Editar Fornecedor existente
    [Documentation]    Realiza login, acessa lista de fornecedores e edita um existente
    [Tags]    edicao    fornecedor
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Fornecedores
    Editar fornecedor existente

Validar campos obrigatórios no cadastro de fornecedor
    [Documentation]    Tenta salvar um fornecedor vazio e verifica mensagem de erro
    [Tags]    validacao    fornecedor    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar cadastro de fornecedor
    Validar campo obrigatorio fornecedor
