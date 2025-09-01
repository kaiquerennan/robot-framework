import requests
from robot.api.deco import keyword
from robot.api import logger

class GeradorDocumento:

    @keyword("Gerar CPF Valido")
    def gerar_cpf_valido(self):
        try:
            response = requests.post(
                "https://www.4devs.com.br/ferramentas_online.php",
                data={"acao": "gerar_cpf", "pontuacao": "N"},
                timeout=10
            )
            response.raise_for_status()
            cpf = response.text.strip()
            logger.info(f"CPF gerado: {cpf}")
            return cpf
        except Exception as e:
            logger.error(f"Erro ao gerar CPF: {e}")
            raise

    @keyword("Gerar CNPJ Valido")
    def gerar_cnpj_valido(self):
        try:
            response = requests.post(
                "https://www.4devs.com.br/ferramentas_online.php",
                data={"acao": "gerar_cnpj", "pontuacao": "N"},
                timeout=10
            )
            response.raise_for_status()
            cnpj = response.text.strip()
            logger.info(f"CNPJ gerado: {cnpj}")
            return cnpj
        except Exception as e:
            logger.error(f"Erro ao gerar CNPJ: {e}")
            raise
