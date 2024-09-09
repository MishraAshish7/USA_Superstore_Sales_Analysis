# USA_Superstore_Sales_Analysis

## 1.1 Project Title : Sales and Profit Analysis: A Comprehensive Data Exploration

1.2 Objective
To perform an in-depth analysis of sales and profit data to uncover trends, evaluate customer and product performance, assess geographical variations, and understand the impact of discounts. This will be achieved through Python scripts, MySQL queries, and visualizations in Power BI, with a goal of providing actionable insights for strategic decision-making.

1.3 Scope
 - Analyze historical sales and profit trends.
 - Segment customers and assess their impact on sales and profit.
 - Evaluate product performance and the effect of discounts.
 - Examine geographical variations in sales and profit.


2. Data Description

2.1 Dataset Overview
 - **Source:** [Kaggle]
 - **Description:** The dataset includes sales transactions with attributes such as order IDs, dates, customer details, product information, and sales metrics.
 - **Key Fields:**
   - **Order ID:** Unique identifier for each order.
   - **Order Date:** Date when the order was placed.
   - **Ship Date:** Date when the order was shipped.
   - **Customer ID:** Unique identifier for each customer.
   - **Customer Name:** Name of the customer.
   - **Segment:** Customer segment (e.g., Consumer, Corporate).
   - **Product ID:** Unique identifier for each product.
   - **Category:** Product category (e.g., Furniture, Office Supplies).
   - **Sales:** Revenue generated from the sale.
   - **Quantity:** Number of units sold.
   - **Discount:** Discount applied on the product.
   - **Profit:** Profit earned from the sale.

2.2 Data Quality and Preparation
 - **Cleaning:** Handled missing values, corrected inconsistencies, and ensured data integrity.
 - **Transformation:** Aggregated and transformed data to align with analysis requirements (e.g., calculating monthly sales).

3. Questions Set
- **Python Questions**

1. **Trend Analysis**
   - What are the precise monthly and yearly trends in sales and profit?
   - What are the growth rates for sales and profit on a month-over-month and year-over-year basis?

2. **Customer Segmentation**
   - Which customer segments (Consumer, Corporate) contribute most to overall sales and profit?
   - What is the distribution of sales and profit across different customer segments?
   - How do purchasing patterns (e.g., frequency, average order size) differ among customer segments?

3. **Product Performance**
   - What are the top 10 products and product categories by total sales and profit?
   - Which products and categories have the highest and lowest profit margins?
   - How do discounts affect sales volume and profitability for different products?

4. **Geographical Analysis**
   - How do sales and profit metrics compare across different states and regions?
   - What are the top and bottom 5 states/regions in terms of sales and profit?
   - Are there any observable trends or anomalies in sales and profit across different geographical areas?

5. **Discount Analysis**
   - What is the relationship between discount percentages and profit margins?
   - How do different discount levels impact sales volume and overall profitability?
   - Are there patterns or thresholds in discounting that maximize profit?

**MySQL Queries**

1. **Trend Analysis**
   - Query to aggregate total sales and profit by month and year.
   - Query to calculate month-over-month and year-over-year growth rates in sales and profit.
   - Query to detect seasonal trends or periodic patterns in sales and profit.

2. **Customer Segmentation**
   - Query to aggregate sales and profit by customer segment (Consumer, Corporate).
   - Query to compute average order value, total sales, and profit for each customer segment.
   - Query to identify top and bottom customers by sales and profit within each segment.

3. **Product Performance**
   - Query to retrieve total sales and profit for the top 10 products and categories.
   - Query to calculate profit margins for different products and categories.
   - Query to analyze the effect of discounts on sales and profit by product.

4. **Geographical Analysis**
   - Query to aggregate sales and profit by state and region.
   - Query to identify the top 5 and bottom 5 states/regions based on sales and profit.
   - Query to detect trends or anomalies in geographical performance.

5. **Discount Analysis**
   - Query to calculate the correlation between discount percentages and profit margins.
   - Query to analyze the impact of various discount levels on sales volume and profitability.
   - Query to identify optimal discount thresholds for maximizing profit.

