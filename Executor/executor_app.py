import subprocess, sys, threading, queue, time, os
import streamlit as st

st.set_page_config(page_title="Executor de Testes - Local", layout="wide")

st.title("Executor de Testes (esta máquina)")
cmd_default = r'pabot --processes 2 --outputdir Logs C:\Automacao\Suite_Testes_Automatizados\Emc'
cmd = st.text_input("Comando de execução (robot/pabot):", value=cmd_default)

col1, col2 = st.columns(2)
start = col1.button("Iniciar execução")
stop = col2.button("Parar")

placeholder = st.empty()
status = st.empty()

if "proc" not in st.session_state:
    st.session_state.proc = None
if "q" not in st.session_state:
    st.session_state.q = queue.Queue()

def reader_thread(p, q):
    for line in iter(p.stdout.readline, b''):
        q.put(line.decode(errors="ignore"))
    p.stdout.close()

if start and not st.session_state.proc:
    # Garante diretório de logs
    os.makedirs("Logs", exist_ok=True)
    # Inicia processo
    st.session_state.proc = subprocess.Popen(
        cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
    )
    t = threading.Thread(target=reader_thread, args=(st.session_state.proc, st.session_state.q), daemon=True)
    t.start()
    status.info("Executando…")

if stop and st.session_state.proc:
    st.session_state.proc.terminate()
    status.warning("Parando…")

# Stream ao vivo
if st.session_state.proc:
    # Atualiza saída em tempo real
    output_lines = []
    while True:
        try:
            line = st.session_state.q.get_nowait()
            output_lines.append(line.rstrip())
        except queue.Empty:
            break
    if output_lines:
        placeholder.text("\n".join(output_lines[-800:]))  # mantém últimas N linhas
    # Checa término
    ret = st.session_state.proc.poll()
    if ret is not None:
        status.success(f"Finalizado (exit={ret}). Veja arquivos em ./Logs")
        st.session_state.proc = None
        # Mostra resumo se existir
        if os.path.exists("Logs/output.xml"):
            st.info("output.xml gerado em ./Logs")
