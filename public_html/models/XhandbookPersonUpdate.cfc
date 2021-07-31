<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("handbook_people_updates")>
		<cfset belongsTo(name="handbookState", foreignKey="stateid")>
		<cfset property(name="alpha", sql="left(lname,1)")>
		<cfset property(
			name="selectName", 
			sql="CONCAT_WS(', ',lname,fname,city,state_mail_abbrev)"
			)>
	</cffunction>

</cfcomponent>