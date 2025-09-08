*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    validacoes.resource
Resource    ../Venda/venda.resource
Library    Browser


*** Test Cases ***

Validar se baixou estoque
    Abrir navegador
    Preencher Login
    Acessar tela de estoque
    Escolher algum produto
    Sleep    1.5s
    Acessar tela de venda
    Escolher venda
    Preencher vendedor
    Vender produto escolhido

    
    