@echo off
set PORT=8510
cd /d C:\Automacao\Executor
"C:\Users\sonara\AppData\Local\Programs\Python\Python313\python.exe" -m streamlit run executor_app.py ^
  --server.address localhost ^
  --server.port %PORT% ^
  --server.headless false
