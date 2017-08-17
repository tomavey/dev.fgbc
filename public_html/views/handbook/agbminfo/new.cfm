<h2>Create a new agbm payment for <cfoutput>#thisperson.fname# #thisperson.lname# of #thisperson.city#, #thisperson.state_mail_abbrev#</cfoutput>:</h2>

<cfoutput>

			#errorMessagesFor("handbookagbminfo")#
	
			#startFormTag(action="create")#
		
				<cfif isDefined("params.key")>
						#hiddenFieldTag(name="handbookagbminfo[personid]", value=params.key)#
				<cfelse>
						#select(objectName='handbookagbminfo', property='personid', label='Person: ', options=people)#
				</cfif>				
					
			#includePartial("form")#					

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", controller="Handbookagbm", action="index")#
</cfoutput>
