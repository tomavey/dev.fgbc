<cfoutput>			
	<cfif isdefined("params.key") || isDefined("params.churchid")>			
		#hiddenField(objectName='handbookstatistic', property='organizationid')#
	<cfelse>
		#select(objectName='handbookstatistic', property='organizationId', label='Organization: ', options=organizations, textField="selectnamecity")#
	</cfif>	

	#textField(objectName='handbookstatistic', property='att', label='Average Weekly Attendance: ', class="tooltipside", title="Your churches average weekly attendance in #handbookstatistic.year#")#
					
	#textField(objectName='handbookstatistic', property='ss', label='Average Weekly Small group involvement: ', class="tooltipside", title="How many people where regularly involved in small groups in #handbookstatistic.year#")#
					
	#textField(objectName='handbookstatistic', property='conversions', label='Professions of faith (conversions): ', class="tooltipside", title="How first-time professions of faith (salvation) in in #handbookstatistic.year#")#
					
	#textField(objectName='handbookstatistic', property='baptisms', label='Total Baptisms: ', class="tooltipside", title="How many baptisms in #handbookstatistic.year#")#
					
	#textField(objectName='handbookstatistic', property='members', label='Total Number of Members: ', class="tooltipside", title="How many members did you have on December 31, #handbookstatistic.year#")#
					
	#select(objectName="handbookstatistic", property="churchplanting", label="Are you planning to start a new church?", options="NA,No,Yes", class="input-small")#

	#textField(objectName="handbookstatistic", property="churchplantingcontact", label="Who (name and email) can we contact about information about this new church?", class="tooltipside", title="Who can we call?")#

	<cfif params.action is "submit">
		#hiddenField(objectName='handbookstatistic', property='year')#
		#hiddenField(objectName='handbookstatistic', property='date')#
	<cfelse>		

		#textField(objectName='handbookstatistic', property='year', label='Stats Year: ')#

		#textField(objectName='handbookstatistic', property='memfee', label='Memfee: ')#
						
		#textField(objectName='handbookstatistic', property='checkno', label='Checkno: ')#

		Date:#dateSelect(objectName='handbookstatistic', property='date', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#

	</cfif>				
	
	#textField(objectName='handbookstatistic', property='submittedBy', label='Submitted By', class="tooltipside", title="Who is filling out this form.")#
					
	<cfif params.action is NOT "submit">
		#textField(objectName='handbookstatistic', property='enteredBy', label='Entered By')#
	</cfif>					

	#textArea(objectName='handbookstatistic', property='comment', label='Comments')#
					
</cfoutput>