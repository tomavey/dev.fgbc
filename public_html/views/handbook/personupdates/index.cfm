<h1>Listing handbookpersonupdates</h1>

<cftable query="handbookpersonupdates" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Person Id" text="#personId#" />
				
					<cfcol header="Fname" text="#fname#" />
				
					<cfcol header="Fnamegender" text="#fnamegender#" />
				
					<cfcol header="Lname" text="#lname#" />
				
					<cfcol header="Spouse" text="#spouse#" />
				
					<cfcol header="Address1" text="#address1#" />
				
					<cfcol header="Address2" text="#address2#" />
				
					<cfcol header="City" text="#city#" />
				
					<cfcol header="Stateid" text="#stateid#" />
				
					<cfcol header="Zip" text="#zip#" />
				
					<cfcol header="Country" text="#country#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Phone2" text="#phone2#" />
				
					<cfcol header="Skype" text="#skype#" />
				
					<cfcol header="Fax" text="#fax#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Email2" text="#email2#" />
				
					<cfcol header="Web" text="#web#" />
				
					<cfcol header="Position" text="#position#" />
				
					<cfcol header="Pic_thumb" text="#pic_thumb#" />
				
					<cfcol header="Pic_big" text="#pic_big#" />
				
					<cfcol header="Birthday" text="#birthday#" />
				
					<cfcol header="Churchid" text="#churchid#" />
				
					<cfcol header="Affiliation_id" text="#affiliation_id#" />
				
					<cfcol header="Comment" text="#comment#" />
				
					<cfcol header="Sortorder" text="#sortorder#" />
				
					<cfcol header="Send Handbook" text="#sendHandbook#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New handbookpersonupdate", action="new")#</p>
</cfoutput>
