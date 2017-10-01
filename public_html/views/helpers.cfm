<cffunction name="getStateAbbrev" output="no">
<cfargument name="stateid" required="yes" type="numeric">
     <cfquery datasource="fgbc_main_3" name="states">
        SELECT stateabbrev
        FROM state
        WHERE stateid = #arguments.stateid#
     </cfquery>
 <cfreturn states.stateabbrev>
</cffunction>

<cffunction name="getState">
<cfargument name="stateid" required="yes" type="numeric">
	<cfset state = model("handbookState").findByKey(arguments.stateid)>
	<cfreturn state.state_mail_abbrev>
</cffunction>

<cffunction name="isBefore">
<cfargument name="date">
	<cfif datecompare(parseDateTime(now()),parseDateTime(date),"d") is "-1">
		<cfset answer = "1">
	<cfelse>
		<cfset answer = "0">
	</cfif>
<cfreturn answer />
</cffunction>

<cffunction name="isAfter">
<cfargument name="date1" required="true">
<cfargument name="date2" default="#now()#">
	<cfif datecompare(parseDateTime(date2),parseDateTime(date1),"d") is "1">
		<cfset answer = "1">
	<cfelse>
		<cfset answer = "0">
	</cfif>
<cfreturn answer />
</cffunction>

<cffunction name="getcontent">
<cfargument name="identifier">
<cfset var data = "">

	<cfif val(arguments.identifier) gt 0>
		<cfset data = model('Maincontent').findOne(where="id=#val(arguments.identifier)#")>
	<cfelse>
		<cfset data = model('Maincontent').findOne(where="name='#arguments.identifier#'")>
	</cfif>

<cfreturn data>
</cffunction>

<cffunction name="getCaptcha" output="no">
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

<cffunction name="getkey" output="no">
<cfargument name="email" required="yes" type="string">
<cfset var key="">
	<cfset key = encrypt(arguments.email,Session.PasswordKey,"CFMX_COMPAT","Hex")>
    <cfreturn key>
</cffunction>

<cffunction name="getEmailFromKey" output="no">
<cfargument name="key" required="yes" type="string">
<cfset var email="">
	<cfset email = decrypt(arguments.key,Session.PasswordKey,"CFMX_COMPAT","Hex")>
    <cfreturn email>
</cffunction>

<!----------------------------------------------------->
<!---Authorization Methods----------------------------->
<!----------------------------------------------------->

<cffunction name="GotRights">
<cfargument name="rightRequired" required="yes">
	<cfset permission = "no">
        <cfloop list="#rightrequired#" index="i">
            <cfif isdefined("session.auth.rightslist") and listfind(session.auth.rightslist,"#i#")>
                <cfset permission = "yes">
            </cfif>

            <cfif i is "handbook">
                <cftry>
                    <cfinvoke component="_model.handbook.staff.cfc_handbook_staff" method="get" email="#session.auth.email#" maxSortOrder="900" returnvariable="handbook" />

                    <cfif handbook.recordcount>
                        <cfset permission = "yes">
                    </cfif>
                <cfcatch></cfcatch></cftry>
            </cfif>
        </cfloop>
<cfreturn permission>
</cffunction>

<cffunction name="gotHandbookPersonRights">
<cfargument name="id" required="true" type="numeric">
<cfargument name="rightslist" default="#session.auth.handbook.people#">
	<cfif gotRights("superadmin,office")>
		<cfreturn true>
	</cfif>
	<cfif listfind(arguments.rightslist,arguments.id)>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

<cffunction name="gotHandbookOrganizationRights">
<cfargument name="id" required="true" type="numeric">
<cfargument name="rightslist" default="#session.auth.handbook.organizations#">
	<cfif listfind(arguments.rightslist,arguments.id)>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

<!----------------------------------------------------->
<!----------------------------------------------------->

<cffunction name="getDateDesc">
<cfargument name="begin" required="yes">
<cfargument name="end" required="yes">
     <cfif begin eq end>
		<cfset dateDesc = "#dateformat(begin,"medium")#">
     <cfelse>
        <cfif datepart("m",begin) is datepart("m",end)>
             <cfset dateDesc = '#dateformat(begin,"MMM")# #dateformat(begin,"dd")# - #dateformat(end,"dd")#, #dateformat(begin,"yyyy")#'>
        <cfelse>
			<cfset dateDesc = '#dateformat(begin,"MMM")# #dateformat(begin,"dd")# - #dateformat(end,"MMM")# #dateformat(end,"dd")#, #dateformat(begin,"yyyy")#'>
        </cfif>
    </cfif>
<cfreturn dateDesc>
</cffunction>

<!---------------------------------------------------------------------->
<!---methods to display simple show, edit, delete, copy tags to lists--->
<!---------------------------------------------------------------------->

<cffunction name="addTag">
<cfargument name="controller" default="#params.controller#">
<cfargument name="action" default="new">
<cfargument name="id" required="false" type="numeric">
<cfargument name="params" require="false" type="string">
<cfif isDefined("arguments.id")>
	<cfreturn "#linkTo(
					text="<i class='icon-plus'></i>",
					controller = '#arguments.controller#',
					action=arguments.action,
					key=arguments.id,
					title="Add New"
					)#">
<cfelseif isDefined("arguments.params")>
	<cfreturn "#linkTo(
					text="<i class='icon-plus'></i>",
					controller = '#arguments.controller#',
					action=arguments.action,
					params=arguments.params,
					title="Add New"
					)#">
<cfelse>
	<cfreturn "#linkTo(
					text="<i class='icon-plus'></i>",
					controller = '#arguments.controller#',
					action=arguments.action,
					title="Add New"
					)#">
</cfif>
</cffunction>

<cffunction name="deleteTag">
<cfargument name="id" default='#id#'>
<cfargument name="controller" default="#params.controller#">
<cfargument name="class" default="ajaxdeleterow">
<cfargument name="method" default="delete">

		<cfreturn "#linkTo(
						text="<i class='icon-trash'></i>",
						controller=arguments.controller,
						action='delete',
						key=arguments.id,
						title="delete",
						class=arguments.class,
						method=arguments.method,
						onclick="return confirm('Are you sure?')"
						)#">
</cffunction>

<cffunction name="showTag">
<cfargument name="id" default='#id#'>
<cfargument name="uuid" required="false">
<cfargument name="controller" default="#params.controller#">
<cfargument name="action" default="show">
<cfargument name="params" default="">
		<cfreturn "#linkTo(
						text="<i class='icon-search'></i>",
						controller=arguments.controller,
						action=arguments.action,
						key=arguments.ID,
						params=arguments.params,
						title="show"
						)#">
</cffunction>

<cffunction name="listTag">
<cfargument name="controller" default="#params.controller#">
<cfset arguments.controller = lCase(arguments.controller)>
	<cfreturn "#linkTo(
					text="#imageTag('/list-icon.png')#",
					controller=arguments.controller,
					action='index',
					title="list"
					)#">
</cffunction>

<cffunction name="editTag">
<cfargument name="id" default='#id#'>
<cfargument name="controller" default="#params.controller#">
<cfset arguments.controller = lCase(arguments.controller)>
			<cfreturn "#linkTo(
							text='<i class="icon-edit"></i>',
							controller=arguments.controller,
							action='edit',
							key=arguments.id,
							title='edit'
							)#">
</cffunction>

<cffunction name="copyTag">
<cfargument name="id" default='#id#'>
<cfargument name="controller" default="#params.controller#">
<cfset arguments.controller = lCase(arguments.controller)>
			<cfreturn "#linkTo(
							text='<i class="icon-plus-sign"></i>',
							controller=arguments.controller,
							action='copy',
							key=arguments.id,
							title='Copy'
							)#">
</cffunction>

<!---------------------------------------------------------------------->
<!---------------------------------------------------------------------->

<cffunction name="cleanhttp">
<cfargument name="address" required="true" type="string">
	<cfset arguments.address = replace(arguments.address,"http://","","one")>
	<cfset arguments.address = "http://#arguments.address#">
<cfreturn arguments.address>
</cffunction>

<cffunction name="previousPage">
<cfset var link="">
	<cfif params.previousPage>
		<cfif isdefined("params.alpha")>
			<cfset link = '#linkTo(text="&lt;prev", params="page=#params.previousPage#&alpha=#params.alpha#")#'>
		<cfelse>
			<cfset link = '#linkTo(text="&lt;prev", params="page=#params.previousPage#")#'>
		</cfif>
	</cfif>
<cfreturn link>
</cffunction>

<cffunction name="nextPage">
<cfset var link="">

  			<cfset params.lastpage = pagination().totalpages>

  			<cfparam name="params.page" default="1">

  			<cfif isdefined("params.page") AND params.page GT 1>
  				<cfset params.previousPage = params.page - 1>
  			<cfelse>
  				<cfset params.previousPage = 0>
  			</cfif>

  			<cfif isdefined("params.page") AND params.page lt params.lastpage>
  				<cfset params.nextPage = params.page + 1>
  			<cfelse>
  				<cfset params.nextPage = 0>
  			</cfif>

	<cfif params.nextPage>
		<cfif isdefined("params.alpha")>
			<cfset link = '#linkTo(text="next&gt;", params="page=#params.nextPage#&alpha=#params.alpha#")#'>
		<cfelse>
			<cfset link = '#linkTo(text="next&gt;", params="page=#params.nextPage#")#'>
		</cfif>
	</cfif>
<cfreturn link>
</cffunction>

<!---not sure if this is being used--->
<cffunction name="linkToData">
<cfset var loc=structNew()>
	<cfloop list="#structKeylist(arguments)#" index="i">
		<cfset loc[replace(i,"_","-","all")] = arguments[i]>
	</cfloop>
	<cfreturn linkTo(argumentCollection=loc)>
</cffunction>
<!----------------------------->

<cffunction name="linkBack">
<cfargument name="text" default="Go Back">
<cfset var loc=structNew()>
<cfif isDefined("session.originalURL") and len(session.originalURL)>
	<cfset loc.text = arguments.text>
	<cfset loc.href = session.originalURL>
	<cfset session.originalURL = "">
<cfelse>
	<cfset loc = arguments>
</cfif>
	<cfreturn super.linkTo(argumentCollection=loc)>
</cffunction>

<cffunction name="cleanUp">
<cfargument name="content" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc.badWords = "<object,<embed,<meta,<applet,<script">
<cfloop list = '#loc.badWords#' index = "i">
	<cfset arguments.content = replace(arguments.content,i, "#htmlCodeFormat(i)#","all")>
</cfloop>
<cfreturn arguments.content>
</cffunction>

<cffunction name="getOrgEmails">
<cfargument name="id" required="true" type="numeric">
<cfset var loc=structNew()>

	<cfset loc.email = "">
	<cfset loc.return = "">

	<!---get email from #1 staff person and emails from organization--->
	<cfset loc.org = model("Handbookorganization").findOne(where="id=#arguments.id#", include="Handbookstate")>
	<cfset loc.leader = model("Handbookperson").findOne(where='organizationid=#arguments.id# AND p_sortorder = 1', include="Handbookstate,Handbookpositions")>


	<!---add each valid email to a list--->
	<cfif isDefined("loc.org.email") AND isValid("email",loc.org.email)>
		<cfset loc.email = loc.email & "," & loc.org.email>
	</cfif>

	<cfif isDefined("loc.org.email2") AND isValid("email",loc.org.email2)>
		<cfset loc.email = loc.email & "," & loc.org.email2>
	</cfif>

	<cfif isDefined("loc.leader.email") AND isValid("email",loc.leader.email)>
		<cfset loc.email = loc.email & "," & loc.leader.email>
	</cfif>

	<cfif isDefined("loc.leader.email2") AND isValid("email",loc.leader.email2)>
		<cfset loc.email = loc.email & "," & loc.leader.email2>
	</cfif>

	<!---clean up the list--->
	<cfset loc.email = replace(loc.email,",","","one")>

	<!---create a new list of unique email addresses--->
	<cfset loc.return= listfirst(loc.email)>
	<cfloop list="#loc.email#" index="loc.i">
		<cfif NOT listfind(loc.return,loc.i)>
			<cfset loc.return = loc.return & ";" & loc.i>
		</cfif>
	</cfloop>

<cfreturn loc.return>

</cffunction>


<cffunction name="getChurchName">
<cfargument name="churchid" required="true" type="numeric">
<cfset var loc = structNew()>
	   <cfset loc.church = model("Handbookorganization").findOne(where="id=#arguments.churchid#", include="Handbookstate").selectname>
	   <cfreturn loc.church>
</cffunction>

<cffunction name="ckeditor">
<cfreturn '<script type="text/javascript" src="/files/plugins/richtext/ckeditor/ckeditor.js">
</script>'>
</cffunction>

<cffunction name="displayPositions">
<cfargument name="personid" required="true" type="numeric">
<cfset var positionCode = "">
<cfset var isAgbm = isAgbm(arguments.personid)>
	<cfset positions = model("Handbookposition").findAll(where="personid = #arguments.personid#", include="Handbookorganization(Handbookstate)")>
	<cfsavecontent variable="positionCode">
		<cfoutput query="positions">
			<cfif positiontypeid EQ 32 AND not isDefined("showhiddenpositions")>
				<cfset showthisposition = false>
			<cfelseif position contains "Remove" AND not isDefined("showhiddenpositions")>
				<cfset showthisposition = false>
			<cfelseif position contains "AGBM Only" AND not isDefined("showhiddenpositions")>
				<cfset showthisposition = false>
			<cfelse>
				<cfset showthisposition = true>
			</cfif>
			<cfif showthisposition>
				  <cfif len(position)>
				  	#position# -
				  </cfif>
				  	#selectname#
				  	<cfif position CONTAINS "Remove">**</cfif>

					<cfif gotrights("superadmin") and isDefined("params.showedit") and params.showedit>
						<cfif isAgbm>
							#linkto(text="Make AGBM Only", controller="Handbook.people", action="changeToAGBMOnly", params="positionId=#id#", target="_blank")#
						<cfelse>	
							#deleteTag(controller="handbook.positions", action="delete", key=id)#
						</cfif>	
					</cfif>
				  	<br/>
			</cfif>
		</cfoutput>
	</cfsavecontent>
	<cfreturn positionCode>
</cffunction>

<cffunction name="fixPhone">
<cfargument name="phone" required="true" type="string">
<cfset var loc=structNew()>
<cfset loc.return = arguments.phone>
<cfset loc.return = replace(loc.return,"("," ","all")>
<cfset loc.return = replace(loc.return,")"," ","all")>
<cfset loc.return = replace(loc.return,"  "," ","all")>
<cfset loc.return = trim(loc.return)>
<cfset loc.return = replace(loc.return," ","-","all")>
<cfset loc.return = replace(loc.return,".","-","all")>
<cfif len(loc.return) is 10>
	<cfset loc.return = insert("-",loc.return,3)>
	<cfset loc.return = insert("-",loc.return,7)>
</cfif>
<cfreturn trim(loc.return)>

</cffunction>

<cffunction name="fixAddress">
<cfargument name="address" required="true" type="string">
<cfset var loc=structNew()>
<cfset loc.return = arguments.address>
<cfset loc.return = replace(loc.return,".","","all")>
<cfset loc.return = replace(loc.return,"Street","St","all")>
<cfset loc.return = replace(loc.return,"Avenue","Ave","all")>
<cfset loc.return = replace(loc.return,"Drive","Dr","all")>
<cfset loc.return = replace(loc.return,"Road","Rd","all")>
<cfreturn trim(loc.return)>
</cffunction>

<cffunction name="fixFacebook">
<cfargument name="address" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc.return = $stripHttp(arguments.address)>
	<cfif NOT find("facebook.com",loc.return)>
		<cfset loc.return = "facebook.com/" & loc.return>
	</cfif>
<cfreturn trim(loc.return)>
</cffunction>

<cffunction name="fixTwitter">
<cfargument name="address" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc.return = $stripHttp(arguments.address)>
	<cfif NOT find("twitter.com",loc.return)>
		<cfset loc.return = "twitter.com/" & loc.return>
	</cfif>
<cfreturn trim(loc.return)>
</cffunction>

<cffunction name="fixInstagram">
<cfargument name="address" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc.return = $stripHttp(arguments.address)>
	<cfif NOT find("instagram.com",loc.return)>
		<cfset loc.return = "instagram.com/" & loc.return>
	</cfif>
<cfreturn trim(loc.return)>
</cffunction>

<cffunction name="showflashErrorOrSuccess">
<cfset var loc=structNew()>
<cfset loc.return = "">
	<cfif NOT flashIsEmpty()>
        <cfif flashKeyExists("error")>
		  	<cfsavecontent variable="loc.return">
            	<div class="alert alert-block">
                   <p class="errorMessage">
      			   	  <cfoutput>#flash("error")#</cfoutput>
				   </p>
  				</div>
			</cfsavecontent>
		<cfelseif flashKeyExists("success")>
			<cfsavecontent variable="loc.return">
            	<div class="alert alert-block">
            		<p class="successMessage">
            	 	 	<cfoutput>#flash("success")#</cfoutput>
            		</p>
				</div>
			</cfsavecontent>
          </cfif>
	</cfif>
	<cfreturn loc.return>
</cffunction>

<cffunction name="getpositions">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="fname" required="false" type="string">
	<cfset var loc=structNew()>
	<cfset loc.return="">
	  <cftry>
		<cfset loc.positions = model("Handbookposition").findAll(where="personid = #arguments.personid# AND positiontypeid <> 32", include="Handbookorganization(Handbookstate)")>
		<cfif loc.positions.recordcount>
			<cfloop query="loc.positions">
				<cfif position does not contain "Removed from Staff">
					<cfset loc.return = loc.return & "; " & position & ":" & name & "-" & org_city& "," & state_mail_abbrev>
				</cfif>
			</cfloop>
		</cfif>
		<cfset loc.return = replace(loc.return,"; ","","one")>
    	<cfif isDefined("arguments.fname")>
    		 <cfset check = model("Handbookperson").findOne(where="id=#arguments.personid# AND spouse = '#arguments.fname#'", include="Handbookstate")>
    		 <cfif isObject(check)>
    		 	<cfset loc.return = "SPOUSE is " & loc.return>
    		 </cfif>
    	</cfif>
	  <cfcatch></cfcatch></cftry>
	<cfreturn loc.return>
</cffunction>

<cffunction name="dateDisplay">
<cfargument name="data" required="true">
	<cfset var loc = structNew()>
	<cftry>
		<cfif arguments.data contains "{ts" >
			<cfset loc.return = dateformat(arguments.data)>
		<cfelse>
			<cfset loc.return = arguments.data>
		</cfif>
	<cfcatch>
		<cfset loc.return = arguments.data>
	</cfcatch>
	</cftry>
	<cfreturn loc.return>
</cffunction>

<cffunction name="isInHandbook">
<cfargument name="personid" required="true" type="numeric">
<cfset var loc = structNew()>

  <cfset loc.check = model("Handbookposition").findAll(
    where="personid=#arguments.personid# AND statusid in (#application.wheels.churchAndOrgStatusForHandbook#)",
    include="Handbookorganization(Handbookstate)")>
  <cfif loc.check.recordcount>
    <cfset loc.return = true>
  <cfelse>
    <cfset loc.return = false>
  </cfif>
<cfreturn loc.return>
</cffunction>

<cffunction name="isEditor">
	<cfreturn false>
</cffunction>

<cffunction name="getQuestion">
<cfargument name="fieldname" required="true" type="string">
<cfargument name="format" required="false" type="string">
<cfargument name="language" default="#session.membershipapplication.language#">
<cfset var loc=structNew()>
	<cfset loc.wherestring = "field='#arguments.fieldname#'">

	<cfif isDefined("session.membershipapplication.language")>
		<cfset loc.whereString = loc.whereString & " AND language = '#arguments.language#'">
	</cfif>

	<cfset loc.question = model("Membershipappquestion").findOne(where=loc.whereString)>

	<cfif isObject(loc.question)>
		<cfif isEditor()>
			<cfset loc.question.question = "<a href='index.cfm?controller=membershipappquestions&action=edit&key=#loc.question.id#'>" & loc.question.question & "</a>">
		</cfif>
		<cfset loc.return = loc.question.question>
	<cfelse>
		<cfset loc.return = "No Question">
	</cfif>

	<cfif isDefined("arguments.format") AND arguments.format is "noTags">
		<cfset loc.return = stripTags(loc.return)>
	</cfif>

<cfreturn loc.return>
</cffunction>

<cffunction name="createLink">
<cfargument name="link" required="false">
<cfargument name="controller" required="false">
<cfargument name="action" required="false">
<cfargument name="key" required="false">
<cfargument name="text" required="true">
<cfargument name="class" default="">
<cfargument name="data_role" default="">

<cfset var loc=structnew()>
<cfset loc.return = "">

<cfif isDefined("arguments.controller") and len(arguments.controller)>
	<cfif NOT isDefined("arguments.action") or NOT len(arguments.action)>
		<cfset arguments.action = "index">
	</cfif>
	<cfset loc.return = linkto(argumentCollection=arguments)>
<cfelse>
  	<cfif link contains ("http://")>
  		<cfset loc.hrefargs.text = arguments.text>
  		<cfset loc.hrefargs.href = arguments.link>
  		<cfset loc.hrefargs.class = arguments.class>
  		<cfset loc.hrefargs.data_role = arguments.data_role>
		<cfset loc.return = linkto(argumentCollection=loc.hrefargs)>
	<cfelse>
		<cfset loc.return = arguments.text & " - link not working<br/>">
	</cfif>
</cfif>

<cfreturn loc.return>
</cffunction>

<cffunction name="putFormTag">
	<cfreturn '<input type="hidden" name="_method" value="put" />'>
</cffunction>

<cffunction name="dateText">
<cfargument name="begin" required="yes" type="string">
<cfargument name="end" required="yes" type="string">
<cfset var datetext = "">
	<cfif datepart("m",arguments.begin) is datepart("m",arguments.end)>
       <cfset datetext = "#dateformat(arguments.begin,"MMM")# #dateformat(arguments.begin,"dd")# - #dateformat(arguments.end,"dd")#, #dateformat(arguments.begin,"yyyy")#">
    <cfelse>
       <cfset datetext = "#dateformat(arguments.begin,"MMM")# #dateformat(arguments.begin,"dd")# - #dateformat(arguments.end,"MMM")# #dateformat(arguments.end,"dd")#, #dateformat(arguments.begin,"yyyy")#">
    </cfif>
<cfreturn datetext>

</cffunction>

<cffunction name="payStatus">
<cfargument name="ccstatus" required="true">
	<cfif arguments.ccstatus is "1">
		<cfreturn "Paid">
	<cfelseif arguments.ccstatus is "0">
		<cfreturn "Not Paid">
	<cfelse>
		<cfreturn arguments.ccstatus>
	</cfif>
</cffunction>

<cffunction name="simpleEncode">
<cfargument name="key" required="true" type="numeric">
<cfargument name="factor" default=3>
	<cfset var loc.return = (arguments.key +arguments.factor)*arguments.factor>
<cfreturn loc.return>
</cffunction>

<cffunction name="linkToUrl">
<cfargument name="href" required="true" type="string">
<cfargument name="text" required="false" type="string">
<cfargument name="target" default="_blank">
<cfset var loc = structNew()>
	<cfif isDefined("arguments.text")>
		<cfset loc.text = arguments.text>
	<cfelse>
		<cfset loc.text = trim($stripTrailingSlash($stripHttp(arguments.href)))>
	</cfif>
	<cfset loc.href = trim($nameHref(arguments.href))>
	<cfset loc.target = arguments.target>
	<cfreturn '#linkTo(
					text=loc.text,
					href=loc.href,
					target=loc.target
					)#'>
</cffunction>

<cffunction name="$stripHttp" access="private">
<cfargument name="address" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc.return = replace(arguments.address,"http://","","one")>
<cfreturn loc.return>
</cffunction>

<cffunction name="$stripTrailingSlash">
<cfargument name="link" required="true" type="string">
<cfset var loc = structNew()>
	<cfif right(arguments.link,1) is "/">
		<cfset loc.link = left(arguments.link,len(arguments.link)-1)>
		<cfreturn loc.link>
	<cfelse>
		<cfreturn arguments.link>
	</cfif>
</cffunction>

<cffunction name="$nameHref">
<cfargument name="link" required="true" type="string">
<cfset var loc = structNew()>
	<cfif find("https://",arguments.link) OR find("http://",arguments.link)>
		<cfreturn arguments.link>
	<cfelse>
		<cfset loc.link = "http://" & $stripHttp(arguments.link)>
		<cfreturn loc.link>
	</cfif>
</cffunction>

<cffunction name="fixWebSite">
<cfargument name="address" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc.return = $stripHttp(arguments.address)>
<cfreturn trim(loc.return)>
</cffunction>

<cffunction name="nameColumn">
<cfargument name="ColumnName" required="true" type="string">
<cfset var nameColumn = structnew()>

	<cfset nameColumn.lname = "Last Name">
	<cfset nameColumn.fname = "First Name">
             <cfset nameColumn.statusid = "Status">
             <cfset nameColumn.stateid = "State">
             <cfset nameColumn.org_city = "City">
             <cfset nameColumn.organizationid = "Organization">
             <cfset nameColumn.p_sortorder = "Staff Order">

	<cfif structKeyExists(nameColumn,arguments.columnname)>
		<cfreturn nameColumn[arguments.columnname]>
	<cfelse>
		<cfreturn arguments.columnname>
	</cfif>

</cffunction>

<cffunction name="unRepeatCity">
	<cfargument name="city" required="true" type="string">
	<cfargument name="name" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.return = arguments.city & ",">
	<cfif find(city,name)>
		<cfset loc.return = "">
	</cfif>
<cfreturn trim(loc.return)>
</cffunction>

<cffunction name="gbcIt">
	<cfargument name="churchname" required="true" type="string">
	<cfset var loc=structNew()>
	<cfset loc.return = replace(arguments.churchname,"Grace Brethren Church","GBC","all")>
<cfreturn trim(loc.return)>
</cffunction>

<cfscript>

public function getAlphabet(){
	return application.wheels.alphabet;
}

</cfscript>
