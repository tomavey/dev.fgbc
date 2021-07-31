<cfoutput>			
	<cfif isdefined("params.key") || isDefined("params.churchid")>			
		#hiddenField(objectName='handbookstatistic', property='organizationid')#
	<cfelse>
		#select(objectName='handbookstatistic', property='organizationId', label='Organization: ', options=organizations, textField="selectnamecity")#
	</cfif>	
	

	<cfif !isBefore("2022-01-01") || isDefined("params.showAttField")>
			#textField(objectName='handbookstatistic', property='ss', label='Average Weekly Small group involvement: ', class="tooltiptop", title="How many people where regularly involved in small groups in #handbookstatistic.year#")#
	</cfif>
					
	#textField(objectName='handbookstatistic', property='conversions', label='1. Were there any conversions recorded in 2020 that we can celebrate with you? If so, how many? ', class="tooltiptop", title="How many first-time professions of faith (salvation) in #handbookstatistic.year#")#
					
	#textField(objectName='handbookstatistic', property='baptisms', label='2. Were you able to celebrate any baptisms during 2020? If so, how many? ', class="tooltiptop", title="How many baptisms in #handbookstatistic.year#")#
					
	#textField(objectName='handbookstatistic', property='members', label='3. What was your total membership number as of December 31, 2020? ', class="tooltiptop", title="How many members did you have on December 31, #handbookstatistic.year#")#

	#textArea(
		objectName='handbookstatistic', 
		property='celebrate', 
		label='4. Please share something exciting that God has done through the ministry of your church during 2020 
	that we can praise God and celebrate together with you. ', 
		class='span10'
	)#

	#textArea(
		objectName='handbookstatistic', 
		property='assist', 
		label='5. Is there a challenge, concern, or opportunity that your church is facing that the Fellowship Office 
		should be aware of or can assist you with?', 
		class='span10'
	)#

	#textArea(
		objectName='handbookstatistic', 
		property='pray', 
		label='6. How best can we best pray for you and your church?', 
		class='span10'
	)#

	<h3>Fellowship Fee & Donations:</h3>

	<cfif val(handbookstatistic.attyear)>
		<cfset attLabel = '7. Average Weekly Attendance for #handbookstatistic.attyear#: '>
	<cfelse>	
		<cfset attLabel = '7. Average Weekly Attendance for 2019 : '>
	</cfif>

	#textField(objectName='handbookstatistic', property='att', label=attLabel, class="tooltiptop", title="Your church's average weekly attendance in 2019")#

	<div class="vueApp">
		#textField(objectName='handbookstatistic', property='donate', label='8. Would your church be willing to donate some additional funds to help Charis Churches having difficulty covering their fellowship fee this year? If so, please provide the desired donation amount below. ($50...$75...$100...$250...$500... more?)', placeholder="Donation: Must be a number")#

		#textField(objectName='handbookstatistic', property='relief', label='9. Would you be interested in providing any funds for the Charis Fellowship COVID Emergency Relief Fund?  So far $12,000 has been distributed to help churches in need. If so, please provide the desired donation amount below ($100...$250... $500...$1000...$5000...more?):', placeholder="Relief: Must be a number")#

	</div>
	<!--- #select(objectName="handbookstatistic", property="churchplanting", label="Are you planning to start a new church?", options="NA,No,Yes", class="input-small")#

	#textField(objectName="handbookstatistic", property="churchplantingcontact", label="Who (name and email) can we contact for information about this new church?", class="tooltiptop", title="Who can we call?")# --->

	<cfif params.action is "submit">
		#hiddenField(objectName='handbookstatistic', property='year')#
		#hiddenField(objectName='handbookstatistic', property='date')#
	<cfelse>		

		#textField(objectName='handbookstatistic', property='year', label='Stats Year: ')#

		#textField(objectName='handbookstatistic', property='memfee', label='Memfee: ')#
						
		#textField(objectName='handbookstatistic', property='checkno', label='Checkno: ')#

		Date:#dateSelect(objectName='handbookstatistic', property='date', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#

	</cfif>				
	
	#textField(objectName='handbookstatistic', property='submittedBy', label='Submitted By', class="tooltiptop", title="Who is filling out this form.")#
					
	<cfif params.action is NOT "submit">
		#textField(objectName='handbookstatistic', property='enteredBy', label='Entered By')#
	</cfif>					

	#textArea(objectName='handbookstatistic', property='comment', label='Comments')#
					
</cfoutput>

<script>
	var app = new Vue({
		el: ".vueApp",
		data() {
			return {
				message: "working"
			}
		},
		methods: {
			clickField: function() {
				alert("clicked")
			}
		}
	})
</script>