<cfoutput>

<cfif isDefined("params.retreatId")>
	<h1>Create new item for #getRetreatRegId(params.retreatId)#</h1>
<cfelse>
	<h1>Create new item</h1>
</cfif>


			#errorMessagesFor("item")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#				

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
