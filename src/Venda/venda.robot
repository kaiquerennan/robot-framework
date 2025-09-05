*** Settings ***
Resource    venda.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***

Realizar venda
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher venda
    Preencher vendedor
    Realizar Operação


Realizar orçamento
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher pré-venda
    Preencher vendedor
    Realizar Operação


Realizar pedido
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher pedido
    Preencher vendedor
    Realizar Operação
   

Realizar orçamento
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher orçamento
    Preencher vendedor
    Realizar Operação
