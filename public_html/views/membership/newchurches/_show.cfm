
<cfoutput>
<div id="shownewchurch">
<div class="well">
	<h2>The church starter: </h2>	
	<p>#newchurch.fname# #newchurch.lname#</p>
	<p>#mailto(newchurch.email)#</p>
	<p>#newchurch.phone#</p>
</div>

<div class="well">
	<h2>The new church: </h2>
	<p>#h(newchurch.churchname)#</p>
	<p>#newchurch.churchaddress#</p>
	<p>#h(newchurch.churchcity)# #getState(newchurch.churchstateid)#, #newchurch.churchzip#</p>
<cfif isDefined("param.old")>		
	<p>Families: #h(newchurch.family01)#, #h(newchurch.family02)#, #h(newchurch.family03)#, #h(newchurch.family04)#, #h(newchurch.family05)#</p>
	<p>Committed to the 5 functions on #dateFormat(newchurch.committedAt)#</p>
	<p>#newchurch.committed#</p>
<cfelse>
	<p><span>Describe this church. How often do you meet? How many do you typically have when you gather? </span><br />#h(newchurch.meet)#</p>
	<p><span>How do you follow Jesus together? </span><br />#h(newchurch.together)#</p>
	<p><span>In 100 words or less, what is the Gospel? </span><br />#h(newchurch.gospel)#</p>
	<p><span>Who is/are your leader(s) (ie: gatherer, shepherd, elder) </span><br />#h(newchurch.leaders)#</p>
	<p><span>When you pray for this church, what do you ask for? In other words, what is the mission of this church. </span><br />#h(newchurch.mission)#</p>
</cfif>	
	<p><span>Intend to become FGBC within 3 years? </span><br />#h(newchurch.becomefgbc)#</p>
	<p><span>Our Story:</span> <br />
						#newchurch.story#</p>
</div>

<cfif isOffice()>
	<div class="well">
		<h2>For Office Only:</h2>
		<p>Form created on: #dateFormat(newchurch.createdAt)#</p>
		<p>Reviewed 
			<cfif len(newchurch.reviewedAt)>
				on #dateformat(newchurch.reviewedat)#
			</cfif> 
			<cfif len(newchurch.reviewedBy)>
				by #newchurch.reviewedBy#
			</cfif>
		</p>
		<p>
			Comments: #newchurch.comment#
		</p>

		<cfif val(newchurch.handbookid)>
		<p>
			#linkto(Text="Handbook Page", controller="handbook.organizations", action="show", key=newchurch.handbookid)#
		</p>
		</cfif>

		<cfif len(newchurch.motherorgid)>
			<p>
				Mother Ministry: #getOrganization(newchurch.motherorgid)#
			</p>
		</cfif>
		<cfif len(newchurch.motherchurchid)>
			<p>
				Mother Church: #getOrganization(newchurch.motherchurchid)#
			</p>
		</cfif>	
	</div>	
</cfif>
</div>
</cfoutput>
<!---Overriding the h() method to turn it off--->
<cfscript>
public function h(text){
	return text;
}
</cfscript>
