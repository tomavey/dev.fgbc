<cfset count = structnew()>
<cfset count.a.tables = 0>
<cfset count.b.tables = 0>
<cfset count.c.tables = 0>
<cfset count.a.spaces = 0>
<cfset count.b.spaces = 0>
<cfset count.c.spaces = 0>
<cfset count.a.both = 0>
<cfset count.b.both = 0>
<cfset count.c.both = 0>
<cfset count.all.tables = 0>
<cfset count.all.spaces = 0>
<cfset emailall = "">


<div class="eachItemShown">

	<table class="dataTable">
		<thead>
		<tr>
			<th>
				Organization
			</th>
			<th>
				Phone
			</th>
			<th>
				Email
			</th>
			<th>
				Person
			</th>
			<th>
				Tables?
			</th>
			<th>
				Spaces?
			</th>
			<th>
				Elect?
			</th>
			<th>
				Approved?
			</th>
			<cfif gotRights("superadmin,office")>
			<th>
				&nbsp;
			</th>
			</cfif>
		</tr>
		</thead>
		<tbody>
		<cfoutput query="exhibits">
			<tr>
				<td width="200">
					#left(organization,20)#<span>#organization# - #specialrequest#</span>
				</td>
				<td>
					#phone#
				</td>
				<td>
					#mailto(email)#
				</td>
				<td>
					#person#
				</td>
				<td>
					#numbertables#
				</td>
				<td>
					#numberspaces#
				</td>
				<td>
					<cfif elect>Yes<cfelse>No</cfif>
				</td>
				<td>
					#approved#
				</td>
				<td>
					#showTag()#
					#editTag()#
					#deleteTag()#
				</td>
			</tr>
			<!---Tally of tables by section--->
			<cfswitch expression="#section#">
				<cfcase value="A">
					<cfset count[section].tables = count[section].tables + numbertables>
					<cfset count[section].spaces = count[section].spaces + numberspaces>
					<cfset count[section].both = count[section].both + numberspaces + numbertables>
				</cfcase>
				<cfcase value="B">
					<cfset count[section].tables = count[section].tables + numbertables>
					<cfset count[section].spaces = count[section].spaces + numberspaces>
					<cfset count[section].both = count[section].both + numberspaces + numbertables>
				</cfcase>
				<cfcase value="C">
					<cfset count[section].tables = count[section].tables + numbertables>
					<cfset count[section].spaces = count[section].spaces + numberspaces>
					<cfset count[section].both = count[section].both + numberspaces + numbertables>
				</cfcase>
			</cfswitch>
					<cfset count.all.tables = count.all.tables + numbertables>
					<cfset count.all.spaces = count.all.spaces + numberspaces>


		<cfif isValid("email",trim(email)) and NOT listfind(emailall,email,";")>
			<cfset emailall = emailall & ";" & trim(email)>
		</cfif>
		</cfoutput>
		</tbody>
	</table>

	Count:
	<cfoutput>
	<table>
		<tr>
			<th>
				&nbsp
			</th>
			<th>
				A
			</th>
			<th>
				B
			</th>
			<th>
				C
			</th>
			<th>
				Total
			</th>
		</tr>
		<tr>
			<td>
				Tables
			</td>
			<td>
				#count.a.tables#
			</td>
			<td>
				#count.b.tables#
			</td>
			<td>
				#count.c.tables#
			</td>
			<td>
				#count.all.tables#
			</td>
		</tr>
		<tr>
			<td>
				Spaces
			</td>
			<td>
				#count.a.spaces#
			</td>
			<td>
				#count.b.spaces#
			</td>
			<td>
				#count.c.spaces#
			</td>
			<td>
				#count.all.spaces#
			</td>
		</tr>
		<tr>
			<td>
				Both
			</td>
			<td>
				#count.a.both#
			</td>
			<td>
				#count.b.both#
			</td>
			<td>
				#count.c.both#
			</td>
			<td>
				#count.all.tables+count.all.spaces#
			</td>
		</tr>
	</table>
	#mailto(replace(emailAll,";","","one"))#
	</cfoutput>


<cfoutput>
	<p>#linkTo(text="#imageTag("add-icon.png")#", action="new")#</p>
</cfoutput>
</div>