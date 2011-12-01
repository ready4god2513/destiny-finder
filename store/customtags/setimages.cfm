
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- 
Parameters:
Datasource = database to query
Password = password for database
username = username for database
 ---> 
 
<!--- Check if using a line --->
<cfif len(Request.GetColors.MainLineImage)>

	<!--- Check if creating a HTML line --->
	<cfif Request.GetColors.MainLineImage IS "HR">
			<cfset Request.MainLine = "HR">

	<!--- Otherwise, create link for image --->
	<cfelse>
		<cfset Request.MainLine = "#Request.GetColors.MainLineImage#"" border=""0">
	</cfif>

<cfelse>

	<cfset Request.MainLine = "">

</cfif>

<!---- MINOR LINE -------------------->
<cfif len(Request.GetColors.MinorLineImage)>

	<!--- Check if creating a HTML line --->
	<cfif Request.GetColors.MinorLineImage IS "HR">
		<cfset Request.MinorLine = "HR">

	<!--- Otherwise, create link for image --->
	<cfelse>
		<cfset Request.MinorLine = "#Request.GetColors.MinorLineImage#"" border=""0">
	</cfif>
	
<cfelse>
	<cfset Request.MinorLine = "">
</cfif>

<!---- SALE -------------------->
<cfif len(Request.GetColors.SaleImage)>

	<cfset Request.SaleImage = "<img src=""#request.appsettings.defaultimages#/#Request.GetColors.SaleImage#"" border=""0"" style=""vertical-align: middle"" alt=""On Sale!"" />">

<cfelse>
	<cfset Request.SaleImage = " ">
</cfif>

<!---- NEW -------------------->
<cfif len(Request.GetColors.NewImage)>

	<cfset Request.NewImage = "<img src=""#request.appsettings.defaultimages#/#Request.GetColors.NewImage#"" border=""0"" style=""vertical-align: middle"" alt=""New!"" />">
	
<cfelse>
	<cfset Request.NewImage = " ">
</cfif>


<!---- HOT -------------------->
<cfif len(Request.GetColors.HOTImage)>

	<cfset Request.HOTImage = "<img src=""#request.appsettings.defaultimages#/#Request.GetColors.HOTImage#"" border=""0"" style=""vertical-align: middle"" alt=""HOT!"" />">
	
<cfelse>
	<cfset Request.HOTImage = " ">
</cfif>



