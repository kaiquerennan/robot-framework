*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    validacoes.resource
Resource    ../Venda/venda.resource
Library    Browser

Test Teardown    Close Browser

*** Test Cases ***

Validar se baixou estoque
    [Documentation]    Vende um produto e valida que o estoque foi decrementado corretamente
    [Tags]    validacao    estoque
    Abrir navegador
    Preencher Login
    Acessar tela de estoque
    Escolher algum produto
    Acessar tela de venda
    Preencher vendedor
    Vender produto escolhido
    Comparar estoque

Tentar excluir sem permissão
    [Documentation]    Valida que um usuário restrito não pode excluir registros
    [Tags]    validacao    permissao    excluir
    Abrir navegador
    Logar com usuário restrito
    Validar botão Excluir desabilitado

Tentar salvar sem permissão
    [Documentation]    Valida que um usuário restrito não pode salvar alterações
    [Tags]    validacao    permissao    salvar
    Abrir navegador
    Logar com usuário restrito
    Validar botão Salvar desabilitado

Tentar inserir sem permissão
    [Documentation]    Valida que um usuário restrito não pode inserir novos registros
    [Tags]    validacao    permissao    inserir
    Abrir navegador
    Logar com usuário restrito
    Validar botão Inserir desabilitado