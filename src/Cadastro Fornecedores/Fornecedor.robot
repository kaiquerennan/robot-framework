*** Settings ***
Resource    Fornecedor.resource
Resource   ../Resources Genericos/generico.resource
Library    AppiumLibrary

*** Test Cases ***
Cadastrar Fornecedor
    Abrir navegador
    Preencher Login
    Acessar cadastro de fornecedor
    Cadastrar fornecedor
    Preencher CEP
    Cadastrar Telefone
    Click    text=Salvar >> visible=true
    Sleep    2s
    Close Browser
