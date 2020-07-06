<cfcomponent extends="Model" output="false">
	
	<cffunction name='init'>
		<cfset table('focus_registrants')>
		<cfset
			property(
			name="fullNameLastFirstID",
			sql="Concat(lname, ', ', fname, ' (', focus_registrants.id, ')')"
			)
		>
		<cfset
			property(
			name="fullNameLastFirst",
			sql="Concat(lname, ', ', fname)"
			)
		>
		<cfset hasMany(name='registrations', modelName="Focusregistration", foreignKey="registrantId")>
	</cffunction>

</cfcomponent>