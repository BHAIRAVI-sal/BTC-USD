@echo off
echo =========================================
echo Starting BTCUSD Forecasting API Service
echo =========================================
call venv_311\Scripts\activate.bat
uvicorn src.api:app --host 0.0.0.0 --port 8000
pause
