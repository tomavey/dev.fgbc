<cfoutput>
<cfset dateInfo = structNew()>
<cfset dateInfo.date = '#params.dateType#asstring'>
<cfset dateInfo.date = evaluate(dateInfo.date)>
<cfset dateInfo.day = '#params.dateType#daynumber'>
<cfset dateInfo.day = evaluate(dateInfo.day)>
<cfset dateInfo.month = '#params.dateType#monthnumber'>
<cfset dateInfo.month = evaluate(dateInfo.month)>
<cfset dateInfo.thisyear = year(now())>
<cfset dateInfo.thisyeardate = createDate(dateinfo.thisyear,dateinfo.month,dateinfo.day)>
<cfset dateInfo.thisweek = week(dateInfo.thisyeardate)>
<cfset dateInfo.dayOfWeekAsString = dayOfWeekAsString(dayOfWeek(dateInfo.thisyeardate))> 
 
     #dateInfo.day# 
	 <cfif useDayOfWeek>
	 	 (#dateInfo.dayOfWeekAsString#)
	 </cfif>
	 - 
     <cfif isDefined("params.dateType") and params.dateType contains "anniversary">
			 #linkTo(text="#alias('fname',fname,id)# and #alias('spouse',spouse,id)# #alias('lname',lname,id)#", 
					controller="handbook.people",
					action="show", 
					key=personid,
					class="tooltip2 ajaxclickable", 
					title="Click to show #fullname# in the center panel.", 
					onlyPath=false,
					protocol="https"
       )#
	 <cfelse>
	 		<cfset useFullName = replaceNoCase(alias('fullname',fullname,id),'sr','')>
	 		<cfset useFullName = replaceNoCase(useFullName,'jr','')>
       #linkTo(text=useFullName, 
       		action="show", 
       		key=personid,
       		class="tooltip2 ajaxclickable", 
       		title="Click to show #fullname# in the center panel.", 
					onlyPath=false.
					protocol="https"
       )#
	 </cfif>
     
     <cfif isDefined("params.dateType") and params.dateType contains "birthday">
     	<cfset subject = urlEncodedFormat("Happy Birthday #alias('fname',fname,id)#!")>
		<cfset body = urlEncodedFormat('<INSERT CUSTOM MESSAGE HERE>')>
     <cfelseif isDefined("params.dateType") and params.dateType contains "anniversary">
     	<cfset subject = urlEncodedFormat("Happy Anniversary #fname# and #spouse#!")>
		<cfset body = urlEncodedFormat('<INSERT CUSTOM MESSAGE HERE>')>
     <cfelse>
     	<cfset subject = urlEncodedFormat("")>
     	<cfset body = urlEncodedFormat("")>
     </cfif>
     
     #mailTo(
     		emailaddress='#alias('fullname',fullname,id)# <#handbookpersonemail#>?subject=#subject#&body=#body#',
     		name='<i class="icon-envelope"></i>',
			class="tooltip2",
			title="Send a greeting to #fname#"
     		)#
     <br/>
</cfoutput>