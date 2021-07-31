<cfparam name="birthdaysSorted" type="query">
<cfset count = 1>
<cfoutput query="birthdaysSorted" group="birthMonth">
<h3>#monthAsString(birthMonth)#</h3>
<cfoutput>
#birthDay# - 
#linkTo(text=fullname, 
		action="show", 
		key=personid,
		class="tooltip2 ajaxclickable", 
		title="Click to show #fullname# in the center panel.", 
		onlyPath=false
)#<br/>
<cfset count = count + 1>
</cfoutput>
</cfoutput>
<cfoutput>
<p>
Count = #count#</p>
</cfoutput>