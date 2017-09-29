Use AdventureWorks2012


/*a.	Show First name and last name of employees whose job title is “Sales Representative”, ranking from oldest to youngest. You may use HumanResources.Employee table and Person.Person table. (14 rows)*/

Select PP.BusinessEntityID,
       PP.FirstName,
       PP.LastName,
	   HRE.BirthDate
From Person.Person As PP
Join HumanResources.Employee AS HRE
On HRE.BusinessEntityID = PP.BusinessEntityID
Where HRE.JobTitle Like 'Sales Representative'
Group By PP.BusinessEntityID,
         PP.FirstName,
		 PP.LastName,
		 HRE.BirthDate
Order by HRE.BirthDate Asc

/*b.	Find out all the products which sold more than $5000 in total. Show product ID and name and total amount collected after selling the products. You may use LineTotal from Sales.SalesOrderDetail table and Production.Product table. (254 rows)*/

Select COUNT(PP.ProductID) AS NumberOfProducts,
       PP.Name,
	   SUM(SSOD.LineTotal)
From Production.Product AS PP
Join Sales.SalesOrderDetail AS SSOD
On SSOD.ProductID = PP.ProductID
Group By PP.Name
Having Sum(SSOD.LineTotal) > 5000

/*c.	Show BusinessEntityID, territory name and SalesYTD of all sales persons whose SalesYTD is greater than $500,000, regardless of whether they are assigned a territory. You may use Sales.SalesPerson table and Sales.SalesTerritory table. (16 rows)*/

Select SSP.BusinessEntityID,
       SSP.TerritoryID,
	   SST.Name AS TerritoryName,
	   SSP.SalesYTD
From Sales.SalesPerson AS SSP
Left Outer Join Sales.SalesTerritory AS SST
ON SST.TerritoryID = SSP.TerritoryID
Where SSP.SalesYTD > 500000
Group By SSP.BusinessEntityID,
       SSP.TerritoryID,
	   SST.Name,
	   SSP.SalesYTD

/*d.	Show the sales order ID of those orders in the year 2008 of which the total due is great than the average total due of all the orders of the same year. (3200 rows)*/

Select SalesOrderID,
       TotalDue
From Sales.SalesOrderHeader
Where OrderDate >= '2008-01-01' and OrderDate <= '2008-12-31'
Group By SalesOrderID,
         TotalDue
Having TotalDue > (Select AVG(TotalDue) From Sales.SalesOrderHeader 
Where OrderDate >= '2008-01-01' and OrderDate <= '2008-12-31')