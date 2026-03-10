from robot.api.deco import keyword
from faker import Faker
import random

fake = Faker('pt_BR')


class GeradorDados:
    """Biblioteca Robot Framework para geração de dados falsos usando Faker (pt-BR).
    Substitui completamente a dependência do ChatGPT para geração de nomes, emails, etc."""

    @keyword("Gerar Nome Pessoa")
    def gerar_nome_pessoa(self):
        """Retorna um nome brasileiro aleatório (primeiro nome)."""
        return fake.first_name()

    @keyword("Gerar Nome Completo")
    def gerar_nome_completo(self):
        """Retorna um nome completo brasileiro aleatório."""
        return fake.name()

    @keyword("Gerar Nome Empresa")
    def gerar_nome_empresa(self):
        """Retorna um nome de empresa brasileiro aleatório."""
        return fake.company()

    @keyword("Gerar Email")
    def gerar_email(self):
        """Retorna um email aleatório."""
        return fake.email()

    @keyword("Gerar Email Para Nome")
    def gerar_email_para_nome(self, nome):
        """Retorna um email baseado em um nome fornecido."""
        nome_limpo = nome.lower().replace(" ", ".").strip()
        dominio = random.choice(["email.com", "teste.com", "exemplo.com.br", "mail.com"])
        return f"{nome_limpo}@{dominio}"

    @keyword("Gerar Telefone")
    def gerar_telefone(self):
        """Retorna um número de telefone brasileiro aleatório (sem DDD)."""
        prefixo = random.choice(["9", "8", "7"])
        numero = ''.join([str(random.randint(0, 9)) for _ in range(8)])
        return f"{prefixo}{numero}"

    @keyword("Gerar Identificacao")
    def gerar_identificacao(self):
        """Retorna uma identificação curta aleatória (ex: Casa, Trabalho, Principal)."""
        opcoes = ["Casa", "Trabalho", "Principal", "Comercial", "Pessoal", "Matriz", "Filial"]
        return random.choice(opcoes)

    @keyword("Gerar Nome Produto")
    def gerar_nome_produto(self):
        """Retorna um nome de produto aleatório."""
        produtos = [
            "Caderno", "Caneta", "Mochila", "Teclado", "Mouse",
            "Monitor", "Camiseta", "Tênis", "Relógio", "Fone",
            "Notebook", "Tablet", "Carregador", "Câmera", "Garrafa",
            "Luminária", "Cadeira", "Mesa", "Impressora", "Pendrive"
        ]
        return random.choice(produtos)

    @keyword("Gerar Nome Fornecedor")
    def gerar_nome_fornecedor(self):
        """Retorna um nome de fornecedor brasileiro aleatório."""
        return fake.company()

    @keyword("Gerar Assunto")
    def gerar_assunto(self):
        """Retorna um assunto fictício para tickets/chamados."""
        assuntos = [
            "Problema de acesso ao sistema",
            "Sugestão de melhoria no módulo financeiro",
            "Dúvida sobre integração com ERP",
            "Solicitação de suporte técnico"
        ]
        return random.choice(assuntos)

    @keyword("Gerar Mensagem")
    def gerar_mensagem(self):
        """Retorna uma mensagem fictícia."""
        return fake.sentence(nb_words=12)
