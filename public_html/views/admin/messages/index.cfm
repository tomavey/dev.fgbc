<cfoutput>
<div class="container">

<cfif isDefined("params.showAll")>
	<h1>Listing messages</h1>
<cfelse>	
	<h1>Listing 100 messages</h1>
</cfif>	

<form>
	<input type="text" placeholder="Search" name="search">
</form>
<cfif !isDefined("params.showall")>
	#linkto(text="Show All", params="showall=true")# | 
<cfelse>
	#linkto(text="Show 100", params="")# | 
</cfif>
#linkTo(text="Delete messages older than 1 year", controller="admin.messages", action="deleteOlder")# |
#linkto(text="Office Settings", controller="admin.settings", action="index", params="category=office")#

<table class="table">
	<tr>
		<th>
			Name
		</th>
		<th>
			Email
		</th>
		<th>
			Message
		</th>
		<th>
			Date
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
<cfoutput query="messages">
	<tr>
		<td>
			#name#
		</td>
		<td>#mailto(email)#</td>
		<td>#left(message,20)#
		</td>
		<td>
			#dateFormat(updatedAt)#
		</td>
		<td>
			#editTag()##ShowTag()##DeleteTag()#
		</td>
	</tr>
</cfoutput>
</table>


</div>
</cfoutput>
