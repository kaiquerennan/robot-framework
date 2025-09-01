from robot.api.deco import keyword
import openai
import random
import re

class ChatGPTLibrary:
    def __init__(self, api_key=None, modo_teste=False):
        self.api_key = api_key
        self.modo_teste = modo_teste
        openai.api_key = api_key
        print(f"\n[INFO] Modo de execução: {'TESTE' if self.modo_teste else 'PRODUÇÃO'}")

    @keyword("ChatGPT")
    def chatgpt(self, mensagem):
        if self.modo_teste:
            print("[MODO TESTE ATIVO] Resposta simulada para: " + mensagem)
            msg = mensagem.lower()

            if "nome completo" in msg or "nome" in msg:
                return random.choice([
                    "João da Silva",
                    "Maria Oliveira",
                    "Carlos Henrique",
                    "Fernanda Lima",
                    "Rafael Souza"
                ])
            if "email" in msg:
                return random.choice([
                    "joao.silva@email.com",
                    "maria.oliveira@teste.com",
                    "carlos.henrique@exemplo.com"
                ])
            if "assunto" in msg:
                return random.choice([
                    "Problema de acesso ao sistema",
                    "Sugestão de melhoria no módulo financeiro",
                    "Dúvida sobre integração com ERP",
                    "Solicitação de suporte técnico"
                ])
            if "mensagem" in msg:
                return "Estou com dificuldade para gerar relatórios no módulo de vendas. Poderiam verificar?"

            return "Simulação ativa"

        try:
            response = openai.ChatCompletion.create(
                model="gpt-4o-mini",
                messages=[{"role": "user", "content": mensagem}]
            )
            return response['choices'][0]['message']['content'].strip()
        except Exception as e:
            raise ValueError(f"Erro ao chamar o ChatGPT: {str(e)}")
