<cfoutput>
<cfset dateInfo = structNew()>
<cfset dateInfo.date = '#params.dateType.key#asstring'>
<cfset dateInfo.date = evaluate(dateInfo.date)>
<cfset dateInfo.day = '#params.dateType.key#daynumber'>
<cfset dateInfo.day = evaluate(dateInfo.day)>
<cfset dateInfo.month = '#params.dateType.key#monthnumber'>
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
     <cfif isDefined("params.dateType.key") and params.dateType.key contains "anniversary">
       #linkTo(text="#fname# and #spouse# #lname#", 
       		action="show", 
       		key=personid,
       		class="tooltip2 ajaxclickable", 
       		title="Click to show #fullname# in the center panel.", 
       		onlyPath=false
       )#
	 <cfelse>	   
       #linkTo(text=fullname, 
       		action="show", 
       		key=personid,
       		class="tooltip2 ajaxclickable", 
       		title="Click to show #fullname# in the center panel.", 
       		onlyPath=false
       )#
	 </cfif>
     
     <cfif isDefined("params.dateType.key") and params.dateType.key contains "birthday">
     	<cfset subject = urlEncodedFormat("Happy Birthday #fname#!")>
		<cfset body = urlEncodedFormat('<INSERT CUSTOM MESSAGE HERE>')>
     <cfelseif isDefined("params.dateType.key") and params.dateType.key contains "anniversary">
     	<cfset subject = urlEncodedFormat("Happy Anniversary #fname# and #spouse#!")>
		<cfset body = urlEncodedFormat('<INSERT CUSTOM MESSAGE HERE>')>
     <cfelse>
     	<cfset subject = urlEncodedFormat("")>
     	<cfset body = urlEncodedFormat("")>
     </cfif>
     
     #mailTo(
     		emailaddress='#fullname# <#handbookpersonemail#>?subject=#subject#&body=#body#',
     		name='<i class="icon-envelope"></i>',
			class="tooltip2",
			title="Send a greeting to #fname#"
     		)#
     <br/>
</cfoutput>