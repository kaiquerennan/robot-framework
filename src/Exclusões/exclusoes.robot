*** Settings ***
Resource    exclusoes.resource
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/sidebar.resource

Suite Teardown    Close Browser

*** Test Cases ***
Excluir Vendas
    [Documentation]    Exclui TODAS as vendas do sistema
    [Tags]    exclusao    vendas
    Abrir navegador
    Preencher Login
    Acessar Operações
    Excluir Vendas
    [Teardown]    Close Browser

Excluir Contas bancárias
    [Documentation]    Exclui TODAS as contas bancárias do sistema
    [Tags]    exclusao    contas
    Abrir navegador
    Preencher Login
    Acessar Cadastros Financeiro
    Sleep    0.5s
    Click    text=Contas bancárias
    Excluir Contas bancárias
    [Teardown]    Close Browser

Excluir Parcerias de vendas
    [Documentation]    Exclui TODAS as parcerias de vendas do sistema
    [Tags]    exclusao    parcerias
    Abrir navegador
    Preencher Login
    Acessar Operações Comercial
    Sleep    0.5s
    Click    text=Vendas
    Click    text=Parcerias de vendas
    Excluir Parcerias de vendas
    [Teardown]    Close Browser

Excluir Clientes
    [Documentation]    Exclui TODOS os clientes do sistema
    [Tags]    exclusao    clientes
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Clientes
    Excluir Clientes
    [Teardown]    Close Browser

Excluir Produtos
    [Documentation]    Exclui TODOS os produtos do sistema
    [Tags]    exclusao    produtos
    Abrir navegador
    Preencher Login
    Acessar Cadastros Comercial
    Sleep    0.5s
    Click    text=Produtos
    Excluir Produtos
    [Teardown]    Close Browser