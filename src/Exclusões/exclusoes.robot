*** Settings ***
Resource    exclusoes.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***
Excluir Vendas
    Abrir navegador
    Preencher Login
    Acessar Operações
    Excluir Vendas