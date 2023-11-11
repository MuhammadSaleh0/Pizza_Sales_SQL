--Pizza Sales SQL Project 


--Total Revenue.
Select Round(sum(total_price),2) as TotalRevenues 
from pizza_Sales.dbo.pizza_sales

--Select cast(sum(total_price) as decimal(10,2)) as TotalRevenues 
--from pizza_Sales.dbo.pizza_sales


--Average Order Value
select Round(sum(total_price) / COUNT(distinct order_id),2) as AvgOrderValue
from pizza_Sales.dbo.pizza_sales



--Total Pizzas Sold
Select SUM(quantity) as TotalPizzaSold
from pizza_Sales.dbo.pizza_sales


--Total Orders
Select count(distinct order_id) as TotalOrders
from pizza_Sales.dbo.pizza_sales



--Average Pizzas Per Order
select cast( cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as AvgPizzaPerOrder
from pizza_Sales.dbo.pizza_sales



--Hourly Trend for Total Pizzas Sold
select DATEPART(HOUR,order_time) as OrderTimeAsHours,
Round(Sum(quantity),2) as TotalPizzaSoldPerHours
from pizza_Sales.dbo.pizza_sales
group by DATEPART(HOUR,order_time)
order by TotalPizzaSoldPerHours desc



-- Weekly Trend for Orders
select DATEPART(WK,order_date) as WeekNumber,
count(distinct order_id) as TotalOrderPerWeek
from pizza_Sales.dbo.pizza_sales
group by DATEPART(WK,order_date)
order by TotalOrderPerWeek desc



--% of Sales by Pizza Category
with cte_TotalRevenuePerPizzaCategory AS
(
select pizza_category,Round(sum(total_price),2) as TotalRevenuePerPizzaCategory
from pizza_Sales.dbo.pizza_sales
group by pizza_category
)
select * ,
Round(TotalRevenuePerPizzaCategory *100/
(select sum(total_price) from pizza_Sales.dbo.pizza_sales),2)
as PercentageOfSalesPerPizzaCategory
from cte_TotalRevenuePerPizzaCategory
order by TotalRevenuePerPizzaCategory desc




--% of Sales by Pizza Size
select pizza_size,Round(sum(total_price),2) as
SalesPerPizzaSize,
Round((Round(SUM(total_price),2)*100/
(select sum(total_price) from pizza_Sales.dbo.pizza_sales)),2)
as PercentageOfTotalSalesPerPizzaSize
from pizza_Sales.dbo.pizza_sales
group by pizza_size
order by 2 desc



--Total Pizzas Sold by Pizza Category for specific month 
select pizza_category,sum(quantity) PizzaSoldPerPizaaCategory
from pizza_Sales.dbo.pizza_sales
where Month(order_date)= 3
group by pizza_category
order by 2 desc



--Top 5 Pizzas by Revenue
Select top 5 pizza_name,Round(sum(total_price),2) Top5PerRevenue
from pizza_Sales.dbo.pizza_sales
--where pizza_category = 'Classic'
group by pizza_name
order by 2 desc

--Top 5 Pizzas by Quantity
Select top 5 pizza_name,Round(sum(quantity),2) Top5PerQuantity
from pizza_Sales.dbo.pizza_sales
--where pizza_category = 'Classic'
group by pizza_name
order by 2 desc

--Top 5 Pizzas by Orders
Select top 5 pizza_name,Round(count(Distinct order_id),2) Top5PerOrders
from pizza_Sales.dbo.pizza_sales
--where pizza_category = 'Classic'
group by pizza_name
order by 2 desc



--Bottom 5 Pizzas by Revenue
Select top 5 pizza_name,Round(sum(total_price),2) Bottom5PerRevenue
from pizza_Sales.dbo.pizza_sales
--where pizza_category = 'Classic'
group by pizza_name
order by 2 ASC

--Bottom 5 Pizzas by Quantity
Select top 5 pizza_name,Round(sum(quantity),2) Bottom5PerQuantity
from pizza_Sales.dbo.pizza_sales
--where pizza_category = 'Classic'
group by pizza_name
order by 2 ASC

--Bottom 5 Pizzas by Orders
Select top 5 pizza_name,Round(count(Distinct order_id),2) Bottom5PerOrders
from pizza_Sales.dbo.pizza_sales
--where pizza_category = 'Classic'
group by pizza_name
order by 2 ASC








