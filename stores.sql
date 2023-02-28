SELECT * FROM data_store.orders;
SELECT * FROM data_store.returns;

#Add a column that determines the difference in days between the order_date and ship_date
#Create a new column that handles the difference
ALTER TABLE data_store.orders
ADD COLUMN Date_Difference INTEGER;
#Calculate date difference and add to the new column-- we get an error message due to the date format
UPDATE data_store.orders 
SET Date_difference = datediff(data_store.orders.Ship_Date,data_store.orders.Order_Date);

#Converting it to the m/d/yyyymfor the two columns
UPDATE data_store.orders 
SET data_store.orders.Order_Date = STR_TO_DATE(data_store.orders.Order_Date, '%d/%m/%Y');

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



