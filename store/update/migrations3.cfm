
<!--- Move the discount products, categories and groups into the new tables --->

<!--- Initialize discounts CFC --->
<cfset objDiscounts = CreateObject("component", "#Request.CFCMapping#.shopping.discounts").init()>

<!--- Product-level discounts --->
<cfquery name="ProdDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Discount_ID, Products FROM Discounts
WHERE Type3 = 0
</cfquery>

<cfloop query="ProdDiscounts">
	<cfloop index="ProdID" list="#ProdDiscounts.Products#">
		<cfquery name="AddProd" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO Discount_Products
			(Discount_ID, Product_ID)
			VALUES
			(#ProdDiscounts.Discount_ID#, #ProdID#)
		</cfquery>
	</cfloop>
</cfloop>

<!--- Category-level discounts --->
<cfquery name="CatDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Discount_ID, Categories, Type3 FROM Discounts
WHERE Type3 = 1 OR Type3 = 2
</cfquery>

<cfloop query="CatDiscounts">
	<cfset CatList = CatDiscounts.Categories>
	<cfif ListFind(CatList, 0)>
		<cfset CatList = ListDeleteAt(CatList, ListFind(CatList, 0))>
	</cfif>
	<!--- If this is a multi-level category discount, get all the children --->
	<cfif CatDiscounts.Type3 IS 2>
		<cfset ParentCats = CatList>
		<!--- Loop until no children --->
		<cfloop condition="len(ParentCats)">
			<cfquery name="GetChildren" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Category_ID FROM Categories
				WHERE Parent_ID IN (#ParentCats#)
			</cfquery>
				
			<cfset ParentCats = ValueList(GetChildren.Category_ID)>
			<cfset CatList = ListAppend(CatList, ParentCats)>
		</cfloop>	
	</cfif>
	<!--- end multi-level category processing --->
	
	<cfloop index="CatID" list="#CatList#">
		<cfquery name="AddCategory" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO Discount_Categories
			(Discount_ID, Category_ID)
			VALUES
			(#CatDiscounts.Discount_ID#, #CatID#)
		</cfquery>
	</cfloop>

</cfloop>

<!--- Update Multi-level Categories to single-level --->
<cfquery name="UpdCatDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE Discounts
SET Type3 = 1 
WHERE Type3 = 2
</cfquery>

<!--- Migrate the user groups for the discount --->
<cfquery name="GroupDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Discount_ID, Users FROM Discounts
WHERE Type5 <> 0
</cfquery>

<cfloop query="GroupDiscounts">
	<cfloop index="GroupID" list="#GroupDiscounts.Users#">
		<cfquery name="AddGroup" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO Discount_Groups
			(Discount_ID, Group_ID)
			VALUES
			(#GroupDiscounts.Discount_ID#, #GroupID#)
		</cfquery>
	</cfloop>
</cfloop>

<!--- Update the Product Discount Lists --->
<cfquery name="GetProds" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT DISTINCT Product_ID FROM Discount_Products
UNION 
SELECT DISTINCT Product_ID FROM Product_Category
WHERE Category_ID IN (SELECT Category_ID FROM Discount_Categories)
</cfquery>

<cfloop query="GetProds">
	<cfset DiscountList = objDiscounts.getProdDiscountList(GetProds.Product_ID)>
	<cfquery name="UpdDiscList" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE Products
	SET Discounts = '#DiscountList#'
	WHERE Product_ID = #GetProds.Product_ID#
	</cfquery>
</cfloop>

