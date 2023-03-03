SELECT * FROM data_store.orders;
SELECT * FROM data_store.returns;

#Calculate the Gross revenue AND create a new column for this
ALTER TABLE data_store.orders
ADD COLUMN Gross_revenue INTEGER;
#Updating the Gross_revenue table
UPDATE data_store.orders
SET data_store.orders.Gross_revenue = sales*Quantity;

#calulate the Expenses calculates as ; Gross_revenue- Expenses and add to a new column
ALTER TABLE data_store.orders
ADD COLUMN Expenses integer;
#update the column Expenses with values
UPDATE data_store.orders
SET data_store.orders.Expenses = data_store.orders.Gross_revenue - data_store.orders.Profit;

#Using OUTER Join to combine the rows from the returns table
SELECT Row_ID,Returned 
FROM data_store.orders
	FULL JOIN data_store.returns
		ON data_store.orders.Order_ID = data_store.returns.Order_ID;

#Query the products that had loss in the category and sub-caregory section and found in the USA
SELECT Order_ID, Customer_ID, Product_ID, Category, Sub_Category,Profit FROM data_store.orders
WHERE Profit<0 AND Country LIKE "%United States%"
ORDER BY PROFIT DESC;

#Query the table for the total profit and loss and display them seperately
SELECT 
SUM(CASE WHEN Profit <0 THEN Profit ELSE 0 END) AS total_loss,
SUM(CASE WHEN Profit >0 THEN Profit ELSE 0 END) AS total_profit
FROM data_store.orders;

#Create a table that calulates the sales after discount (sales_discount)
ALTER TABLE data_store.orders
ADD COLUMN sales_Discount INTEGER;

UPDATE data_store.orders
SET data_store.orders.sales_Discount = (CASE WHEN Discount = 0 THEN 1 * Sales
ELSE Discount*Sales END);

#Query the table for Range of the sales and profits 
SELECT MAX(data_store.orders.sales) - MIN(data_store.orders.Sales) as Sales_range, MAX(data_store.orders.Profit)-MIN(data_store.orders.Profit) AS Profit_range, M 
FROM data_store.orders;

#Query the table for the average values of sales,Profit,Gross_revenue and use case statement to state whether the column values are above or below average
SELECT data_store.orders.Sales, 
data_store.orders.Profit,
data_store.orders.Gross_Revenue,
CASE 
	WHEN data_store.orders.Sales > AVG(data_store.orders.Sales) THEN 'Above Average Sales'
    WHEN data_store.orders.Sales < AVG(data_store.orders.Sales) THEN 'Below Average Sales'
    ELSE 'Average sales'
    END AS Sales_Average,
CASE 
	WHEN data_store.orders.Profit > AVG(data_store.orders.Profit) THEN 'Above Average Profit'
    WHEN data_store.orders.Profit > AVG(data_store.orders.Profit) THEN 'Below Average Profit'
    ELSE 'Average Profit'
    END AS Profit_Average,
    
CASE 
	WHEN data_store.orders.Gross_revenue > AVG(data_store.orders.Gross_revenue) THEN 'Above Average Gross Revenue'
    WHEN data_store.orders.Gross_revenue > AVG(data_store.orders.Gross_revenue) THEN 'Below Average Gross Revenie'
    ELSE 'Average Gross revenue'
	END AS Gross_revenue_Average
    FROM data_store.orders;

