<cfif !isdefined("params.go") || params.go is not "send">
	<cfoutput>
		#linkTo(text="Send test to tomavey", route="handbookSendEmailToPeople", params="go=test", class="btn", confirm="Are you sure?")#<br/>
		#linkTo(text="Send this email to: ", route="handbookSendEmailToPeople", params="go=send", class="btn")#

		<p>
			Subject = #emailsubject#
		</p>
	</cfoutput>
</cfif>


<cfoutput>
#getEmailMessage()#
</cfoutput>

<cfif not isdefined("params.go") OR params.go is not "send">
	<table>
		<cfoutput query="distinctemail">
			<cfif isValid("email",emailsend)>
				<tr>
					<td>#name#</td>
					<td>#emailsend#</td>
				</tr>
			</cfif>
		</cfoutput>
	</table>
<cfoutput>
				Count = #count#>
</cfoutput>
</cfif>
