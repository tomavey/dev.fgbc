<div id="newchurch">
<h1>Welcome!</h1>

<div class="well">
	The Fellowship of Grace Brethren Churches is focused on Church Planting, Leadership Training and Integrated Ministry. Your new church is very important to us. We may even be able to help with networking, prayer and possibly financial support.  If your new church is in the USA or Canada, please use this simple form to let us know about your church.
</div>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("newchurch")#
	
			#startFormTag(action=formaction, key=params.key)#

			#putFormTag()#		

			#includePartial("form")#	
															
			#submitTag()#
				
			#endFormTag()#
			
		
<cfif isOffice()>
#linkTo(text="Return to the listing", action="index")#
</cfif>
</cfoutput>
</div>
