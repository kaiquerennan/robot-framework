*** Settings ***
Library    Browser
Library    ../../libs/GeradorDocumento.py
Library    ../../libs/GeradorDados.py
Library    ../../libs/BuscarCepAleatorio.py
Library    Collections
Library    OperatingSystem
Library    BuiltIn
Library    String

*** Variables ***
${URL}                  https://homologacao.erpnova.com.br/login
${URL_DASHBOARD}        https://homologacao.erpnova.com.br/dashboard
${STATE_FILE}           ${CURDIR}/../Exclusões/state.json
${BROWSER}              chromium
${HEADLESS}             False
${TIMEOUT_PADRAO}       15s
${TIMEOUT_CURTO}        5s
