import random
import requests
import logging
import time

class BuscarCepAleatorio:
    def __init__(self, max_tentativas=200):
        self.ceps_gerados = set()
        self.max_tentativas = max_tentativas
        logging.basicConfig(level=logging.INFO)

    def gerar_cep_valido(self):
        tentativas = 0
        while tentativas < self.max_tentativas:
            cep = "{:05d}{:03d}".format(random.randint(10000, 99999), random.randint(100, 999))
            
            if not self.cep_parece_invalido(cep) and cep not in self.ceps_gerados:
                if self.verificar_cep_com_viacep(cep):
                    self.ceps_gerados.add(cep)
                    logging.info(f"[OK] CEP válido gerado: {cep}")
                    return cep
                else:
                    logging.debug(f"[X] CEP {cep} não encontrado.")
            tentativas += 1

        raise Exception(f"Não foi possível encontrar um CEP válido após {self.max_tentativas} tentativas.")

    def verificar_cep_com_viacep(self, cep, retries=3):
        url = f"https://viacep.com.br/ws/{cep}/json/"
        for attempt in range(retries):
            try:
                response = requests.get(url, timeout=15)
                if response.status_code == 200:
                    data = response.json()
                    return not data.get("erro", False)
            except Exception as e:
                logging.warning(f"[ERRO] Tentativa {attempt+1} – erro ao consultar ViaCEP: {e}")
                time.sleep(1)
        return False

    def cep_parece_invalido(self, cep):
        return cep.startswith("00000") or cep.startswith("99999")
