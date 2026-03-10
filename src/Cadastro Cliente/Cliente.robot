*** Settings ***
Resource    Cliente.resource
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/sidebar.resource

Test Teardown    Close Browser

*** Test Cases ***
Cadastrar novo cliente
    [Documentation]    Realiza login e cadastra um novo cliente (Física ou Jurídica)
    [Tags]    cadastro    cliente
    Abrir navegador
    Preencher Login
    Acessar cadastro de cliente
    Cadastrar cliente

Editar cliente existente
    [Documentation]    Realiza login, acessa lista de clientes e edita um existente
    [Tags]    edicao    cliente
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Clientes
    Editar cliente existente

Validar campos obrigatórios no cadastro de cliente
    [Documentation]    Tenta salvar um cliente vazio e verifica mensagem de erro
    [Tags]    validacao    cliente    campos_obrigatorios
    Abrir navegador
    Preencher Login
    Acessar cadastro de cliente
    Validar campo obrigatório cliente

Buscar cliente inexistente
    [Documentation]    Busca um nome que não existe e valida que nenhum resultado é retornado
    [Tags]    busca    cliente
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Clientes
    ${qtd}=    Buscar cliente por nome    ZZZNOMEQUENOEXISTE999
    Should Be Equal As Integers    ${qtd}    0    Deveria retornar 0 resultados para busca inexistente