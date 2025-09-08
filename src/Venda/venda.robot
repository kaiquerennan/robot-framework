*** Settings ***
Resource    venda.resource
Resource    ../Resources Genericos/generico.resource
Library    String
Library    Dialogs
*** Test Cases ***


#vendas
Realizar venda sem cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher venda
    Preencher vendedor
    Realizar Operação

Realizar venda com cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação

#pre-vendas

Realizar pre-venda sem cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher pré-venda
    Preencher vendedor
    Realizar Operação

Realizar pre-venda com cliente
    Abrir navegador    
    Preencher Login
    Acessar tela de venda
    Escolher pré-venda
    Preencher vendedor
    Escolher cliente
    Realizar Operação

#pedidos


Realizar pedido sem cliente
    ${valor}=    Get Value From User    Digite um valor:
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher pedido
    Preencher vendedor
    Realizar Operação
    

Realizar pedido com cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher pedido
    Preencher vendedor
    Escolher cliente
    Realizar Operação

#orçamentos

Realizar orçamento sem cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher orçamento
    Preencher vendedor
    Realizar Operação

Realizar orçamento com cliente
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher orçamento
    Preencher vendedor
    Escolher cliente
    Realizar Operação


