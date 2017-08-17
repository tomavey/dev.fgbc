<cfparam name="testimonies" type="query">

<cfoutput>
<p>#linkTo(text="Add your Focus Retreat story", action="new", class="btn")#</p>
</cfoutput>

<cfoutput query="testimonies">
<div class="well">
#testimony#
<p>&nbsp;</p>
<p>Create on #dateformat(createdAt)# by #mailTo(emailaddress=email, name=email)#</p>
</div>
</cfoutput>
