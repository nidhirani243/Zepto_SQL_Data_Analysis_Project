# 🛒 Zepto E-commerce SQL Data Analyst Portfolio Project
This project presents an end-to-end SQL-based data analysis of Zepto, one of India's leading 10-minute quick-commerce delivery platforms. The primary objective is to analyze customer purchasing behavior, order fulfillment efficiency, product categories, pricing trends, and revenue metrics to drive actionable business strategies.

### 📌 Project Overview

The goal is to simulate how actual data analysts in the e-commerce or retail industries work behind the scenes to use SQL to:

✅ Set up a messy, real-world e-commerce inventory database

✅ Perform Exploratory Data Analysis (EDA) to explore product categories, availability, and pricing inconsistencies

✅ Implement Data Cleaning to handle null values, remove invalid entries, and convert pricing from paise to rupees

✅ Write business-driven SQL queries to derive insights around pricing, inventory, stock availability, revenue and more

### 📁 Dataset Overview

The dataset was sourced from Kaggle and was originally scraped from Zepto’s official product listings. It mimics what you’d typically encounter in a real-world e-commerce inventory system.

Each row represents a unique SKU (Stock Keeping Unit) for a product. Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.

### 🧾 Columns:

sku_id: Unique identifier for each product entry (Synthetic Primary Key)

name: Product name as it appears on the app

category: Product category like Fruits, Snacks, Beverages, etc.

mrp: Maximum Retail Price (originally in paise, converted to ₹)

discountPercent: Discount applied on MRP

discountedSellingPrice: Final price after discount (also converted to ₹)

availableQuantity: Units available in inventory

weightInGms: Product weight in grams

outOfStock: Boolean flag indicating stock availability

quantity: Number of units per package (mixed with grams for loose produce)

### 🔧 Project Workflow
Here’s a step-by-step breakdown of what we do in this project:

### 1. Database & Table Creation
We start by creating a SQL table with appropriate data types:

```sql

CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER
);
```
### 2. Data Import
Loaded CSV using pgAdmin's import feature.

If you're not able to use the import feature, write this code instead:

```sql
   \copy zepto(category,name,mrp,discountPercent,availableQuantity,
            discountedSellingPrice,weightInGms,outOfStock,quantity)
  FROM 'data/zepto_v2.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF8');
```

Faced encoding issues (UTF-8 error), which were fixed by saving the CSV file using CSV UTF-8 format.
### 3. 🔍 Data Exploration
Counted the total number of records in the dataset

Viewed a sample of the dataset to understand structure and content

Checked for null values across all columns

Identified distinct product categories available in the dataset

Compared in-stock vs out-of-stock product counts

Detected products present multiple times, representing different SKUs

### 4. 🧹 Data Cleaning
Identified and removed rows where MRP or discounted selling price was zero

Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability

### 5. 📊 Business Insights

Found top 10 best-value products based on discount percentage

Identified high-MRP products that are currently out of stock

Estimated potential revenue for each product category

Filtered expensive products (MRP > ₹500) with minimal discount

Ranked top 5 categories offering highest average discounts

Calculated price per gram to identify value-for-money products

Grouped products based on weight into Low, Medium, and Bulk categories

Measured total inventory weight per product category

### 🛠️ How to Use This Project

# 1. Clone the repository
git clone https://github.com/amlanmohanty/zepto-SQL-data-analysis-project.git
cd zepto-SQL-data-analysis-project

# 2. Open zepto_SQL_data_analysis.sql

This file contains:

Table creation

Data exploration

Data cleaning

SQL Business analysis

# 3. Load the dataset into pgAdmin or any other PostgreSQL client

Create a database and run the SQL file

Import the dataset (convert to UTF-8 if necessary)

## Key Learnings & Skill Takeaways

Mastered advanced SQL techniques including Common Table Expressions (CTEs), Window Functions (RANK(), DENSE_RANK(), SUM() OVER()), and multi-table JOINs.
Hands-on experience in converting raw transaction logs into actionable business key performance indicators (KPIs).
Practical understanding of quick-commerce operational challenges, such as dark-store inventory turnover and peak-hour delivery fulfillment.

## Problems that this project solves

This project addresses the operational and strategic challenges faced by fast-growing quick-commerce platforms like Zepto, where business decisions depend on real-time data and micro-efficiencies.
By analyzing transaction data, customer orders, and fulfillment logs, the project tackles four core business problems:

# 1. Delivery Bottlenecks & Late Deliveries

Problem: Quick-commerce promises ultra-fast deliveries (typically under 10–15 minutes). Unpredictable delays hurt customer retention and brand trust.
Solution: Identifies specific time windows, routes, and dark stores experiencing delivery delays, enabling teams to optimize rider allocation and routing.

# 2. Inventory Mismanagement & Stockouts
   
Problem: Overstocking perishable Fast-Moving Consumer Goods (FMCG) leads to waste, while understocking high-demand items results in missed revenue.
Solution: Tracks product turnover rates, category demand, and low-stock alerts to balance inventory levels across dark store networks.

# 3. Customer Churn & Low Lifetime Value (LTV)

Problem: High customer acquisition costs require platforms to maximize repeat orders and basket sizes.
Solution: Segments users by purchase frequency, recency, and average order value (AOV) to identify loyal customers and design targeted retention strategies.

# 4. Peak-Hour Demand & Staffing Inefficiencies

Problem: Sudden spikes in order volume during specific hours (e.g., morning groceries or late-night snacks) cause order backlogs.
Solution: Analyzes hourly ordering trends to optimize dark-store warehouse staffing and delivery partner scheduling during high-demand periods.


