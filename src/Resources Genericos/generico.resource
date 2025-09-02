*** Settings ***
Library    Browser
Library    ../../libs/BuscarCepAleatorio.py
Library    ../../libs/GeradorDocumento.py
Library    ../../libs/ChatGPTLibrary.py    api_key=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    modo_teste=${MODO_TESTE}
*** Variables ***
${URL}    https://emc-frontend-hml.emcsistemas.com.br/login
${MODO_TESTE}    False
*** Keywords ***
Abrir navegador 
    New Browser    firefox    headless=False
    ${context}=    New Context    ignoreHTTPSErrors=True    viewport={'width': 1920, 'height': 1080}
    New Page    ${URL}   
Preencher Login
    Fill Text    css=input[placeholder="Nome de usuário ou email"]    kaique
    Fill Text    css=input[placeholder="Sua senha"]    1234567
    Click    text=Entrar

    
Preencher CEP    
    Click    text=Endereços
    Click    text=Adicionar >> visible=true
    ${endereço}    ChatGPT    Gere uma identificação simples para o endereço do fornecedor, com poucos caracteres. retorne só o nome, mais nada
    Fill Text    css=input[placeholder="Identificação"]    ${endereço}
    Fill Text    css=input[placeholder="CEP"]    35930162
    Sleep    2s
    ${numero}    Evaluate    random.randint(1, 999)    modules=random
    Sleep    1s
    Fill Text    css=#numero    ${numero}
    ${identificação}    Evaluate    random.randint(1, 2)    modules=random
    Click    css=#tipoEndereco 
    Click    xpath=(//div[@role="option"])[${identificação}]
    Click    xpath=//*[@id="radix-«r3e»"]/div/div[2]/div[2]/div[2]
    Click    text=Salvar >> visible=true
