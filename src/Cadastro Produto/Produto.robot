*** Settings ***    
Resource    ../Resources Genericos/generico.resource
Resource    Produto.resource

*** Test Cases ***
Realizar login na aplicação e acessar cadastro de produto
    Abrir navegador
    Preencher Login
    Cadastrar Produtos
    Sleep    5s
    Close Browser
