<cfoutput>

<div class="container">


	<h1>Editing announcement</h1>


		#errorMessagesFor("announcement")#

		#startFormTag(action="update", key=params.key)#

		#putFormTag()#		

		#includePartial(partial="form")#	

		#submitTag()#
			
		#endFormTag()#
				

	#linkTo(text="Return to the listing", action="index")#

</div>

</cfoutput>
