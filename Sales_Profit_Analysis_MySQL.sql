# Pre analysis
describe superstore_cleaned;

# Total rows
select count(*)
from superstore_cleaned;

# Turning off the safe mode to update table
set sql_safe_updates = 0;

# Adding new column of date type then appending all values from previous columns
alter table superstore_cleaned
add column Order_Dates date;

UPDATE superstore_cleaned
SET Order_Dates = STR_TO_DATE(Order_Date, '%d-%m-%Y');

alter table superstore_cleaned
add column Ship_Dates date;

UPDATE superstore_cleaned
SET Ship_Dates = STR_TO_DATE(Ship_Date, '%d-%m-%Y');

alter table superstore_cleaned
drop column Order_Date;

alter table superstore_cleaned
drop column Ship_Date;


select str_to_date(Order_Date, "%d-%m-%Y")
from superstore_cleaned;

select *
from superstore_cleaned
limit 5;

# 1. **Trend Analysis**
#    - Query to aggregate total sales and profit by month and year.
with total_sales_profit_by_year as (
		select Year,
				sum(Sales) as Total_Sales,
                sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Year
        order by Year asc
),

total_sales_profit_by_month as (
		select Month_Name,
			   sum(Sales) as Total_Sales,
			   sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Month_Name
        order by Total_Sales asc
)

select *
from total_sales_profit_by_month;


#    - Query to calculate month-over-month and year-over-year growth rates in sales and profit.
with monthly_sales_profit_growth as (
		select extract(month from Ship_Dates) as Months,
				avg(Sales_Growth_Rate) as Average_Sales_Growth_Rate,
                avg(Profit_Margin) as Average_Profit_Growth_Rate
        from superstore_cleaned
        group by Months
        order by Months asc
),
yearly_sales_profit_growth as (
		select Year,
				avg(Sales_Growth_Rate) as Average_Sales_Growth_Rate,
                avg(Profit_Margin) as Average_Profit_Growth_Rate
        from superstore_cleaned
        group by Year
        order by Year asc
)

select *
from yearly_sales_profit_growth;


#    - Query to detect seasonal trends or periodic patterns in sales and profit.



# 2. **Customer Segmentation**
#    - Query to aggregate sales and profit by customer segment (Consumer, Corporate).
select Segment,
		sum(Sales) as Total_Sales,
        sum(Profit) as Total_Profit
from superstore_cleaned
group by Segment;


#    - Query to compute average order value, total sales, and profit for each customer segment.
select Segment,
		avg(Sales) as AvgOrderValue,
		sum(Sales) as Total_Sales,
        sum(Profit) as Total_Profit
from superstore_cleaned
group by Segment;


#    - Query to identify top and bottom customers by sales and profit within each segment.


# 3. **Product Performance**
#    - Query to retrieve total sales and profit for the top 10 products and categories.
with top_10_products_by_sales as (
		select Product_Name,
				sum(Sales) as Total_Sales,
                sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Product_Name
        order by Total_Sales desc
        limit 10
),

top_10_products_by_profit as (
		select Product_Name,
				sum(Sales) as Total_Sales,
                sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Product_Name
        order by Total_Profit desc
        limit 10
),

top_10_category_by_sales as (
		select Category,
				sum(Sales) as Total_Sales,
                sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Category
        order by Total_Sales desc
        limit 10
),

top_10_category_by_profit as (
		select Category,
				sum(Sales) as Total_Sales,
                sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Category
        order by Total_Profit desc
        limit 10
)

select *
from top_10_category_by_profit;


#    - Query to calculate profit margins for different products and categories.
with profit_margin_by_product as (
		select Product_Name,
                avg(Profit_Margin) as Average_Profit_Margin
        from superstore_cleaned
        group by Product_Name
        order by Average_Profit_Margin desc
),

profit_margin_by_category as (
		select Category,
                avg(Profit_Margin) as Average_Profit_Margin
        from superstore_cleaned
        group by Category
        order by Average_Profit_Margin desc
)

select *
from profit_margin_by_category;

#    - Query to analyze the effect of discounts on sales and profit by product.
select Discount,
		sum(Sales) as Total_Sales,
		sum(Profit) as Total_Profit
from superstore_cleaned
group by Discount
order by Discount asc;


# 4. **Geographical Analysis**
#    - Query to aggregate sales and profit by state and region.
with aggregate_by_state as (
		select State,
				sum(Sales) as Total_Sales,
				sum(Profit) as Total_Profit
        from superstore_cleaned
        group by State
        order by Total_Sales asc
),
aggregate_by_region as (
		select Region,
				sum(Sales) as Total_Sales,
				sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Region
        order by Total_Sales asc
)

select *
from aggregate_by_state;

#    - Query to identify the top 5 and bottom 5 states/regions based on sales and profit.

with total_sales_profits_byState as (
		select State,
				sum(Sales) as Total_Sales,
				sum(Profit) as Total_Profit
        from superstore_cleaned
        group by State
        order by Total_Sales asc
),
total_sales_profits_byRegions as (
		select Region,
				sum(Sales) as Total_Sales,
				sum(Profit) as Total_Profit
        from superstore_cleaned
        group by Region
        order by Total_Sales asc
),

top5states_by_sales_profit as (
		select *
        from total_sales_profits_byState
        order by Total_Sales desc, Total_Profit desc
        limit 5
),

bottom5states_by_sales_profit as (
		select *
        from total_sales_profits_byState
        order by Total_Sales asc, Total_Profit asc
        limit 5
),

topregions_by_sales_profit as (
		select *
        from total_sales_profits_byRegions
        order by Total_Sales desc, Total_Profit desc
        limit 5
),

bottom5regions_by_sales_profit as (
		select *
        from total_sales_profits_byRegions
        order by Total_Sales asc, Total_Profit asc
        limit 5
)

select *
from bottom5regions_by_sales_profit;


#    - Query to detect trends or anomalies in geographical performance.
-- Calculate total sales and profit by region and year
with regional_performance as (
    select 
        region,
        year,
        sum(sales) as total_sales,
        sum(profit) as total_profit
    from superstore_cleaned
    group by region, year
),
trend_analysis as (
    select 
        region,
        year,
        total_sales,
        total_profit,
        lag(total_sales) over (partition by region order by year) as prev_year_sales,
        lag(total_profit) over (partition by region order by year) as prev_year_profit
    from regional_performance
)
-- Calculate year-over-year growth for sales and profit
select 
    region,
    year,
    total_sales,
    total_profit,
    prev_year_sales,
    prev_year_profit,
    (total_sales - prev_year_sales) / nullif(prev_year_sales, 0) as sales_growth_rate,
    (total_profit - prev_year_profit) / nullif(prev_year_profit, 0) as profit_growth_rate
from trend_analysis
order by region, year;



# 5. **Discount Analysis**
#    - Query to calculate the correlation between discount percentages and profit margins.
-- define ctes to compute means, covariance, and standard deviations
with mean_values as (
    select 
        avg(discount) as mean_discount,
        avg(profit_margin) as mean_profit_margin
    from superstore_cleaned
),
covariance_and_stddev as (
    select 
        sum((discount - mean_discount) * (profit_margin - mean_profit_margin)) as covariance,
        sqrt(sum(pow(discount - mean_discount, 2))) as stddev_discount,
        sqrt(sum(pow(profit_margin - mean_profit_margin, 2))) as stddev_profit_margin
    from superstore_cleaned
    cross join mean_values
),
correlation as (
    select 
        covariance / (stddev_discount * stddev_profit_margin) as correlation
    from covariance_and_stddev
)
-- select the correlation result
select correlation
from correlation;


#    - Query to analyze the impact of various discount levels on sales volume and profitability.
select Discount,
		avg(Sales) as Average_Sales,
        avg(Profit) as Average_Profit,
        avg(Quantity) as Average_Quantity
from superstore_cleaned
group by Discount
order by Discount asc;


#    - Query to identify optimal discount thresholds for maximizing profit.
select Discount,
		sum(Profit) as Total_Profit
from superstore_cleaned
group by Discount
order by Total_Profit asc;