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

Excluir Parcerias de vendas    
    #isso exclui TODAS as parcerias de vendas
    Abrir navegador
    Preencher Login
    Click    text=Vendas
    Click    text=Parcerias de vendas
    Excluir Parcerias de vendas

Excluir Clientes
    #isso exclui TODOS os clientes
    Abrir navegador
    Preencher Login
    Click    text=Cadastros
    Click    text=Clientes
    Excluir Clientes