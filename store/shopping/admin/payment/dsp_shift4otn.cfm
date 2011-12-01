<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Shift4 $$$ ON THE NET processing. Called from dsp_process.cfm --->


<cfparam name="attributes.TestConnectivity" default="NO">
<cfinclude template="../../checkout/creditcards/qry_get_Shift4OTN_Settings.cfm">

<cfoutput>
		<tr>
			<td colspan="3" align="center" class="formtitle">
				$$$ ON THE NET Payment Processing<br/>
				<cfif get_Shift4OTN_Settings.SerialNumber NEQ 0
					and get_Shift4OTN_Settings.Username is not ""
					and get_Shift4OTN_Settings.Password is not ""
					and get_Shift4OTN_Settings.URL is not ""
					and get_Shift4OTN_Settings.MID NEQ 0
					and (get_Shift4OTN_Settings.FunctionRequestCode is "1B" or get_Shift4OTN_Settings.FunctionRequestCode is "1D")>
					<font size="-2" class="m2">(click <a href="//#CGI.HTTP_HOST##CGI.PATH_INFO#?fuseaction=shopping.admin&payment=process&testconnectivity=yes">here to test</a> connectivity)</font><br/>
				</cfif>
				<br/>
			</td>
		</tr>

		<cfif attributes.TestConnectivity is "YES">
			<cfmodule
				template="../../checkout/creditcards/shift4otn.cfm"
				Result = "OTN"
				URL = "#get_Shift4OTN_Settings.URL#"
				ProxyServer="#get_Shift4OTN_Settings.ProxyServer#"
				ProxyPort="#get_Shift4OTN_Settings.ProxyPort#"
				ProxyUsername="#get_Shift4OTN_Settings.ProxyUsername#"
				ProxyPassword="#get_Shift4OTN_Settings.ProxyPassword#"
				SerialNumber = "#get_Shift4OTN_Settings.SerialNumber#"
				Username = "#get_Shift4OTN_Settings.Username#"
				Password = "#get_Shift4OTN_Settings.Password#"
				FunctionRequestCode = "0B"
				MerchantID = "#get_Shift4OTN_Settings.MID#"
				APIOptions="ALLDATA,FULLNAME"
				Vendor="CFWebStore6">
			<cfif OTN.ErrorIndicator is "Y">
				<tr>
					<td align="RIGHT">Error Response</td>
					<td></td>
					<td>#OTN.LongError# (#OTN.PrimaryErrorCode#,#OTN.SecondaryErrorCode#)</td>	
				</tr>
				<tr>
					<td align="RIGHT">Test Results</td>
					<td></td>
					<td><strong><font color="##FF0000">FAILED!</font></strong></td>	
				</tr>
			<cfelse>
				<tr>
					<td align="RIGHT">Merchant Name</td>
					<td></td>
					<td><cfif IsDefined("OTN.Notes") and OTN.Notes is not "">#OTN.Notes#<cfelse>#OTN.DBA#</cfif></td>	
				</tr>
				<tr>
					<td align="RIGHT">Test Results</td>
					<td></td>
					<td><strong>PASSED!</strong></td>	
				</tr>
			</cfif>
			<tr><td colspan="3">&nbsp;</td></tr>
		</cfif>
		
		<tr>
			<td align="RIGHT">Account Number <font size="-2"><br/>(issued by Shift4)</font> </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="SerialNumber" value="#get_Shift4OTN_Settings.SerialNumber#" size="20" maxlength="10" class="formfield"/>
			</td>	
		</tr>

		<tr>
			<td align="RIGHT">API User Name </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Username" value="#get_Shift4OTN_Settings.Username#" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>

		<tr>
			<td align="RIGHT">Password <font size="-2"><br/>(CASE sensitive)</font> </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="Password" name="Password" value="***same/same***" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Host Addresses <font size="-2"><br/>(comma separated)</font> </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="CCServer" value="#get_Shift4OTN_Settings.URL#" size="50" maxlength="150" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Merchant ID <font size="-2"><br/>(issued by Shift4)</font> </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="MID" value="#get_Shift4OTN_Settings.MID#" size="20" maxlength="10" class="formfield"/>
			</td>	
		</tr>

		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><strong>IMPORTANT NOTE:</strong> The best setting for most web stores, and the required setting for web stores that ship physical goods, the following Transaction Type option should be set to AUTH and the 'Use Billing Tab' option in the Payment Options should be ENABLED. Web stores that sell subscriptions, services or downloadables, this option can be set to SALE and the 'Use Billing Tab' option can be DISABLED but by using these settings, you will loose the order details in $$$ ON THE NET.<br /><br /></td>
		</tr>
		<tr>
			<td align="RIGHT">Transaction Type </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Transtype" size="1" class="formfield">
	   		<option value="1B" #doSelected(get_Shift4OTN_Settings.FunctionRequestCode,'1B')#>AUTH -- Authorize only</option>
			<option value="1D" #doSelected(get_Shift4OTN_Settings.FunctionRequestCode,'1D')#>SALE -- Immediate auth &amp; capture</option>
			</select>
			</td>	
		</tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><strong>Proxy Server Settings:</strong> These settings are optional and only required if your web server uses a proxy server for outbound communication. Most web servers do not use proxy servers. Leave Server Name blank if unused. Contact your ISP or system administrator if you are not sure.<br /><br /></td>
		</tr>
		<tr>
			<td align="RIGHT">Proxy Server </td>
			<td></td>
			<td>
			<input type="text" name="ProxyServer" value="#get_Shift4OTN_Settings.ProxyServer#" size="50" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		<tr>
			<td align="RIGHT">Proxy Port </td>
			<td></td>
			<td>
			<input type="text" name="ProxyPort" value="#get_Shift4OTN_Settings.ProxyPort#" size="8" maxlength="8" class="formfield"/>
			</td>	
		</tr>
		<tr>
			<td align="RIGHT">Proxy User Name </td>
			<td></td>
			<td>
			<input type="text" name="ProxyUsername" value="#get_Shift4OTN_Settings.ProxyUsername#" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		<tr>
			<td align="RIGHT">Proxy Password </td>
			<td></td>
			<td>
			<input type="Password" name="ProxyPassword" value="***same/same***" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td colspan="3"><strong>Extended User Settings</strong> The following settings are extended functionality available to the $$$ ON THE NET gateway because it uses &ldquo;Tokenization&rdquo; technology whereby tokens are stored in the place of card number in the store database. These options affect how the card number is added or updated for a user account.<br /><br /></td></tr>
		<tr>
			<td align="RIGHT">Allow Card Edit</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
				<input name="UserCCardEdit" type="radio" value="1" <cfif get_Shift4OTN_Settings.UserCCardEdit>checked </cfif>/>Yes
				<input name="UserCCardEdit" type="radio" value="0" <cfif not get_Shift4OTN_Settings.UserCCardEdit>checked </cfif>/>No</td>	
		</tr>
		<tr>
			<td align="RIGHT">Allow Card Delete</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
				<input name="UserCCardDelete" type="radio" value="1" <cfif get_Shift4OTN_Settings.UserCCardDelete>checked </cfif>/>Yes
				<input name="UserCCardDelete" type="radio" value="0" <cfif not get_Shift4OTN_Settings.UserCCardDelete>checked </cfif>/>No</td>	
		</tr>
		<tr>
			<td align="RIGHT">On-The-Fly Card Update</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
				<input name="UserCCardOnTheFlyUpdate" type="radio" value="1" <cfif get_Shift4OTN_Settings.UserCCardOnTheFlyUpdate>checked </cfif>/>Yes
				<input name="UserCCardOnTheFlyUpdate" type="radio" value="0" <cfif not get_Shift4OTN_Settings.UserCCardOnTheFlyUpdate>checked </cfif>/>No</td>	
		</tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><strong>ADDITIONAL NOTES:</strong> This $$$ ON THE NET driver uses &ldquo;Tokenization&rdquo; technology developed by Shift4 Corporation. To comply with <a href="https://www.pcisecuritystandards.org/pdfs/pci_dss_v1-1.pdf" target="_blank">Payment Card Industry (PCI)</a> security standards and <a href="http://usa.visa.com/merchants/risk_management/cisp_payment_applications.html" target="_blank">Payment Applications Best Practices (PABP)</a>, this driver stores tokens instead of actual credit card information. For this driver the &lsquo;Store Card Info&rsquo; option in the Payment Options can and should be ENABLED and the software will maintain full compliance compliance with the regulations and no security will be sacrificed. For PCI and PABP compliance, you MUST use 128 bit SSL certificates and the associated HTTPS protocol when transferring pages with any credit card information.<p>For additional information on tokenization, see Shift4's web site: <a href="http://www.shift4.com/tokenization.htm" target="_blank">http://www.shift4.com/tokenization.htm</a></p></td>
		</tr>
</cfoutput>