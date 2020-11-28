<cfif not isDefined("params.open")>
	<h2 class="alert alert-info">
		If you have children older than 6th grade and already filled out a form requesting that they work in Grace Kids, thanks so much.  We will contact you if we need you.  However, we have more than enough applications and are not accepting new apps.
	</h2>
<cfelse>
	<div id="gracekidsworkerapp">
		<h1>Grace Kids Helper Application</h1>
		<h2 class="alert alert-info">
		Teens older than 13 are elligible to help in Grace Kids.  Use this form to notify us of your interest. <br/>  We will let you know if we can use you in Grace Kids.
		</h2>
		<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

		<cfoutput>

		#ckeditor()#

					#errorMessagesFor("childcareworkers")#

					#startFormTag(action="create")#

					#includePartial(partial="form")#

					#submitTag()#

					#endFormTag()#

		</cfoutput>
	</div>
</cfif>