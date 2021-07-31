<cfset previousPersonId = 0>
<cfset backgroundcolor = "##FFFFFF">
<cfset showShow= 0>
<cfoutput>
	<p><h3>This process will...</h3>
		<ol>
			<li>
				<em><b>Remove</b></em> from the membership list all who are NOT current on their membership fee.
			</li>
			<li>
				<em><b>Add</b></em> into the membership list all who ARE current on their membership fee.
			</li>
			<li>
				<em><b>Ensure</b></em> all that have been deleted from the membership list are place on the mailing list.
			</li>
		</ol>
	</p>
	<p>
	#linkTo(text="Are you ready?", action="snyc", confirm="Are you REALLY sure?", class="btn")#
	</p>
</cfoutput>
<h4>This will be the new membership list...</h4>
<ul>


<cfoutput query="members">
<cfif personid is previousPersonId>
  <cfset backgroundcolor = "##FFFF80">
  <cfset showShow = 1>
</cfif> 
	<li style="background-color:#backgroundcolor#">#fname# #lname#: #city#, #state_mail_abbrev# <cfif showShow>&nbsp;&nbsp;#showTag(personid)#</cfif></li>
<cfset backgroundcolor = "##FFFFFF">
<cfset previousPersonId = personid>	
<cfset showShow= 0>
</cfoutput>
<cfoutput>
<p>&nbsp;</p>
<p>Count: #members.recordcount#</p>
<p style="background-color:##FFFF80">Highlight indicates duplicate payments</p>
</cfoutput>
</ul>