<!--- Place helper functions here that should be available for use in all view pages of your application --->

<cffunction name="getContent">
<cfargument name="key" default="params.key">
<cfargument name="editable" default="#gotrights('superadmin,office')#">
	<cfset var content = "">
	<cfif val(arguments.key)>
	<cfset content = model("content").findByKey(arguments.key)>
	<cfelse>
	<cfset content = model("content").findAll(where="name = '#arguments.key#'")>
	</cfif>
	<cfreturn content>
</cffunction>

<cffunction name="getState">
<cfargument name="stateid" required="yes" type="numeric">
	<cfset thisState = model("State").findOne(where="id=#arguments.stateid#")>
	<cfreturn thisState>
</cffunction>

<cffunction name="isyesno">
<cfargument name="id" required="yes" type="numeric">
<cfif arguments.id is 1>
	<cfset yesno = "Yes">
<cfelse>
	<cfset yesno = "No">
</cfif>
<cfreturn yesno>
</cffunction>

<cffunction name="payStatus">
<cfargument name="ccstatus" required="true">
<cfset var thisStatus = "">
<cfif val(arguments.ccstatus) EQ 1>
	<cfset thisstatus = "Paid">
<cfelseif arguments.ccstatus is "paid">
	<cfset thisstatus = "Paid">
<cfelseif arguments.ccstatus is "0">
	<cfset thisstatus = "Not Paid">
<cfelseif arguments.ccstatus is "">
	<cfset thisstatus = "Not Paid">
<cfelse>
	<cfset thisstatus = arguments.ccstatus>
</cfif>
<cfreturn thisstatus>
</cffunction>

<cffunction name="emailEveryone">
<cfargument name="email" required="no" type="string">
<cfset var emailallcode = "">

	<cfif not isdefined("request.emailall")>
		<cfset request.emailall = "">
	</cfif>

	<cfif isdefined("arguments.email")>
		<cfif isvalid("email",arguments.email) and not find(arguments.email,request.emailall)>
			<cfset request.emailall = request.emailall & "; " & arguments.email>
		</cfif>
	<cfelse>
		<cfset emailAllCode = "#mailto(replace(request.emailall,"; ","","one"))#">
		<cfset request.emailall = "">
		<cfreturn emailAllCode>
	</cfif>
</cffunction>

<cffunction name="emailEveryoneAll">
<cfargument name="email" required="no" type="string">
<cfset var emailallcode = "">

	<cfif not isdefined("request.emailallall")>
		<cfset request.emailallall = "">
	</cfif>

	<cfif isdefined("arguments.email")>
		<cfif isvalid("email",arguments.email) and not find(arguments.email,request.emailallall)>
			<cfset request.emailallall = request.emailallall & "; " & arguments.email>
		</cfif>
	<cfelse>
		<cfset emailAllCode = "#mailto(replace(request.emailallall,"; ","","one"))#">
		<cfreturn emailAllCode>
	</cfif>
</cffunction>

<cffunction name="addNewButton">
	<cfoutput>
		<p>#linkTo(text="#imageTag('/add-icon.png')#", action="new", title="Add New")#</p>
	</cfoutput>
</cffunction>

<cffunction name="getCaptchaForm" output="no">
<cfargument name="text" default="Submit">
<cfargument name="action" required="true">
<cfset var arrValidChars = "">
<cfset var strCaptcha = arraynew(1)>
<cfset var captchaForm = "">
	<!---
		Create the array of valid characters. Leave out the
		numbers 0 (zero) and 1 (one) as they can be easily
		confused with the characters o and l (respectively).
	--->
	<cfset arrValidChars = ListToArray(
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
		"2,3,4,5,6,7,8,9"
		) />

	<!--- Now, shuffle the array. --->
	<cfset CreateObject(
		"java",
		"java.util.Collections"
		).Shuffle(
			arrValidChars
			)
		/>

	<!---
		Now that we have a shuffled array, let's grab the
		first 4 characters as our CAPTCHA text string.
	--->
	<cfset strCaptcha = (
		arrValidChars[ 1 ] &
		arrValidChars[ 2 ] &
		arrValidChars[ 3 ] &
		arrValidChars[ 4 ] &
		arrValidChars[ 5 ]
		) />

 	<cfsavecontent variable="captchaForm">
		<cfif flashKeyExists("error")>
			<div class="errorMessage">
				<cfoutput>#flash("error")#</cfoutput>(<a href="##" onclick="alert('Automatic web crawlers are accessing these forms without our permission and causing errors for legitimate users and extra work for the FGBC office. By asking for the text from this image we can stop 95% of these troublesome queries.')">Why?</a>)
			</div>
		</cfif>
		<cfform action="/index.cfm?controller=conference.register&action=#arguments.action#">
			<cfinput type="hidden" name="captcha_check" value="#encrypt(strCaptcha,application.wheels.passwordkey,'CFMX_COMPAT','HEX')#">

			<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="medium" fonts="verdana,arial,times new roman,courier" fontsize="28" /><br /><br />
		             <p>
		                  Enter text from this image.&nbsp;<cfinput type="text" name="captcha" value="" id="captcha">
		             </p>
			<p><cfinput type="submit" value="#arguments.text#" name="submit" class="btn"></p>
		</cfform>
	</cfsavecontent>

	<cfreturn captchaForm>

</cffunction>

<cffunction name="CapName">
<cfargument name="word" type="string">
	<cfset capword = "">
	<cfif listlen(arguments.word," ") is 1>
		<cfset capword = humanize(lcase(arguments.word))>
	<cfelse>
		<cfloop list="#arguments.word#" delimiters=" " index="i">
			<cfset capWord = capWord & " " & humanize(lcase(i))>
		</cfloop>
	</cfif>
	<cfif left(capWord,2) is "Mc" || left(capword,2) is "O'">
		<cfset capWordMcLeft = left(capWord,2)>
		<cfset capWordMcRight = right(capWord,len(capword)-2)>
		<cfset capWord = humanize(capWordMcLeft)&humanize(capWordMcRight)>
	</cfif>

	<cfif capWord is "Odeens">
		<cfset capWord = "O'Deens">
	</cfif>
<cfreturn capWord>
</cffunction>

<cffunction name="cleanname">
<cfargument name="name" required="true" type="string">
<cfset var loc=structNew()>
<cfset loc.strings = "<pre>,</pre>">
<cfloop list="#loc.strings#" index="loc.i">
	<cfset arguments.name = replace(arguments.name,loc.i,"")>
</cfloop>
<cfreturn arguments.name>
</cffunction>

<cffunction name="getSpouseEmail">
<cfargument name="personid" required="true" type="numeric">
<cfset var loc=structNew()>
	<!---get the family id for this person--->
	<cfset loc.familyid = model("Conferenceperson").findOne(where="id=#arguments.personid#", include="family").equip_familiesid>

	<!---see if there are any spouse people connected to this family id--->
	<cfset loc.spouse = model("Conferenceperson").findOne(where="equip_familiesid=#loc.familyid# AND type='Adult'", include="family")>

	<!---If there is a spouse, return that email, if not return false--->
	<cfif isObject(loc.spouse)>
		<cfset loc.return = trim(loc.spouse.email)>
	<cfelse>
		<cfset loc.return = false>
	</cfif>
	<cfreturn loc.return>
</cffunction>

<cffunction name="getConfUrl()">
	<cfreturn application.wheels.webpage>
</cffunction>

<cfscript>

function registrationButton(){
    if (registrationopen())
    {
          return "<input type='button'
            class='btn' value='Order Now' />";
    }
        else
    {
        return "<p class='btn' onClick=(alert('Coming&nbsp;Soon'))>Online Registration Coming Soon!</p>";
    }
}

function editInstructorLink(instructorid){
	if (gotrights("superadmin,office,pageEditor")) {
		return "#linkTo(text='&nbsp;&nbsp;<u>EDIT</u>', controller="conference.instructors", action="edit", key=instructorid)#";
	}
	else
	{
		return "";
	}
}


</cfscript>