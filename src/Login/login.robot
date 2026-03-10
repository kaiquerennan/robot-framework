*** Settings ***
Resource    ../Resources Genericos/generico.resource
Resource    ../Resources Genericos/variaveis.resource

Test Teardown    Close Browser

*** Test Cases ***

Login com credenciais válidas
    [Documentation]    Verifica que o login é realizado com sucesso com credenciais válidas
    [Tags]    login    positivo
    Abrir navegador
    Preencher Login
    Wait For Elements State    xpath=//span[text()="Dashboard"]    visible    timeout=${TIMEOUT_PADRAO}

Login com senha incorreta
    [Documentation]    Verifica mensagem de erro ao tentar login com senha incorreta
    [Tags]    login    negativo
    Abrir navegador
    Fill Text    css=input[placeholder="Nome de usuário ou email"]    kaique
    Fill Text    css=input[placeholder="Sua senha"]    senhaerrada123
    Click    text=Entrar
    Wait For Elements State    xpath=//*[contains(text(),'inválid') or contains(text(),'Inválid') or contains(text(),'incorrect') or contains(@class,'error') or contains(@class,'alert')]    visible    timeout=${TIMEOUT_CURTO}

Login com usuário inexistente
    [Documentation]    Verifica mensagem de erro ao tentar login com usuário que não existe
    [Tags]    login    negativo
    Abrir navegador
    Fill Text    css=input[placeholder="Nome de usuário ou email"]    usuarioquenoexiste999
    Fill Text    css=input[placeholder="Sua senha"]    1234567
    Click    text=Entrar
    Wait For Elements State    xpath=//*[contains(text(),'inválid') or contains(text(),'Inválid') or contains(text(),'não encontr') or contains(@class,'error') or contains(@class,'alert')]    visible    timeout=${TIMEOUT_CURTO}

Login com campos vazios
    [Documentation]    Verifica que não permite login sem preencher campos
    [Tags]    login    negativo    campos_vazios
    Abrir navegador
    Click    text=Entrar
    # Deve permanecer na tela de login (não navegar para Dashboard)
    Wait For Elements State    css=input[placeholder="Nome de usuário ou email"]    visible    timeout=${TIMEOUT_CURTO}
    Wait For Elements State    xpath=//span[text()="Dashboard"]    detached    timeout=3s

Login com usuário restrito
    [Documentation]    Verifica que o login com usuário restrito funciona corretamente
    [Tags]    login    restrito
    Abrir navegador
    Logar com usuário restrito
    Wait For Elements State    xpath=//span[text()="Dashboard"]    visible    timeout=${TIMEOUT_PADRAO}
