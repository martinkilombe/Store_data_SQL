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






