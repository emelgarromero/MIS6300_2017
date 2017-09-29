Use AdventureWorksDW2012;

/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales in 1st quarter each year in each country. Note: your result set should produce a total of 18 rows. */

Select SUM(FIS.SalesAmount) as Total_Sales, 
	   SalesTerritoryCountry,
       Count(FIS.OrderQuantity) as NumberOfOrders,
	   CalendarQuarter,
	   CalendarYear
From dbo.FactInternetSales AS FIS
Join dbo.DimSalesTerritory AS DST
ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
Join dbo.DimDate AS DD
ON FIS.OrderDateKey = DD.DateKey
Where DD.CalendarQuarter = 1
Group By SalesTerritoryCountry, CalendarQuarter, CalendarYear


/*2, Show total reseller sales amount (sum of SalesAmount), calendar quarter of order date, product category name and reseller’s business type by quarter by category and by business type in 2006. Note: your result set should produce a total of 44 rows. */

Select SUM(FRS.SalesAmount) AS Total_Sales,
	   DD.CalendarQuarter,
	   DPC.EnglishProductCategoryName,
	   DR.BusinessType AS ResellerBusinessType
From dbo.FactResellerSales AS FRS
Join dbo.DimReseller AS DR
ON DR.ResellerKey = FRS.ResellerKey
Join dbo.DimProduct AS DP
On DP.ProductKey = FRS.ProductKey
Join dbo.DimProductSubcategory As PSC
On PSC.ProductSubCategoryKey = DP.ProductSubcategoryKey
Join dbo.DimProductCategory AS DPC
On DPC.ProductCategoryKey = PSC.ProductCategoryKey
Join dbo.DimDate AS DD
On DD.DateKey = FRS.OrderDateKey
Where CalendarYear = 2006
Group By DD.CalendarQuarter,
	   DPC.EnglishProductCategoryName,
	   DR.BusinessType


/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/
/*Slicing is when you create a subcube from the original cube based on one of the original cube's dimensions. In the following query, I reduced question 2's query to only show 
the Total_sales, CalendarQuarter, and EnglishProductCategoryName for only Bsuiness that are catagorized as "warehouses."*/

Select SUM(FRS.SalesAmount) AS Total_Sales,
	   DD.CalendarQuarter,
	   DPC.EnglishProductCategoryName
From dbo.FactResellerSales AS FRS
Join dbo.DimReseller AS DR
ON DR.ResellerKey = FRS.ResellerKey
Join dbo.DimProduct AS DP
On DP.ProductKey = FRS.ProductKey
Join dbo.DimProductSubcategory As PSC
On PSC.ProductSubCategoryKey = DP.ProductSubcategoryKey
Join dbo.DimProductCategory AS DPC
On DPC.ProductCategoryKey = PSC.ProductCategoryKey
Join dbo.DimDate AS DD
On DD.DateKey = FRS.OrderDateKey
Where CalendarYear = 2006
Group By DD.CalendarQuarter,
	   DPC.EnglishProductCategoryName,
	   DR.BusinessType
Having DR.Businesstype Like 'Warehouse'
	  

/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down, i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/
/* Drilling down allows you to look at the cube in a more specialized level, usually by going a level lower on one of the exisiting dimensions. This increases the number of headers. Using question 2 as an example, I have moved down a dimension
from quarter to month. This allows me to see more specifically the total sales of a reseller for each month rather than total sales in each quarter. */

Select SUM(FRS.SalesAmount) AS Annual_Sales,
	   DD.CalendarQuarter,
	   DPC.EnglishProductCategoryName,
	   DR.BusinessType AS ResellerBusinessType,
	   DD.EnglishMonthName
From dbo.FactResellerSales AS FRS
Join dbo.DimReseller AS DR
ON DR.ResellerKey = FRS.ResellerKey
Join dbo.DimProduct AS DP
On DP.ProductKey = FRS.ProductKey
Join dbo.DimProductSubcategory As PSC
On PSC.ProductSubCategoryKey = DP.ProductSubcategoryKey
Join dbo.DimProductCategory AS DPC
On DPC.ProductCategoryKey = PSC.ProductCategoryKey
Join dbo.DimDate AS DD
On DD.DateKey = FRS.OrderDateKey
Where CalendarYear = 2006
Group By DD.CalendarQuarter,
	   DPC.EnglishProductCategoryName,
	   DR.BusinessType,
	   DD.EnglishMonthName,
	   DD.MonthNumberOfYear
Order By DD.MonthNumberofYear Asc
