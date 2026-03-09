@echo off
echo =========================================
echo Running BTCUSD Forecasting Model Training
echo =========================================
call venv_311\Scripts\activate.bat
python src\models\train.py
pause
