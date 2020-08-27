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

	<cfscript>
		function findRecentFocusRegistrants( required string regIds ) {
			var loc = arguments
			cfquery( name="loc.focuspeople", datasource=application.wheels.datasourcename ) {
		
				writeOutput("SELECT fname, lname, p.email
					FROM focus_registrants p
					JOIN focus_registrations r
						ON r.registrantid = p.id
					JOIN focus_items i
						ON r.itemid = i.id
					JOIN focus_retreats s
						ON i.retreatid = s.id
					WHERE s.regid IN (#arguments.regIds#)
					ORDER BY lname,fname,email")
			}
			return loc.focuspeople
		}
	</cfscript>	
		
</cfcomponent>