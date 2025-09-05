*** Settings ***
Resource    exclusoes.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***
Excluir Vendas
    Abrir navegador
    Preencher Login
    Acessar Operações
    Excluir Vendas

Excluir Contas bancárias
    Abrir navegador
    Preencher Login
    Click    text=Finanças
    Click    text=Contas bancárias
    Excluir Contas bancárias