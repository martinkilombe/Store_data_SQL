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





