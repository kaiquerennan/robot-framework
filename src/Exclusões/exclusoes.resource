*** Settings ***
Resource    ../Resources Genericos/variaveis.resource

*** Keywords ***

Excluir Vendas
    Reload
    Wait For Elements State    xpath=//tr[contains(@class,'gridRow')]    state=attached    timeout=${TIMEOUT_CURTO}
    FOR    ${i}    IN RANGE    1    1000
        ${vendas}=    Get Elements    xpath=//tr[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))]
        ${qtd_vendas}=    Get Length    ${vendas}
        Log To Console    Quantidade de vendas encontrada: ${qtd_vendas}
        IF    ${qtd_vendas} == 0
            Log To Console    Todas vendas excluídas ou lista vazia!
            BREAK
        END
        ${indice}=    Evaluate    random.randint(1, ${qtd_vendas})    random
        Click    xpath=(//tr[contains(@class,'gridRow')])[${indice}]
        Wait For Elements State    text=Excluir    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Excluir
        Wait For Elements State    text="Sim, excluir"    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text="Sim, excluir"
        Sleep    1s
    END

Excluir Contas bancárias
    Set Browser Timeout    2s
    FOR    ${i}    IN RANGE    1    1000
        ${contas}=    Get Elements    xpath=//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))]
        ${qtd_contas}=    Get Length    ${contas}
        Log To Console    Quantidade de contas: ${qtd_contas}
        IF    ${qtd_contas} == 0
            Log To Console    Todas contas bancárias excluídas!
            BREAK
        END
        ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_contas} - 1)    random
        ${conta_aleatoria}=    Set Variable    ${contas}[${indice_aleatorio}]
        Click    ${conta_aleatoria}
        Wait For Elements State    text=Excluir    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Excluir
        Wait For Elements State    text=Continuar    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Continuar
        Sleep    1s
    END

Excluir Parcerias de vendas
    Set Browser Timeout    2s
    FOR    ${i}    IN RANGE    1    1000
        ${parcerias}=    Get Elements    xpath=//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))]
        ${qtd_parcerias}=    Get Length    ${parcerias}
        Log To Console    Quantidade de parcerias: ${qtd_parcerias}
        IF    ${qtd_parcerias} == 0
            Log To Console    Todas parcerias excluídas!
            BREAK
        END
        ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_parcerias} - 1)    random
        ${parceria_aleatoria}=    Set Variable    ${parcerias}[${indice_aleatorio}]
        Click    ${parceria_aleatoria}
        Wait For Elements State    text=Excluir    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Excluir
        Wait For Elements State    text=Continuar    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Continuar
        Sleep    1s
    END

Excluir Clientes
    Set Browser Timeout    2s
    FOR    ${i}    IN RANGE    1    1000
        ${clientes}=    Get Elements    xpath=//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))]
        ${qtd_clientes}=    Get Length    ${clientes}
        Log To Console    Quantidade de clientes: ${qtd_clientes}
        IF    ${qtd_clientes} == 0
            Log To Console    Todos clientes excluídos!
            BREAK
        END
        ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_clientes} - 1)    random
        ${cliente_aleatorio}=    Set Variable    ${clientes}[${indice_aleatorio}]
        Click    ${cliente_aleatorio}
        Wait For Elements State    text=Excluir    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Excluir
        Wait For Elements State    text=Continuar    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Continuar
        Sleep    0.5s
    END

Excluir Produtos
    Reload
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')]    state=attached    timeout=${TIMEOUT_CURTO}
    Set Browser Timeout    2s
    FOR    ${i}    IN RANGE    1    1000
        ${produtos}=    Get Elements    xpath=//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))]
        ${qtd_produtos}=    Get Length    ${produtos}
        Log To Console    Quantidade de produtos: ${qtd_produtos}
        IF    ${qtd_produtos} == 0
            Log To Console    Todos produtos excluídos!
            BREAK
        END
        ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_produtos} - 1)    random
        ${produto_aleatorio}=    Set Variable    ${produtos}[${indice_aleatorio}]
        Click    ${produto_aleatorio}
        Wait For Elements State    text=Excluir    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Excluir
        Wait For Elements State    text=Continuar    state=visible    timeout=${TIMEOUT_CURTO}
        Click    text=Continuar
        Sleep    0.5s
    END
