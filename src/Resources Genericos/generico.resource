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
    ${dialog}=    Set Variable    xpath=(//div[contains(@class,'dialog') or @role='dialog'])[last()]
    Wait For Elements State    ${dialog}    visible    timeout=${TIMEOUT_CURTO}
    ${identificacao}=    Gerar Identificacao
    ${campos_texto}=    Get Elements    ${dialog} >> xpath=.//input[not(@disabled) and (@type='text' or not(@type))]
    ${qtd_campos_texto}=    Get Length    ${campos_texto}
    IF    ${qtd_campos_texto} < 2
        Fail    Campos insuficientes no modal de endereço para Identificação e CEP.
    END
    Fill Text    ${campos_texto}[0]    ${identificacao}
    Fill Text    ${campos_texto}[1]    35930180

    Wait For Elements State    ${dialog} >> css=#numero, input[name*="numero" i], input[id*="numero" i]    visible    timeout=${TIMEOUT_CURTO}
    ${numero}=    Evaluate    random.randint(1, 999)    modules=random
    Fill Text    ${dialog} >> css=#numero, input[name*="numero" i], input[id*="numero" i]    ${numero}
    ${tipo_endereço}=    Evaluate    random.randint(1, 2)    modules=random
    ${comboboxes}=    Get Elements    ${dialog} >> css=[role="combobox"]
    ${qtd_comboboxes}=    Get Length    ${comboboxes}
    IF    ${qtd_comboboxes} == 0
        Fail    Nenhum combobox de tipo de endereço encontrado no modal.
    END
    Click    ${comboboxes}[0]
    Click    xpath=(//div[@role="option"])[${tipo_endereço}]

Cadastrar Telefone
    Click    text=Telefones
    Click    text=Adicionar >> visible=true
    ${dialog}=    Set Variable    xpath=(//div[contains(@class,'dialog') or @role='dialog'])[last()]
    Wait For Elements State    ${dialog}    visible    timeout=${TIMEOUT_CURTO}
    ${comboboxes}=    Get Elements    ${dialog} >> css=[role="combobox"]
    ${qtd_comboboxes}=    Get Length    ${comboboxes}
    IF    ${qtd_comboboxes} < 2
        Fail    Comboboxes de tipo/DDD não encontrados no modal de telefone.
    END
    ${tipo_telefone}=    Evaluate    random.randint(1, 3)    modules=random
    Click    ${comboboxes}[0]
    Click    xpath=(//div[@role="option"])[${tipo_telefone}]
    ${identificacao}=    Gerar Identificacao
    ${inputs_texto}=    Get Elements    ${dialog} >> xpath=.//input[not(@disabled) and (@type='text' or not(@type))]
    ${qtd_inputs_texto}=    Get Length    ${inputs_texto}
    IF    ${qtd_inputs_texto} == 0
        Fail    Nenhum input de texto encontrado no modal de telefone.
    END
    Fill Text    ${inputs_texto}[0]    ${identificacao}
    ${numero_telefone}=    Gerar Telefone
    IF    ${qtd_inputs_texto} > 1
        Fill Text    ${inputs_texto}[1]    ${numero_telefone}
    ELSE
        ${campo_numero}=    Get Element    ${dialog} >> css=#numero, input[name*="numero" i], input[id*="numero" i]
        Fill Text    ${campo_numero}    ${numero_telefone}
    END
    Click    ${comboboxes}[1]
    Click    xpath=(//div[@role="option"])[2]

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