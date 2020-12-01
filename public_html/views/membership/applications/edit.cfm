<cfoutput>

<h1>#getQuestion("editheader")#</h1>


#includePartial(partial="reload")#
#includePartial(partial="showFlash")#

</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		
		
		<cfif isFellowshipCouncil()>
			#includePartial(partial="form0")#
		</cfif>	
			#includePartial(partial="form1")#
			#includePartial(partial="form2")#
			#includePartial(partial="form3")#
			#includePartial(partial="form4")#
			#includePartial(partial="form5")#
			#includePartial(partial="form6")#

			<cfif isFellowshipCouncil() || gotRights("superadmin,office,handbookedit")>
				#includePartial(partial="form7")#
			</cfif>

			#submitTag(trim(stripTags(getQuestion("submitedit"))))#
				
			#endFormTag()#
			
		
<cfif isFellowshipCouncil()>
	#linkTo(text="Return to the listing", action="index")#
</cfif>

</cfoutput>
