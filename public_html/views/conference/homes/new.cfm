<cfparam name="formaction" default="create">
<div class="container" style="background-color:white;padding:20px;border-radius:10px">
<cfoutput>

	<cfif gotRights("office")>
		<p class="pull-right">
			#linkto(text="<i class='fa fa-pencil-square'></i>", controller="admin.contents", action="edit", key="#getContent('accessHost').id#")#
		</p>
	</cfif>

	<p>#getContent('accessHost').content#</p>


	#includePartial("showFlash")#

				
				#errorMessagesFor("home")#
		
				#startFormTag(action=formaction)#
			
				#includePartial("form")#				
																	
				#submitTag(class="btn btn-primary btn-lg btn-block")#
					
				#endFormTag()#
				
			

	#linkTo(text="Return to the listing", action="index")#

</cfoutput>
</div>
