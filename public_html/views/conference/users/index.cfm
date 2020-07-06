
<cfoutput>#linkto(text="New", action="new")#</cfoutput>
<table class="table">
<tr>
<th>
UserId
</th>
<th>
FacebookId
</th>
<th>
FamilyId
</th>
<th>
Name
</th>
<th>
Email
</th>
<th>
Date
</th>
<th>
&nbsp;
</th>
</tr>
<cfoutput query="users">
<tr>
	<td>#linkto(text=userid, action="myRegs", params="userid=#userid#")#</td>
	<td>
		<cfif len(fbid) and val(fbid)>
		#linkto(text=fbid, action="myRegs", params="fbid=#fbid#")#
		</cfif>
	</td>
	<td>#linkTo(text=familyid, controller="conference.families", action="show", key=familyid)#
	</td>
	<td>#fname# #lname#</td>
	<td>#mailTo(email)#</td>
	<td>#dateFormat(createdAt)#</td>
	<td>#linkto(text="Login As", controller="conference.users", action="loginAsUser", key=userid)#</td>
	<td>#linkTo(text="connect to new family", controller="conference.users", action="listFamiliesToConnect", key=userid)#
	</td>
</tr>	
</cfoutput>
<table>