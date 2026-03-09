# BTCUSD Hourly Forecasting Engine

## Project Overview
A production-grade, backend-focused machine learning system to forecast the next-hour closing price of BTCUSD. The system automatically fetches live market data, calculates advanced technical features, evaluates multiple predictive models, tracks experiments, and exposes predictions through a lightweight API.

## System Architecture Pipeline
The system operates seamlessly in a purely backend-focused architecture utilizing the following flow:

**Data Fetching → Feature Engineering → Model Prediction → Ensemble → FastAPI → Logging → Monitoring**

## 🧠 Machine Learning Lifecycle
This project implements a complete production-style ML lifecycle:
- **Data Ingestion**: Automated fetching of hourly BTC-USD data via `yfinance`.
- **Feature Engineering**: Advanced technical indicators (RSI, MACD, BB, ATR) and lag features.
- **Data Normalization**: All input features are standardized and the **target price is scaled**; scalers are saved and re‑used during inference.
- **Data Validation**: Pre-processing checks for data quality, outliers, and continuity.
- **Time-Series Modeling**: Ensemble of Linear Regression, ARIMA, and LSTM models.
- **MLOps Tracking**: Full experiment tracking and metric logging via **MLflow**.
- **Drift Monitoring**: Real-time detection of data and model drift using **Evidently**.
- **Automated Retraining**: Scheduled daily model updates to adapt to market changes.
- **Inference API**: High-performance FastAPI backend with real-time predictions.

## Folder Structure
```text
project_root/
├── src/
│   ├── data/            # yfinance data extraction
│   ├── features/        # Feature engineering and scaling
│   ├── models/          # LR, ARIMA, LSTM, Ensemble, and training scripts
│   ├── monitoring/      # Evidently AI drift detection & SQLite logging
│   ├── tests/           # Unit tests
│   └── api.py           # FastAPI service
├── data/                # Lightweight SQLite databases & CSVs
├── mlflow/              # MLflow experiment tracking artifacts
├── .github/workflows/   # CI/CD pipelines
├── scheduler.py         # APScheduler automation script
├── config.yaml          # Project parameters
└── requirements.txt     # Dependencies
```

## Model Descriptions
The engine compares three separate model paradigms and intelligently combines them into an optimized ensemble.

1. **Linear Regression**: A simple, fast statistical baseline model.
2. **ARIMA / SARIMA**: A traditional time-series model (trained on *scaled* target values; outputs are inverse-transformed before serving).
3. **LSTM Deep Learning Model**: A Recurrent Neural Network (PyTorch) capturing non-linear dependencies.
   - **Prediction Mechanism**: The LSTM model uses a sliding sequence window of the previous 24 hours of BTCUSD data (`t-24` to `t-1`) to predict the next-hour closing price (`t+1`).
   - **Target Scaling**: LSTM is trained with normalized targets and its forecasts are inverse‑scaled for human-readable prices.
4. **Ensemble Prediction**: A weighted average dynamically balanced upon walk-forward validation performance.

## API Endpoints
The engine is served via FastAPI.

- `GET /health` - Check backend system status.
- `GET /latest-data` - Return latest fetched BTC market data.
- `POST /train` - Trigger background training pipeline for all models.
- `GET /predict-next-hour` - Return the forecast for the upcoming hour.
  
  *Example Response:*
  ```json
  {
      "timestamp": "2026-03-08 20:00:00",
      "linear_regression_prediction": 68050.25,
      "arima_prediction": 68010.50,
      "lstm_prediction": 68120.75,
      "ensemble_prediction": 68060.50
  }
  ```
- `GET /metrics` - Retrieve historical metrics from the database logs.

## Monitoring and Logging

### Prediction Logging System
All hourly predictions and actual resolving prices are stored in a lightweight SQLite database located at:
`data/predictions.db`

The predictions table schema includes:
- `timestamp`
- `actual_price`
- `linear_regression_prediction`
- `arima_prediction`
- `lstm_prediction`
- `ensemble_prediction`
- `prediction_error`

### MLflow & Evidently AI
**MLflow** captures metrics (MSE, RMSE, ROI, MAE), parameters, and model artifacts inside the `mlflow/` directory.
**Evidently AI** evaluates live data streams against reference data to automatically detect Data Drift and Model performance degradation over time.

## How to Run the Project

1. **Setup Environment**:
   *The system is configured to use a managed virtual environment (`venv_311`). All dependencies are handled automatically.*

2. **Run Initial Training Pipeline** (Recommended first run):
   Double-click the `run_training.bat` file OR run from the terminal:
   ```cmd
   run_training.bat
   ```   ⚠️ **Important**: The first training run (and any time the code is modified to change preprocessing or models) will create a `target_scaler.pkl` file in the `models` directory. If you update the repo or pull changes that modify scaling logic, re‑run training so the inference API can use the fresh scaler.
3. **Start the FastAPI Backend**:
   Double-click the `run_api.bat` file OR run from the terminal:
   ```cmd
   run_api.bat
   ```
   *Visit `127.0.0.1:8000/docs` to interact with the API endpoints directly.*

4. **Launch Automation Pipelines**:
   Double-click the `run_scheduler.bat` file to trigger automatic hourly forecasting and midnight retraining.

5. **Access MLflow**:
   Activate the virtual environment and start MLflow:
   ```cmd
   call venv_311\Scripts\activate.bat
   mlflow ui --backend-store-uri sqlite:///mlflow/mlflow.db
   ```
   *Then visit `http://127.0.0.1:5000` to review training history.*
