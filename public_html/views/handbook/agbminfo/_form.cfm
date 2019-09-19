<cfparam name="oldform" default = false>
<cfif isDefined("params.oldform")>
	<cfset oldform = true>
</cfif>
<cfoutput>

			<p style="float:right">
				<cfif !oldform>
					#linkTo(text="Show old form with categories", controller="handbook.AgbmInfo", action=params.action, key=params.key, params="oldform=", class="btn")#
				<cfelse>		
					#linkTo(text="Show form with commissions", controller="handbook.AgbmInfo", action=params.action, key=params.key, params="", class="btn")#
				</cfif>
			</p>

			<cfif gotRights("superadmin,agbmadmin") && !isDefined("params.key")>
						#textField(objectName='handbookagbminfo', property='personid', label='Member ID## <p style="font:size.8em;color:gray;margin-left:15px">Be careful with the member id##. Most of the time it will not need to change and you can leave this blank.</p>')#
		  </cfif>
						#textField(objectName='handbookagbminfo', property='membershipFee', label='Membership Fee')#
					
						#textField(objectName='handbookagbminfo', property='membershipFeeYear', label='Membership Fee Year')#
					
						#checkBox(objectName='handbookagbminfo', property='ordained', label='Ordained?')#
					
					<cfif oldform>
						#checkBox(objectName='handbookagbminfo', property='licensed', label='Licensed?')#
					<cfelse>	
						#checkBox(objectName='handbookagbminfo', property='commissioned', label='Commissioned?')#
					</cfif>	

					<cfif oldform>
						#select(objectName='handbookagbminfo', property='category', label='Category:', options=getSetting('inspireCategories'), includeBlank=true)#
					<cfelse>	
						#select(objectName='handbookagbminfo', property='commission', includeBlank=true, label='Commissioned...', options=getSetting('inspireCommissions'))#
					</cfif>	

					
						<!--- #checkBox(objectName='handbookagbminfo', property='mentored', label='Being Mentored?')# --->

						Date Paid: #dateSelect(objectName='handbookagbminfo', property='paidAt', class="input-small")#
					
						#select(objectName='handbookagbminfo', property='organizationId', label='Church (if different than what is listed in the handbook): ', options=organizations, textField="selectNameCity", includeBlank="-options-" )#
					
						#textArea(objectName='handbookagbminfo', property='comments', label='Comments', class="input-xlarge")#
</cfoutput>