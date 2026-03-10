BTCUSD Forecasting Engine – Dashboard Overview
<img width="1912" height="877" alt="image" src="https://github.com/user-attachments/assets/663049c7-6c86-4f1b-8a09-4e468b8a7d24" />

Statistical Performance Dashboard
<img width="1919" height="731" alt="image" src="https://github.com/user-attachments/assets/2b6348a2-f166-4004-8afc-d7212b8af087" />

Model Leaderboard & RMSE Comparison Across Forecasting Models
<img width="1577" height="868" alt="image" src="https://github.com/user-attachments/assets/aa823833-3496-44ba-abf1-2ad130d34deb" />

System Monitoring Dashboard – Data Drift Detection and Prediction Error Tracking
<img width="1916" height="871" alt="image" src="https://github.com/user-attachments/assets/ee418b67-5861-46f5-80d4-3dce6ddc288e" />

Control Center – Prediction History and Model Forecast Logs
<img width="1919" height="807" alt="image" src="https://github.com/user-attachments/assets/47acac10-8565-4bad-ad60-cd53ab788c3b" />














BTCUSD Hourly Forecasting Engine is a backend-focused machine learning system designed to predict the next-hour closing price of BTCUSD. The system automatically fetches hourly market data using yfinance, performs feature engineering with technical indicators such as RSI, MACD, Bollinger Bands, ATR, and lag features, and processes the data through a complete ML pipeline. It evaluates multiple models including Linear Regression, ARIMA, and a PyTorch-based LSTM, and combines their outputs using an ensemble approach to improve prediction accuracy. The system includes MLflow for experiment tracking, Evidently AI for data and model drift monitoring, and logs all predictions and metrics in a SQLite database for performance analysis. Predictions are served through a FastAPI backend API, enabling real-time inference, automated retraining, and efficient monitoring within a production-style machine learning lifecycle.
