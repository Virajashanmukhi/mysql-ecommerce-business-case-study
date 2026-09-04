# 📊 E-Commerce Revenue Decline Analysis (SQL + Python)

## 📌 Project Overview

This project analyzes a real-world e-commerce dataset to investigate a **sudden decline in revenue and orders observed after September 2018**.

The goal is to move beyond surface-level trends and perform **root cause analysis using SQL and Python**, focusing on identifying patterns, validating hypotheses, and deriving data-driven insights.



## 📂 Dataset

This project uses the **Brazilian E-Commerce Public Dataset by Olist** available on Kaggle:

- Contains ~100,000 orders from 2016–2018
- Includes data on:
  - Orders
  - Customers
  - Products
  - Sellers
  - Payments
  - Reviews
  - Delivery timestamps  


## 🗂️ Data Model

The dataset follows a **relational schema** including:
 -dataset link: (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

- Orders (core transactional table)
- Order Items (product-level data)
- Customers
- Sellers
- Payments
- Reviews
- Geolocation

📌 ER Diagram is included in this repository.


## 🧹 Data Cleaning (Python)

Data preprocessing was performed using Python (Pandas):

- Handled missing values in timestamps
- Converted date columns to datetime format
- Removed inconsistent/null records
- Standardized column names
- Verified data completeness across months


## 🎯 Problem Statement

From initial exploration:

- Revenue and orders **drop significantly after September 2018**
- Need to identify:
  - Whether the drop is real
  - What factors are associated with the decline


## 📊 Key KPIs Used

- Total Orders - 99441
- Total Revenue - 16.01M
- Total Customers - 99441
- Total Seller - 3095
- Average Order Value - 120.65
- Repeated Customer% -0%
- New Customer % - 100%


## 🔍 Analysis Approach

The analysis follows a structured diagnostic flow:

1. Trend validation (monthly revenue & orders)
2. Breakdown by:
   - Geography (state)
   - Product
   - Customer activity
3. Operational analysis (delivery delay)
4. Hypothesis testing:
   - Reviews impact ❌
   - Delivery completion ❌
   - Repeat customers ❌


## 🔥 Key Insights

### 📉 Overall Decline
- From September 2018:
  - Orders decreased significantly
  - Revenue decreased consistently
  - Customer count dropped


### 🚚 Delivery Delay Spike
- Average delay increased sharply:
  - August: ~29 days  
  - September: ~115 days  
  - December: ~203 days  



### 🔄 Strong Negative Relationship
- As delay increased:
  - Orders % dropped from ~7.47% → ~1.37%  
  - Revenue % dropped from ~7.6% → ~1.34%  


### ⏱️ Lag Effect
- Increase in delay is followed by:
  - Drop in customers
  - Drop in orders in subsequent months  


### 🌍 High Regional Dependency
- Top state contributes:
  - ~38% of total revenue  

### 📍 Regional Collapse
From August → September (Top State):

- Orders: 5224 → 1576 (~70% drop)  
- Revenue share: 4.65% → 1.48%  
- Customer share: 3.05% → 0.85%  


### 📦 Product Impact
- Top product contribution dropped:
  - ~1.04% → ~0.18%  
- Indicates decline is not limited to low-performing products  


### ✅ Stable Metrics (Ruled Out)

- Orders delivered: ~100% across all months  
- Review scores:
  - 50%+ are 5-star consistently  
- No strong evidence of customer dissatisfaction  


### 👥 Customer Behavior
- Customers are mostly **new each month**
- No strong repeat customer pattern
- Decline driven by **reduced new customer inflow**


## 📌 Final Conclusion

The decline in revenue and orders after September 2018 is **not caused by fulfillment failure or customer dissatisfaction**, as:

- Orders are successfully delivered
- Review scores remain stable

Instead, the data shows:

- A **sharp increase in delivery delays**
- Followed by a **decline in customer activity**
- Strongly concentrated in a **high-revenue state (38% contribution)**

This indicates a **strong negative association between delivery performance and future demand**, rather than immediate operational failure.


## 🛠️ Tools Used

- Python (Pandas, NumPy)
- MySQL
- Jupyter Notebook


## 📎 Repository Contents

- SQL queries
- Python cleaning scripts
- ER Diagram
- Analysis documentation


## 🚀 Key Takeaways

- Focus on **data validation before conclusions**
- Eliminate weak signals (reviews, completion rate)
- Use **lag analysis for behavioral insights**
- Identify **high-impact segments (top state)** instead of analyzing everything

