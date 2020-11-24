<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset belongsTo(name="Handbookperson", foreignKey="personid")>
		
		<cfset beforeUpdate("createDatesAsString")>
		<cfset beforeCreate("createDatesAsString")>
		<cfset afterFind("convertDatesAsString")>

		<cfset property(
			name="birthdayWeekNumber",
			sql="week(birthdayasstring)"
			)>	
		<cfset property(
			name="birthdayDayOfYearNumber",
			sql="dayofyear(birthdayasstring)"
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
			name="anniversaryWeekNumber",
			sql="week(anniversaryasstring)"
			)>	
		<cfset property(
			name="anniversaryDayOfYearNumber",
			sql="dayofyear(anniversaryasstring)"
			)>	
			

	</cffunction>
	
	<cffunction name="createDatesAsString">

		<cfif !len(this.birthdayYear)>
			<cfset this.birthdayYear = 1900>
		</cfif>
		<cfif !len(this.anniversaryYear)>
			<cfset this.anniversaryYear = 1900>
		</cfif>
		<cfif !len(this.wifesbirthdayYear)>
			<cfset this.wifesbirthdayYear = 1900>
		</cfif>
			<cftry>
				<cfset this.birthday = CreateDate(this.birthdayYear, this.birthdayMonthNumber, this.birthdayDayNumber)>
			<cfcatch></cfcatch></cftry>	
			<cftry>
				<cfset this.anniversary = CreateDate(this.anniversaryYear, this.anniversaryMonthNumber, this.anniversaryDayNumber)>
			<cfcatch></cfcatch></cftry>	
			<cftry>
				<cfset this.wifesbirthday = CreateDate(this.wifesbirthdayYear, this.wifesbirthdayMonthNumber, this.wifesbirthdayDayNumber)>
			<cfcatch></cfcatch></cftry>	

			  <cfif isDefined("this.birthday") && len(this.birthday)>
			  		<cfset this.birthdayasstring = dateformat(this.birthday,"yyyy-mm-dd")> 
			  <cfelse>		
			  		<cfset this.birthdayasstring = ""> 
			  </cfif>	

			  <cfif isDefined("this.anniversary") && len(this.anniversary)>
			  		<cfset this.anniversaryasstring = dateformat(this.anniversary,"yyyy-mm-dd")> 
			  <cfelse>		
			  		<cfset this.anniversaryasstring = ""> 
			  </cfif>	

			  <cfif isDefined("this.wifesbirthday") && len(this.wifesbirthday)>
			  		<cfset this.wifesbirthdayasstring = dateformat(this.wifesbirthday,"yyyy-mm-dd")> 
			  <cfelse>		
			  		<cfset this.wifesbirthdayasstring = ""> 
			  </cfif>	

	</cffunction>
	
	<cffunction name="convertDatesAsString">
			  <cfif isDefined("this.birthdayAsString") and len(this.birthdayAsString)>
			  		<cfset this.birthday = this.birthdayAsString> 
			  </cfif>	
			  <cfif isDefined("this.anniversaryAsString") and len(this.anniversaryAsString)>
			  		<cfset this.anniversary = this.anniversaryasstring> 
			  </cfif>	
			  <cfif isDefined("this.wifesbirthdayAsString") and len(this.wifesbirthdayAsString)>
			  		<cfset this.wifesbirthday = this.wifesbirthdayasstring> 
			  </cfif>	
	</cffunction>

</cfcomponent>
