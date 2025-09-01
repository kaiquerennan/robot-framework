*** Settings ***
Resource    Cliente.resource
Resource    ../Resources Genericos/generico.resource

*** Test Cases ***
Realizar login na aplicação e acessar cadastro de cliente
    Abrir navegador 
    Preencher Login
    Acessar cadastro de cliente
    Cadastrar cliente
    Sleep    5s
    Close Browser


