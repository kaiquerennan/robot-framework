*** Settings ***
Resource    venda.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***

Acessar tela de venda
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher pré-venda
    Realizar Operação
    Sleep    5s