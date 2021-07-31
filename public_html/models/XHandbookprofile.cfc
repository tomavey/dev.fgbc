<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset belongsTo(name="Handbookperson", foreignKey="personid")>

		<cfset property(
			name="birthdayDayNumber",
			sql="day(birthdayasstring)"
			)>	
		<cfset property(
			name="birthdayMonthNumber",
			sql="month(birthdayasstring)"
			)>	
		<cfset property(
			name="birthdayWeekNumber",
			sql="week(birthdayasstring)"
			)>	
		<cfset property(
			name="birthdayDayOfYearNumber",
			sql="dayofyear(birthdayasstring)"
			)>	

		<cfset property(
			name="wifesBirthdayDayNumber",
			sql="day(wifesbirthdayasstring)"
			)>	
		<cfset property(
			name="wifesBirthdayMonthNumber",
			sql="month(wifesbirthdayasstring)"
			)>	
		<cfset property(
			name="wifesBirthdayWeekNumber",
			sql="week(wifesbirthdayasstring)"
			)>	
		<cfset property(
			name="wifesBirthdayDayOfYearNumber",
			sql="dayofyear(wifesbirthdayasstring)"
			)>	

		<cfset property(
			name="anniversaryDayNumber",
			sql="day(anniversaryasstring)"
			)>	
		<cfset property(
			name="anniversaryMonthNumber",
			sql="month(anniversaryasstring)"
			)>	
		<cfset property(
			name="anniversaryWeekNumber",
			sql="week(anniversaryasstring)"
			)>	
		<cfset property(
			name="anniversaryDayOfYearNumber",
			sql="dayofyear(anniversaryasstring)"
			)>	
			

	</cffunction>
	
	<cffunction name="fixDates">

			  <cfif len(handbookprofile.birthdayasstring)>
			  		<cfset handbookprofile.birthdayasstring = dateformat(handbookprofile.birthdayasstring,"yyyy-mm-dd")> 
			  </cfif>	
			  <cfif len(anniversaryastring)>
			  		<cfset handbookprofile.anniversaryasstring = dateformat(handbookprofile.anniversaryastring,"yyyy-mm-dd")> 
			  </cfif>	
			  <cfif len(wifesbirthdayasstring)>
			  		<cfset handbookprofile.wifesbirthdayasstring = dateformat(handbookprofile.wifesbirthdayasstring,"yyyy-mm-dd")> 
			  </cfif>	

	</cffunction>

</cfcomponent>
