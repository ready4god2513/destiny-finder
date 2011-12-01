<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used for outputting the average rating for a product and is called by dsp_reviews_inline.cfm --->
<cfoutput>
Average Customer Rating: <img src="#request.appsettings.defaultimages#/icons/#round(qry_prod_reviews.Avg_Rating)#_lg_stars.gif" alt="" />
(<cfif qry_prod_reviews.Avg_Rating gt 4>Excellent<cfelseif qry_prod_reviews.Avg_Rating gt 3>Very Good<cfelseif qry_prod_reviews.Avg_Rating gte 2>Average<cfelseif qry_prod_reviews.Avg_Rating gte 1>Below Average<cfelseif qry_prod_reviews.Avg_Rating gt 0>Poor<cfelse>Not Ranked</cfif>) 
based on #qry_prod_reviews.recordcount# review<cfif qry_prod_reviews.recordcount neq 1>s</cfif><br/>
</cfoutput>