<cfoutput>

<h1>#getQuestion("editheader")#</h1>


#includePartial("reload")#
#includePartial("showFlash")#

</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		
		
		<cfif isFellowshipCouncil()>
			#includePartial("form0")#
		</cfif>	
			#includePartial("form1")#
			#includePartial("form2")#
			#includePartial("form3")#
			#includePartial("form4")#
			#includePartial("form5")#
			#includePartial("form6")#

			<cfif isFellowshipCouncil() || gotRights("superadmin,office,handbookedit")>
				#includePartial("form7")#
			</cfif>

			#submitTag(trim(stripTags(getQuestion("submitedit"))))#
				
			#endFormTag()#
			
		
<cfif isFellowshipCouncil()>
	#linkTo(text="Return to the listing", action="index")#
</cfif>

</cfoutput>
