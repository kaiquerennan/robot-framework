*** Settings ***
Resource    ../Resources Genericos/variaveis.resource
Resource    ../validacoes.robot/validacoes.resource

*** Keywords ***

Mudar estoque
    ${produtos}=    Get Elements    xpath=//div[contains(@class,'gridRow')]
    ${qtd_produtos}=    Get Length    ${produtos}
    Log To Console    Quantidade encontrada: ${qtd_produtos}
    IF    ${qtd_produtos} == 0
        Skip    Nenhum produto no estoque para alterar
    END
    ${max_indice}=    Evaluate    min(6, ${qtd_produtos} - 1)
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${max_indice})    random
    ${produto_aleatorio}=    Set Variable    ${produtos}[${indice_aleatorio}]
    Log To Console    Produto: ${produto_aleatorio}
    ${codigo_produto}=    Get Text    ${produto_aleatorio} >> css=div.flex.justify-start.flex-1.px-1:first-child
    ${estoque_produto}=    Get Text    ${produto_aleatorio} >> css=div:nth-child(3)
    ${botao_opcoes}=    Get Element    ${produto_aleatorio} >> css=button[data-slot="button"]
    Click    ${botao_opcoes}
    Wait For Elements State    text=Alterar estoque    state=visible    timeout=${TIMEOUT_CURTO}
    Click    text=Alterar estoque
    Wait For Elements State    css=input    state=visible    timeout=${TIMEOUT_CURTO}
    Log To Console    Clicou no botão de opções do produto: ${codigo_produto}