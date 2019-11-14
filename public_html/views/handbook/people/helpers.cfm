<cffunction name="xFullNamePlus">	
<cfargument name="lname" required="true" type="string">	
<cfargument name="fname" required="true" type="string">	
<cfargument name="city" required="true" type="string">	
<cfargument name="state_mail_abbrev" required="true" type="string">	
	<cfset fullNamePlus = lname & " " & fname & ": " & city>
	<cfif stateid is not 53>
		<cfset fullNamePlus = fullNamePlus & "," & state_mail_abbrev>
	</cfif>
<cfreturn fullNamePlus>
</cffunction>

<cffunction name="licensedOrOrdainedAtOptions">
<cfset var loc=structnew()>
<cfset loc.return = "">

  <cfloop to="#year(now())-70#" from="#year(now())#" step="-1" index="i">
  	<cfset loc.return = loc.return & "," & i>
  </cfloop>
  <cfset loc.return = replace(loc.return,",","","one")>

<cfreturn loc.return>
</cffunction>

<cffunction name="isNatMinOrCoopMin">
<cfargument name="personid">
<cfset var loc=structNew()>
<cfset loc.return = false>

  <cfset loc.check = model("Handbookposition").findAll(where="personid = #arguments.personid# AND (statusID = 10 OR statusID = 11)", include="Handbookorganization(Handbookstate)")>
  
  <cfif loc.check.recordcount>
  	  <cfset loc.return = true>
  </cfif>

<cfreturn loc.return>

</cffunction>	

<cffunction name="getToName">
<cfargument name="name" required="true" type="string">
<cfset var loc = structNew()>

	<cfif len(arguments.name)>
		<cfset loc.toname = arguments.name>
	<cfelse>
		<cfset loc.toname = "Pastor">
	</cfif>

<cfreturn loc.toname>
</cffunction>

<cffunction name="getEmailMessage">
<cfset var loc=structNew()>
<cfsavecontent variable="loc.return2">
  <cfoutput>
    <div style="font-size:1.3em;font-family:arial; width:900px">
	<table>
	<tr>
	<td style="padding:5px">
      <a href="http://www.fgbc.org/handbook"><img src="http://www.fgbc.org/images/handbook/iphone.jpg" style="float:left"></a>	
	</td>
	<td>  
      <p style="margin-bottom:10px">Dear #distinctemail.name#,</p>
      <p style="margin-bottom:10px">Greetings! </p> 
      <p>The online FGBC handbook goes mobile.</p>
      <p>Now works equally well on your tablet or smart phone!</p>
      <ul>
        <li>On-the-go access to phone numbers.</li>
        <li>Connect faces to names.</li>
        <li>Send birthday and anniversary greetings.</li>
        <li>Update your person information.</li>
      </ul>
      <p>Check it out at <a href="http://www.fgbc.org/handbook">www.fgbc.org/handbook</a></p>
      <p>The printed version of this handbook will be sent early in January.</p>
      <p>Tom Avey<br/>
      FGBC Coordinator<br/>
      Fellowship of Grace Brethren Churches, inc.<br/>
      </p>
	  </td>
	  </tr>
	  </table>
    </div>
  </cfoutput>
</cfsavecontent>
<cfreturn loc.return2>
</cffunction>

<cffunction name="getEmailSubject">
  <cfset var loc=structNew()>
    <cfset loc.return="The online Charis Fellowship Handbook goes mobile!">
  <cfreturn loc.return>
</cffunction>


<cfscript>

public function getDaysInMonth(month){
	var i = 0;
	var daysInMonth = "";
	for (i=1;i LTE 31;i=i+1){
		daysInMonth = daysInMonth & "," & #i#;
	}
	daysInMonth = replace(daysInMonth,",","");
	return daysInMonth;
}

public function getMonthsQuery(){
	var i = 0;
	var monthsQuery = queryNew("month_number,month_name");
	for (i=1;i lte 12;i=i+1){
		QueryAddRow(monthsQuery);
		monthsQuery.month_number[i] = i;
		monthsQuery.month_name[i] = MonthAsString(i);
	}	
	return monthsQuery;
}

public function getYearsList(){
	var i = 0;
	var yearsList = "";
	var endYear = year(now())-100;
	var startYear = year(now());
	for (i=#startYear#;i GTE #endYear#;i=i-1){
		yearsList = yearsList & "," & #i#;
	}
	yearsList = replace(yearsList,",","");
	return yearsList;
}

public function breakOnAtSign (word) {
	var newword = replace(word,'@','@&##8203;','one');
	return newword;
}

</cfscript>