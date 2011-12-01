
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create the info for the top of the page. Call from your layout pages --->

 <!--- Change type to "Order" to show order-level discount instead --->
 
 <cfscript>
 	DiscountMess = Application.objDiscounts.dspDiscountMess(DiscType:'Store', class:'cat_text_list');
 	BasketSummary = Application.objCart.dspBasketStats();
	
	TopInfo = DiscountMess & BasketSummary;
 </cfscript>

<cfoutput>#HTMLCompressFormat(TopInfo)#</cfoutput>


			
			