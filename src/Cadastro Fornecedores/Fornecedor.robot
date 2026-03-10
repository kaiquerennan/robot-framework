*** Settings ***
Resource    Fornecedor.resource
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/sidebar.resource

Test Teardown    Close Browser

*** Test Cases ***
Cadastrar Fornecedor
    [Documentation]    Realiza login e cadastra um novo fornecedor com CEP e telefone
    [Tags]    cadastro    fornecedor
    Abrir navegador
    Preencher Login
    Acessar cadastro de fornecedor
    Cadastrar fornecedor
    Preencher CEP
    Cadastrar Telefone
    Click    text=Salvar >> visible=true
    Wait For Elements State    text=Fornecedor cadastrado    state=visible    timeout=5s

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
    Validar campo obrigatório fornecedor
