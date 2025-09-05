*** Settings ***
Resource    exclusoes.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***
Excluir Vendas
    #isso exclui TODAS as vendas
    Abrir navegador
    Preencher Login
    Acessar Operações
    Excluir Vendas

Excluir Contas bancárias
    #isso exclui TODAS as contas bancárias
    Abrir navegador
    Preencher Login
    Click    text=Finanças
    Click    text=Contas bancárias
    Excluir Contas bancárias

