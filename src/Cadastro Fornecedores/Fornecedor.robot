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
    Sleep    5s
    Close Browser
