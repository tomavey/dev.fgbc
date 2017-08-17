<cffunction name="optionslist">
<cfargument name="optionslist" default="Select...,10,9,8,7,6,5,4,3,2,1">
<cfset var loc=structNew()>
	<cfset loc.optionslist = arguments.optionslist>
	<cfsavecontent variable="loc.optionslist">
		<cfoutput>
			<cfloop list="#loc.optionslist#" index="loc.i">
				<option value="#loc.i#">#loc.i#</option>
			</cfloop>
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.optionslist>
</cffunction>

<cffunction name="radiolist">
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.radiolist">
		1<cfinput type="radio" name="#attributes.fieldname#" value="1">
		2<cfinput type="radio" name="#attributes.fieldname#" value="2">
		3<cfinput type="radio" name="#attributes.fieldname#" value="3">
		4<cfinput type="radio" name="#attributes.fieldname#" value="4">
		5<cfinput type="radio" name="#attributes.fieldname#" value="5">
		6<cfinput type="radio" name="#attributes.fieldname#" value="6">
		7<cfinput type="radio" name="#attributes.fieldname#" value="7">
		8<cfinput type="radio" name="#attributes.fieldname#" value="8">
		9<cfinput type="radio" name="#attributes.fieldname#" value="9">
		10<cfinput type="radio" name="#attributes.fieldname#" value="10">
	</cfsavecontent>
<cfreturn loc.radiolist>	
</cffunction>