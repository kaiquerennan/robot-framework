*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    ../validacoes.robot/validacoes.resource
Resource    mudar_estoque.resource

Test Teardown    Close Browser

*** Test Cases ***
Mudar estoque
    [Documentation]    Altera o estoque de um produto aleatório
    [Tags]    estoque    alterar
    Abrir navegador
    Preencher Login
    Acessar tela de estoque
    Mudar estoque