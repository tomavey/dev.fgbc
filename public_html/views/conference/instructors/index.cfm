<cfset allemail = "">
<h1>Listing Instructors</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>
<cfif gotRights("superadmin,office")>
<cfoutput>
	<p>#linkTo(text="New instructor", controller="conference.instrutors", action="index", action="new")#</p>
</cfoutput>
</cfif>
<div class="table" id="instructors">
<cftable query="instructors" colHeaders="true" HTMLTable="true">



					<cfcol header="Name" text="<span class='instructorname'>#fname# #lname#</span><span class='popup'>#bioweb#</span>" />

					<cfcol header="Pedigree" text="#pedigree#" />

					<cfcol header="Phone" text="#phone#" />

					<cfcol header="Email" text="#mailto(email)#" />
					<cfif isValid("email",email)>
					<cfset allemail = allemail & ";" & trim(email)>
					</cfif>
					<cfcol header="Pic Big" text="#picBig#" />

					<cfcol header="Pic Thumb" text="#picThumb#" />

					<cfcol header="Tags" text="#tags#" />

					<cfcol header="Comment" text="#comment#" />





	<cfcol header="" text="#showTag()#" />
<cfif gotRights("superadmin,office,pageEditor")>
	<cfcol header="" text="#editTag()#" />
</cfif>	
<cfif gotRights("superadmin,office")>
	<cfcol header="" text="#deleteTag()#" />
	<cfcol header="" text="#copyTag()#" />
</cfif>

</cftable>
<cfset allemail = replace(allemail,";","","one")>
<cfoutput>
<p>
#mailto(name="Email All these instructors", emailaddress=allemail, encode=true)#
</p>
<p>
#linkto(text="Last Year's Instructors", controller="conference.instructors", action="index", params="event=#getSetting('previousEvent')#")#
</p>
<p>Count: #instructors.recordcount#</p>
<!--- <p>#linkto(text="Duplicate #getPreviousEvent()# instructors into #getEvent()#.", controller="conference.instructors", action="copyAllToCurrentEvent", class="btn pull-right")#</p> --->
</cfoutput>
</div>

