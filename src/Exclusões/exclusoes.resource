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