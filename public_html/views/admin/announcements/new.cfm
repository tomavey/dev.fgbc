<cfoutput>

<div class="container">

	<h1>Create new announcement</h1>


		#errorMessagesFor("announcement")#

		#startFormTag(action="create", multipart="true")#
	
		#includePartial(partial="form")#	

		#submitTag()#
			
		#endFormTag()#
				

	#linkTo(text="Return to the listing", action="index")#

	#expandpath('.')#/images/announcements/

</div>

</cfoutput>
