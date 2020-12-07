<cfparam name="birthdays" type="query">
<cfparam name="anniversaries" type="query">
<cfparam name="birthdaysubject" default="Happy Birthday">
<cfparam name="birthdaymessage" default="Happy Birthday!">
<cfparam name="anniversarysubject" default="Happy Anniversary">
<cfparam name="anniversarymessage" default="Happy Anniversary!">

<div class="container span10">

	<cfoutput>
		<p class="email-not-sent">
			#flash("message")#
		</p>
	</cfoutput>

	<cfif isDefined("params.go") && params.go is "test">
		<cfoutput>#linkto(text="Send to subscribers who have not already sent one today", route="handbookSendTodaysDates", params="go=send", class="btn")#</cfoutput>
		<cfoutput>#linkto(text="Re-Send to ALL subscribers", route="handbookSendTodaysDates", params="go=send&reSendToAll", class="btn")#</cfoutput>
	</cfif>

	<!---cfif isDefined("emailall")>
	<cfoutput>	
		<p>#emailall#</p>
		#listlen(emailall,";")#
	</cfoutput>
	</cfif--->

	<h3>Todays Birthdays...</h3>

	<ul>
		<cfif birthdays.recordcount>
			<cfset birthdaymessage = urlEncodedFormat('<INSERT CUSTOM MESSAGE HERE>')>
			<cfoutput query="birthdays" group="fullname">
				<cfif !hasAnAlias(personid)>
					<cfset positioninfo = getpositions(personid,fname)>
					<cfif isInHandbook(personid) and positioninfo does not contain "Removed from Staff">
		
						<cfset birthdaysubject = urlEncodedFormat("Happy Birthday #fname#!")>
						<li>#fullname# - #mailTo(name="Send a greeting!", emailAddress="#fullname# <#handbookpersonemail#>?subject=#birthdaysubject#&body=#birthdaymessage#")# #handbookpersonphone# (#birthdaymonthnumber#/#birthdaydaynumber#)
							<ul>
								<li class="positioninfo">#positioninfo#</li>
							</ul>					
						</li>
					</cfif>	
				</cfif>
			</cfoutput>
		<cfelse>
					No birthdays today!
		</cfif>
	</ul>

	<p>&nbsp;</p>

	<h3>Todays Anniversaries...</h3>

	<ul>
		<cfif anniversaries.recordcount>
		<cfset anniversarymessage = urlEncodedFormat('<INSERT CUSTOM MESSAGE HERE>')>

			<cfoutput query="Anniversaries" group="fullname">
				<cfif isInHandbook(personid)>
					<cfset anniversarysubject = urlEncodedFormat("Happy Anniversary #fname# and #spouse#!")>
						<li>#fullname# & #spouse# - 
							#mailTo(
									name="Send a greeting!", 
									emailAddress="#handbookpersonemail#?subject=#anniversarysubject#&body=#anniversarymessage#"
										)# 
									#handbookpersonphone# (#anniversarymonthnumber#/#anniversarydaynumber#)
						<ul>
							<li class="positioninfo">#getpositions(personid)#</li>
						</ul>					
					</li>
			</cfif>
			</cfoutput>
		<cfelse>
					No anniversaries today!
		</cfif>
	<div>&nbsp;</div>
	<div style="font-size:1.2em;font-weight:bold;color:red;border:solid 3px gray;padding:10px">
	<cfoutput>
	<p>Forward this email to a friend and invite them to subscribe to these updates using this link:</p>
	<p>#linkto(href="https://charisfellowship.us/handbook/subscribemedates/")#</p>
	</cfoutput>
	</div>  
	</ul>

</div>

