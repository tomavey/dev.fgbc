<h1>FGBC Membership Application</h1>

<div class="well">
General Instructions:  Fill out this application form. The deadline for application is January 1st in order to be considered in the following annual conference.  If you wish to request an extension of this deadline, include a letter of reference from a cooperating district missions board, a sponsoring church that is already a member of the FGBC.
</div>

<cfoutput>
	#ckeditor()#
	#includePartial(partial="showFlash")#
</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form0")#
			#includePartial(partial="form1")#
			#includePartial(partial="form2")#
			#includePartial(partial="form3")#
			#includePartial(partial="form4")#

			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
