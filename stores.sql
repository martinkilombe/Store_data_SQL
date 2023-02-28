SELECT * FROM data_store.orders;
SELECT * FROM data_store.returns;

#Add a column that determines the difference in days between the order_date and ship_date
#Create a new column that handles the difference
ALTER TABLE data_store.orders
ADD COLUMN Date_Difference INTEGER;
#Calculate date difference and add to the new column-- we get an error message due to the date format
UPDATE data_store.orders 
SET Date_difference = datediff(data_store.orders.Ship_Date,data_store.orders.Order_Date);

#Converting it to the m/d/yyyy

