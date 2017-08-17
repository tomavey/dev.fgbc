<cfparam name="handbookpeople" type="query">
<cfset previousid = 0>
<cfset count = 0>
--
<ul>
<cfoutput query="handbookpeople">
	<cfif id NEQ previousid>
		<li>#linkto(text="#lname#, #fname# <i>#spouse#</i>: #city#, #state_mail_abbrev#", controller="handbook.people", action="show", key=id)# #addTag(controller='Handbook.AgbmInfo', action="add", id=id)#
		</li>
	</cfif>
<cfset previousid = id>
<cfset count = count +1>
</cfoutput>
</ul>
<cfoutput>
<p>Count= #count#</p>
</cfoutput>
**
