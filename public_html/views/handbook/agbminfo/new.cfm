<cfparam name="formAction" default="create">
<div class="span11">
<h2>Create a new Inspire payment for <cfoutput>#thisperson.fname# #thisperson.lname# of #thisperson.city#, #thisperson.state_mail_abbrev#</cfoutput>:</h2>

<cfoutput>

			#errorMessagesFor("handbookagbminfo")#
	
			#startFormTag(action=formAction)#
		
				<cfif isDefined("params.key")>
						#hiddenFieldTag(name="handbookagbminfo[personid]", value=params.key)#
				<cfelse>
						#select(objectName='handbookagbminfo', property='personid', label='Person: ', options=people)#
				</cfif>				
					
			#includePartial(partial="form")#					

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", controller="Handbookagbm", action="index")#
<p>#linkTo(text="Add Lifetime Membership to Handbook Record", controller="Handbook.people", action="edit", key=#params.keyy#, target="_new")#</p>

</cfoutput>
</div>