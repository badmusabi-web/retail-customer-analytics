import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv("retail_sales_dataset.csv")

# Convert date
df['Date'] = pd.to_datetime(df['Date'])

# ======================
# BASIC KPI METRICS
# ======================
print("Total Revenue:", df['Total Amount'].sum())
print("Total Transactions:", df['Transaction ID'].nunique())


# ======================
# MONTHLY SALES TREND
# ======================
monthly_sales = df.groupby(df['Date'].dt.to_period('M'))['Total Amount'].sum()

monthly_sales.plot(kind='line', figsize=(10,5))
plt.title("Monthly Sales Trend")
plt.show()


# ======================
# GROWTH RATE
# ======================
monthly_growth = monthly_sales.pct_change() * 100
monthly_growth


# ======================
# CATEGORY ANALYSIS
# ======================
category_sales = df.groupby('Product Category')['Total Amount'].sum()

category_sales.plot(kind='bar')
plt.title("Sales by Category")
plt.show()


# ======================
# MOVING AVERAGE
# ======================
monthly_sales.rolling(3).mean().plot()
plt.title("3-Month Moving Average")
plt.show()