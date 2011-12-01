
<!---

	iCCVerify Tag v1.2
 
  The author, which can be reached at swang@bigfoot.com or http://customtags.mine.nu
  grants you ("Licensee") a non-exclusive, royalty free, license to use in CFWebstore, this 
  software in source and unencrypted form,  provided that i) this copyright notice and license 
  appear on all copies of the software; and ii) Licensee does not resell this tag for other 
  purposes without consent.
 
  This software is provided "AS IS," without a warranty of any kind. ALL EXPRESS
  OR IMPLIED CONDITIONS, REPRESENTATIONS AND WARRANTIES, INCLUDING ANY
  IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR
  NON-INFRINGEMENT, ARE HEREBY EXCLUDED. THE AUTHOR AND ITS LICENSORS SHALL NOT BE
  LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING, MODIFYING
  OR DISTRIBUTING THE SOFTWARE OR ITS DERIVATIVES. IN NO EVENT WILL THE AUTHOR OR ITS
  LICENSORS BE LIABLE FOR ANY LOST REVENUE, PROFIT OR DATA, OR FOR DIRECT,
  INDIRECT, SPECIAL, CONSEQUENTIAL, INCIDENTAL OR PUNITIVE DAMAGES, HOWEVER
  CAUSED AND REGARDLESS OF THE THEORY OF LIABILITY, ARISING OUT OF THE USE OF
  OR INABILITY TO USE SOFTWARE, EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGES.
 
  This software is not designed or intended for use in on-line control of
  aircraft, air traffic, aircraft navigation or aircraft communications; or in
  the design, construction, operation or maintenance of any nuclear
  facility; or in a medical setting where patient health is crucial, where 
  critical care is essential.   Licensee represents and warrants that it 
  will not use or  redistribute the Software for such purposes.
  
--->

<cfparam name="attributes.CCOrderNum" default = "">
<cfparam name=" caller.CCErrorMessage" default = "">

<cfset CCNumber = REReplace(attributes.CCOrderNum, "[^[:digit:]]", "", "ALL")>

<cfset caller.CCType = "??">
<cfset caller.CCValidLuhn = "NO">
<cfset caller.CCLen = Len(CCNumber)>

<cfset total=0>
<cfset product=0>
<cfset multiplier = 1>

<!--- Product Digit Add ---->
<cfloop from="#len(ccnumber)#" to="1" index="i" step=-1>
	<cfset product = multiplier * mid(ccnumber, i, 1)>		
	<cfloop from="1" to="#len(product)#" index="j">
		<cfset total = total + mid(product, j, 1)>
	</cfloop>		
	<cfif isdefined('attributes.CCDebug')><cfoutput>#multiplier# * #mid(OrderCCNum, i, 1)#</cfoutput> = <cfoutput>#product#</cfoutput> - <cfoutput>#total#</cfoutput><br/></cfif>								
	<cfset multiplier = 3 - multiplier>
</cfloop>
<!--- End Product Digit Add ---->

<!--- Mod 10 verification --->
<cfif total MOD 10 IS 0>
	<cfset caller.CCValidLuhn = "YES">
<!--- Its good ---->
	<cfif Left(trim(CCNumber),1) is 4 AND (Len(CCNumber) Is 13 OR Len(CCNumber) Is 16)>
		<cfset caller.CCType="VISA">
	<cfelseif Left(trim(CCNumber),2) GTE 51 AND Left(trim(CCNumber),2) LTE 55 AND Len(CCNumber) Is 16>
		<cfset caller.CCType="MC">
	<cfelseif Left(trim(CCNumber),4) Is 6011 AND Len(CCNumber) Is 16>
		<cfset caller.CCType="NOVUS">
	<cfelseif Left(trim(CCNumber),2) Is 34 OR Left(trim(CCNumber),2) IS 37 AND Len(CCNumber) Is 15>
		<cfset caller.CCType="AMEX">
	<cfelseif Left(trim(CCNumber),4) Is 2131 OR left(trim(CCNumber), 4) is 1800 AND LEN(CCNumber) IS 15>
		<cfset caller.cctype="JCB">
	<cfelseif left(trim(CCNumber), 1)	is 3 AND len(CCNumber) is 16>
		<cfset caller.cctype="JCB">
	<cfelseif Left(trim(CCNumber),3) GTE 300 AND Left(trim(CCNumber),3) LTE 305 AND len(CCNumber) is 14>
		<cfset caller.cctype="Diners Club/Carte Blanche">
	<cfelseif left(trim(CCNumber),2) IS 36 OR left(trim(CCNumber), 2) IS 38 AND len(CCNumber) is 14>
		<cfset caller.cctype = "Diners Club/Carte Blanche">	
	<cfelseif left(trim(CCNumber),4) IS 2014 OR left(trim(ccnumber), 4) IS 2149 AND len(CCnumber) is 15>
		<cfset caller.cctype = "enRoute">	
	</cfif>
</cfif>					
<!--- End Mod 10 verification --->

<cfif isdefined('attributes.CCDebug')><cfoutput>#CCType#</cfoutput></cfif>
	

