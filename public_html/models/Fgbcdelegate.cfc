<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset
			validatesFormatOf(
			properties="submitteremail",
			message="Please provide a valid email address for yourself."
			)
		>
		<cfset
			validatesPresenceOf(
			properties="submitteremail",
			type="email",
			message="Your email address cannot be empty."
			)
		>
		<cfset property(
			name="yearfor",
			sql="year(fgbcdelegates.createdAt)"
			)
		>

		<cfset belongsTo(name="Handbookorganization", foreignKey="churchid")>

	</cffunction>

</cfcomponent>
