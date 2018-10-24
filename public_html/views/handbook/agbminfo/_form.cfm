<cfoutput>
		  <cfif gotRights("superadmin,agbmadmin")>
						#textField(objectName='handbookagbminfo', property='personid', label='Member ID## <p style="font:size.8em;color:gray;margin-left:15px">Be careful with the member id##. Most of the time it will not need to change.</p>')#
		  </cfif>
						#textField(objectName='handbookagbminfo', property='membershipFee', label='Membership Fee')#
					
						#textField(objectName='handbookagbminfo', property='membershipFeeYear', label='Membership Fee Year')#
					
						#select(objectName='handbookagbminfo', property='category', label='Category', options="1,2,3")#
					
						#checkBox(objectName='handbookagbminfo', property='ordained', label='Ordained?')#
					
						#checkBox(objectName='handbookagbminfo', property='licensed', label='Licensed?')#
					
						#checkBox(objectName='handbookagbminfo', property='mentored', label='Being Mentored?')#

						Date Paid: #dateSelect(objectName='handbookagbminfo', property='paidAt', class="input-small")#
					
						#select(objectName='handbookagbminfo', property='organizationId', label='Church (if different than what is listed in the handbook): ', options=organizations, textField="selectNameCity", includeBlank="-options-" )#
					
						#textArea(objectName='handbookagbminfo', property='comments', label='Comments', class="input-xlarge")#
</cfoutput>