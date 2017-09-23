Use AdventureWorks2012


/*1. Display the total amount collected from the orders for each order date. */
Select PurchaseOrderID, OrderDate, TotalDue
From Purchasing.PurchaseOrderHeader


/*2. Display the total amount collected after selling the products, 774 and 777. */
Select ProductID 
	   SUM(LineTotal) As TotalCollected
From Sales.SalesOrderDetail
Group by ProductID
Having ProductID = 774 AND ProductID = 777

/*3. Write a query to display the sales person ID of all the sales persons and the name of the territory to which they belong.*/
Select s.BusinessEntityID, p.FirstName, p.MiddleName, p.LastName, s.TerritoryID
From Sales.SalesPerson As s
Join Person.Person As p
On s.BusinessEntityID = p.BusinessEntityID


/*4. Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
Select s.BusinessEntityID, p.CardType
From Sales.PersonCreditCard As s
Join Sales.CreditCard AS p
On s.BusinessEntityID = p.BusinessEntityID
Where CreditCardID Like 'Vista'

/*5, Write a query to display all the country region codes along with their corresponding territory IDs*/
Select TerritoryID, CountryRegionCode
From Sales.SalesTerritory

/*6. Find out the average of the total dues of all the orders.*/
Select AVG (TotalDue) As Avg_Dues
From Sales.SalesOrderHeader

/*7. Write a query to report the sales order ID of those orders where the total value is greater than the average of the total value of all the orders.*/
Select SalesOrderID, TotalDue
From Sales.SalesOrderHeader
Where TotalDue > AVG (TotalDue)