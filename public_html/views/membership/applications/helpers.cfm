<cffunction name="getState">
<cfargument name="stateid" required="true">
	<cfif val(arguments.stateid)>
		<cfset state = model("Handbookstate").findByKey(arguments.stateid)>
	<cfelse>
		<cfreturn "">
	</cfif>
<cfreturn state.state>
</cffunction>

<cffunction name="getKey">
	<cfif isDefined("params.key")>
		<cfreturn params.key>
	<cfelseif isDefined("session.membershipapplication.id")>
		<cfreturn session.membershipapplication.id>
	<cfelse>
		<cfreturn "">
	</cfif>		
</cffunction>

<cffunction name="isLanguage" access="private">
<cfargument name="language" required="true" type="string">
	<cfif isDefined("session.membershipapplication.language") AND session.membershipapplication.language is 
	arguments.language>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

<cffunction name="isFrench">
	<cfreturn isLanguage("French")>
</cffunction>

<cffunction name="isEnglish">
	<cfreturn isLanguage("English")>
</cffunction>

<cffunction name="isSpanish">
	<cfreturn isLanguage("spanish")>
</cffunction>	

<cffunction name="getStrCaptcha" output="no">
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
<cfreturn strCaptcha>
</cffunction>

<cffunction name="editbutton">
<cfargument name="fieldname" required="true" type="string">	
<cfset var loc = structNew()>	
	<cfif gotRights("superadmin,office,translator")>
		<cfsavecontent variable="loc.return">
			<cfoutput>
			#linkTo(text='<i class="icon-edit"></i>', controller="membershipapp-questions", action='edit', key=arguments.fieldname, class="tooltipleft editbutton", title="Edit #arguments.fieldname# (#session.membershipapplication.language#).")#
			</cfoutput>
		</cfsavecontent>
	<cfelse>
		<cfset loc.return = "">	
	</cfif>
<cfreturn loc.return>	
</cffunction>

<!---Helpers to create questions and questions with edit button--->

<cffunction name="textFieldQuestion">
<cfargument name="fieldname" required="true" type="string">
<cfargument name="fieldsize" default="input-xlarge">	
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.return">
		<cfoutput>
			#textField(
				objectName='membershipapplication', 
				property=arguments.fieldname, 
				label=getQuestion(arguments.fieldname), 
				class=arguments.fieldsize
				)#
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.return>	
</cffunction>

<cffunction name="textFieldQuestionWEditButton">
<cfargument name="fieldname" required="true" type="string">
<cfargument name="fieldsize" default="input-xlarge">	
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.return">
		<cfoutput>
			#editbutton(arguments.fieldname)#
			#textfieldQuestion(arguments.fieldname,arguments.fieldsize)#	
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.return>	
</cffunction>

<cffunction name="textAreaQuestion">
<cfargument name="fieldname" required="true" type="string">
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.return">
		<cfoutput>
			#textArea(
				objectName='membershipapplication', 
				property=arguments.fieldname, 
				label=getQuestion(arguments.fieldname), 
				class="ckeditor"
				)#
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.return>	
</cffunction>

<cffunction name="textAreaQuestionWEditButton">
<cfargument name="fieldname" required="true" type="string">
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.return">
		<cfoutput>
			#editbutton(arguments.fieldname)#
			#textAreaQuestion(arguments.fieldname)#	
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.return>	
</cffunction>

<cffunction name="selectYesNoQuestion">
<cfargument name="fieldname" required="true" type="string">
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.return">
		<cfoutput>
			#select(
				objectName="membershipapplication",
				property=arguments.fieldname, 
				label=getQuestion(arguments.fieldname), 
				class="input-small",
				options="Yes,No"	
				)#	
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.return>	
</cffunction>

<cffunction name="selectYesNoQuestionWEditButton">
<cfargument name="fieldname" required="true" type="string">
<cfset var loc=structNew()>
	<cfsavecontent variable="loc.return">
		<cfoutput>
			#editbutton(arguments.fieldname)#
			#selectYesNoQuestion(arguments.fieldname)#	
		</cfoutput>
	</cfsavecontent>
<cfreturn loc.return>	
</cffunction>

<cfscript>

public function handbookLink(handbookid){
	if (isDefined("handbookid") && !val(handbookId)){
		return "#linkto(
			text='Add to handbook',
			controller='handbook.organizations',
			action='new',
			target="_blank",
			params='name=#name_of_church#&address1=#mailing_address#&org_city=#city#&email=#email#&phone=#phone#&stateid=#stateid#&zip=#zip#&statusid=1&applicationuuid=#uuid#'
			)
			#";		
	}
	else {
		return '#linkto(Text="Handbook Page", controller="handbook.organizations", action="show", target="_blank", key=handbookid)#';
	}
}

</cfscript>