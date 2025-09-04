*** Settings ***
Resource    venda.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***

Acessar tela de venda
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Sleep    5s