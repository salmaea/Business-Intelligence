use name_exercise01;
#my name anonymized for GitHub 

#question 1
select CompanyName, City, Region, PostalCode 
	from Customers
		Order by Region, City;
        
#question 2
select CompanyName, City, Region, PostalCode 
	from Customers
		Where Region = 'OR' 
			Order by Region, City, CompanyName;
            
#question 3
Select CompanyName, City, Region, PostalCode 
	From Customers
		Where Region = 'OR'or Region = 'WA'
			Order by Region desc, City, CompanyName;
            
#question 4
Select OrderID, CustomerID, OrderDate
	From Orders 
		Where CustomerID in ('QUICK', 'FRANK', 'RANCH')
			Order by CustomerID, OrderDate;
            
#question 5 
Select CustomerID, Count(OrderID)
	From Orders
		Where CustomerID in ('QUICK', 'FRANK', 'RANCH')
			Group by CustomerID
				Order by CustomerID;

#question 6
Select CustomerID, Count(OrderID) AS 'Orders Placed'
	From Orders
		Where CustomerID in ('QUICK', 'FRANK', 'RANCH')
			Group by CustomerID
				Order by CustomerID;
                
#question 7
Select COUNT(DISTINCT CustomerID)
	From Orders;
    
#question 8
Select count(*) AS 'Orders placed in May 1998'
	From Orders
		Where OrderDate between '1998-05-01' and '1998-05-31';

#question 9
Select Count(DISTINCT(CustomerID))
	From Orders 
		Where OrderDate between '1998-05-01' and '1998-05-31';
        
#question 10
Select CustomerID, COUNT(OrderID), concat('$', round(avg(Freight), 2)) AS 'Freight Cost'
	From Orders 
		Group by CustomerID
			Having Count(OrderID)>10 AND Avg(Freight)>100
				Order by CustomerID; 

#question 11
Select ProductID, SupplierID, UnitsInStock, Discontinued
	From Products
		Where SupplierID='2' OR SupplierID='12' 
			AND Discontinued='no'
				AND UnitsInStock<60
					Order by SupplierID, UnitsInStock DESC;


