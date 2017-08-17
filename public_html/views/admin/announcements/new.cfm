<cfoutput>

<div class="row-fluid well contentStart contentBg">

<div class="span12">

<h1>Create new announcement</h1>


			#errorMessagesFor("announcement")#
	
			#startFormTag(action="create", multipart="true")#
		
			#includePartial("form")#	

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#

#expandpath('.')#/images/announcements/

</div></div>

</cfoutput>
