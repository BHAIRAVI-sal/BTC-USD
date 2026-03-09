@echo off
echo ===================================================
echo Starting Hourly Automation ^& Daily Retraining Scheduler
echo ===================================================
call venv_311\Scripts\activate.bat
python scheduler.py
pause
