*** Settings ***
Library    Browser
Library    Collections
Library    OperatingSystem
Library    AppiumLibrary
Library    BuiltIn

*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False

** Keywords ***
    
Excluir Vendas
    Reload
    Sleep    0.5s
    Set Browser Timeout    0.5s
    FOR    ${i}    IN RANGE    1    1000
    ${vendas}=    Get Elements    xpath=(//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))])    
    ${qtd_vendas}=    Get Length    ${vendas}
    Log To Console    quantidade de vendas: ${qtd_vendas}
        IF    ${qtd_vendas} == 0
            Exit For Loop
            Close Browser
        END
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_vendas} - 1)    random
    ${venda_aleatoria}=    Set Variable    ${vendas}[${indice_aleatorio}]
    Click    ${venda_aleatoria}
    Click    text=Excluir
    Sleep    0.3s
    Click    text=Sim, excluir
    Sleep    0.5s
    END
    Close Browser

Excluir Contas bancárias
    Set Browser Timeout    0.5s
    FOR    ${i}    IN RANGE    1    1000
    ${contas}=    Get Elements    xpath=(//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))])    
    ${qtd_contas}=    Get Length    ${contas}
    Log To Console    quantidade de contas: ${qtd_contas}
        IF    ${qtd_contas} == 0
            Exit For Loop
            Close Browser
        END
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_contas} - 1)    random
    ${venda_aleatoria}=    Set Variable    ${contas}[${indice_aleatorio}]
    Click    ${venda_aleatoria}
    Click    text=Excluir
    Sleep    0.3s
    Click    text=Continuar
    Sleep    1s
    END
    Close Browser



Excluir Parcerias de vendas
    Set Browser Timeout    0.5s
    FOR    ${i}    IN RANGE    1    1000
    ${parcerias}=    Get Elements    xpath=(//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))])    
    ${qtd_parcerias}=    Get Length    ${parcerias}
    Log To Console    quantidade de parcerias: ${qtd_parcerias}
        IF    ${qtd_parcerias} == 0
            Log to console     Todas parcerias excluídas!
            Exit For Loop
            Close Browser
        END
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_parcerias} - 1)    random
    ${parceria_aleatoria}=    Set Variable    ${parcerias}[${indice_aleatorio}]
    Click    ${parceria_aleatoria}
    Click    text=Excluir
    Sleep    0.3s
    Click    text=Continuar
    Sleep    1s
    END
    Close Browser

Excluir Clientes
    Set Browser Timeout    0.5s
    FOR    ${i}    IN RANGE    1    1000
    ${clientes}=    Get Elements    xpath=(//div[contains(@class,'gridRow') and not(contains(.,'Nenhum registro encontrado'))])    
    ${qtd_clientes}=    Get Length    ${clientes}
    Log To Console    quantidade de clientes: ${qtd_clientes}
        IF    ${qtd_clientes} == 0
            Exit For Loop
            Close Browser
        END
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${qtd_clientes} - 1)    random
    ${cliente_aleatorio}=    Set Variable    ${clientes}[${indice_aleatorio}]
    Click    ${cliente_aleatorio}
    Click    text=Excluir
    Sleep    0.3s
    Click    text=Sim, excluir
    Sleep    0.5s
    END
    Close Browser
