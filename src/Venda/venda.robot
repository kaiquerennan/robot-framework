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

    
Realizar orcamento
    Abrir navegador
    Preencher Login
    Acessar tela de venda
    Escolher orçamento
    Preencher vendedor
    Realizar Operação



Excluir Vendas
    Abrir navegador
    Preencher Login
    Click         text=Vendas
    Click         text=Operações
    Sleep    1s
    Reload
    Sleep    1s
    FOR    ${i}    IN RANGE    1    1000
    ${vendas}=    Get Elements    xpath=(//div[contains(@class,'gridRow')])
    ${qtd_vendas}=    Get Length    ${vendas}
    Exit For Loop If    ${qtd_vendas} == 0
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_vendas} - 1)    random
    ${venda_aleatoria}=    Set Variable    ${vendas}[${indice_aleatorio}]
    Click    ${venda_aleatoria}
    Click    text=Excluir
    Sleep    0.3s
    Click    text=Sim, excluir
    Sleep    0.5s
    END
    Close Browser