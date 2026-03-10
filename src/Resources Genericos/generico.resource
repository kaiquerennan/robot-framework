*** Settings ***
Resource    variaveis.resource
Resource    sidebar.resource

*** Keywords ***
Abrir navegador
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    ignoreHTTPSErrors=True    viewport={'width': 1366, 'height': 768}
    New Page    ${URL}

Abrir navegador com sessão salva
    [Documentation]    Abre o navegador já logado usando a sessão salva em state.json
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    ignoreHTTPSErrors=True    viewport={'width': 1920, 'height': 1080}    storageState=${STATE_FILE}
    New Page    ${URL_DASHBOARD}
    Wait For Elements State    xpath=//span[text()="Dashboard"]    visible    timeout=${TIMEOUT_PADRAO}

Preencher Login
    Fill Text    css=input[placeholder="Nome de usuário ou email"]    kaique
    Fill Text    css=input[placeholder="Sua senha"]    1234567
    Click    text=Entrar
    Selecionar Loja
    Wait For Elements State    xpath=//span[text()="Dashboard"]    visible    timeout=${TIMEOUT_PADRAO}

Selecionar Loja
    [Documentation]    Após o login, recarrega a página para ativar a sessão da loja.
    Sleep    1s
    Reload
    Wait For Elements State    xpath=//span[text()="Dashboard"]    visible    timeout=${TIMEOUT_PADRAO}

Fechar navegador
    [Documentation]    Keyword padrão para fechar o browser de forma segura
    Close Browser

Preencher CEP
    Click    text=Endereços
    Click    text=Adicionar >> visible=true
    ${identificacao}=    Gerar Identificacao
    Fill Text    css=input[placeholder="Identificação"]    ${identificacao}
    Fill Text    css=input[placeholder="CEP"]    35930162
    Wait For Elements State    css=#numero    visible    timeout=${TIMEOUT_CURTO}
    ${numero}=    Evaluate    random.randint(1, 999)    modules=random
    Fill Text    css=#numero    ${numero}
    ${tipo_endereço}=    Evaluate    random.randint(1, 2)    modules=random
    Click    css=#tipoEndereco
    Click    xpath=(//div[@role="option"])[${tipo_endereço}]
    # Usar seletor genérico em vez de radix ID dinâmico
    Click    xpath=(//div[contains(@class,'dialog') or @role='dialog']//button[contains(text(),'Salvar') or contains(text(),'Confirmar')])[last()]

Cadastrar Telefone
    Click    text=Telefones
    Click    text=Adicionar >> visible=true
    ${tipo_telefone}=    Evaluate    random.randint(1, 3)    modules=random
    Click    css=#tipoTelefone
    Click    xpath=(//div[@role="option"])[${tipo_telefone}]
    ${identificacao}=    Gerar Identificacao
    Fill Text    css=input[placeholder="Identificação"]    ${identificacao}
    ${numero_telefone}=    Gerar Telefone
    Fill Text    css=input[placeholder="Número"]    ${numero_telefone}
    Click    css=#ddd
    Click    xpath=(//div[@role="option"])[2]
    # Usar seletor genérico em vez de radix ID dinâmico
    Click    xpath=(//div[contains(@class,'dialog') or @role='dialog']//button[contains(text(),'Salvar') or contains(text(),'Confirmar')])[last()]

Acessar Operações
    [Documentation]    Acessa a lista de vendas via Comercial > Operações > Vendas
    Acessar Operações Comercial
    Sleep    0.5s
    ${seletor_vendas}=    Set Variable    xpath=//nav[contains(@class,'sidebarMenu')]//button[@data-slot='button' and .//span[text()='Vendas']]
    Wait For Elements State    ${seletor_vendas}    visible    timeout=${TIMEOUT_CURTO}
    Click    ${seletor_vendas}
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')] | xpath=//div[contains(@class,'gridSale')]    attached    timeout=${TIMEOUT_CURTO}
    Reload
    Wait For Elements State    xpath=//div[contains(@class,'gridRow')] | xpath=//div[contains(@class,'gridSale')]    attached    timeout=${TIMEOUT_CURTO}

Logar com usuário restrito
    Fill Text    css=input[placeholder="Nome de usuário ou email"]    kaiqueteste
    Fill Text    css=input[placeholder="Sua senha"]    123456
    Click    text=Entrar
    Selecionar Loja
    Wait For Elements State    xpath=//span[text()="Dashboard"]    visible    timeout=${TIMEOUT_PADRAO}