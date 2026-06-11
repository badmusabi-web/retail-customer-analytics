import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv("retail_sales_dataset.csv")

df['Date'] = pd.to_datetime(df['Date'])


# ======================
# CUSTOMER SUMMARY
# ======================
customer = df.groupby('Customer ID').agg(
    total_orders=('Transaction ID', 'count'),
    total_spent=('Total Amount', 'sum'),
    avg_order=('Total Amount', 'mean')
).reset_index()


# ======================
# SEGMENTATION
# ======================
def segment(x):
    if x >= 1000:
        return "High Value"
    elif x >= 500:
        return "Medium Value"
    else:
        return "Low Value"

customer['segment'] = customer['total_spent'].apply(segment)


# ======================
# SEGMENT DISTRIBUTION
# ======================
customer['segment'].value_counts().plot(kind='bar')
plt.title("Customer Segments")
plt.show()


# ======================
# TOP CUSTOMERS
# ======================
customer.sort_values('total_spent', ascending=False).head(10)


# ======================
# GENDER ANALYSIS
# ======================
df.groupby('Gender')['Total Amount'].sum().plot(kind='bar')
plt.title("Spending by Gender")
plt.show()