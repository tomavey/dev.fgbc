<cfset delegatecount = 0>
<cfset nodelegatecount = 0>
<cfset churchcount = 0>
<cfset nochurchcount = 0>
<cfset emailall = "">

<cfoutput>
<h1>FGBC Delegates for #getDelegateYear()#</h1>
<cfif gotRights("office")>
	#linkTo(Text="Download", action="downloaddelegates")#
</cfif>
</cfoutput>
<div class="table table-stripped">
  <table>

    <thead>
      <tr>
	  	<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>Delegate</th>
				<cfif gotRights("office")>
        	<th>Delegate's Email</th>
				</cfif>
        <th>Date</th>
        <th>&nbsp;</th>
  	</tr>
    </thead>

    <tbody>
      <cfoutput query="fgbcdelegates" group="selectnamecity">
        <tr>
          <td colspan="4">
		  <h3>#selectnamecity#</h3>Allowed=#getDelegatesAllowed(churchid)# <cfif gotRights("office")>(submitted by #mailTo(text=submitter, emailaddress=submitteremail)#)</cfif>
          </td>
		  <td>
		  	<cfif gotRights("office")>
		  	  #linkTo(text="<i class='icon-ok'></i>", action="markchurchpickedup", key=churchid, class="tooltipside", title="Toggle check marks for all #selectname# delegates")#&nbsp;#showtag(handbookorganizationid)#
		  	<cfelse>
		  		&nbsp;
		  	</cfif>
     	  	</td>
        </tr>
        <cfoutput>

		  <cfif name does not contain "delegates">
	  		<cfset hasdelegates = 1>
		  <cfelse>
	  		<cfset hasdelegates = 0>
		  </cfif>

          <tr>
		  	<td><cfif status is "picked up"><i class='icon-ok'></i><cfelse>&nbsp;&nbsp;&nbsp;&nbsp;</cfif></td>
            <td>#name#</td>
						<cfif gotRights("office")>
            	<td>#mailto(email)#</td>
						</cfif>
            <td>#dateformat(createdAt)#</td>
            <td>
				<cfif gotrights("office")>
					  #editTag()#
					  #deleteTag()#
					  #linkTo(text="<i class='icon-ok'></i>", action="markpickedup", key=id, class="tooltipside", title="Toggle check mark for #name#")#
				<cfelse>
						&nbsp;
				</cfif>
			</td>
          </tr>

		  	<cfif hasdelegates>
	  		  <cfset delegatecount = delegatecount + 1>
			<cfelse>
	  		  <cfset nodelegatecount = nodelegatecount + 1>
		  	</cfif>

			<cfif isvalid("email",email) and hasdelegates>
			  <cfif not listFind(emailall,email,"; ")>
				<cfset emailall = emailall & "; " & email>
			  </cfif>
			<cfelseif isvalid("email",submitteremail) and hasdelegates>
			  <cfif not listFind(emailall,submitteremail,"; ")>
				<cfset emailall = emailall & "; " & submitteremail>
			  </cfif>
			</cfif>

  	  </cfoutput>
	  	<cfif hasdelegates>
		  <cfset churchcount = churchcount + 1>
		<cfelse>
		  <cfset nochurchcount = nochurchcount + 1>
		</cfif>
    </cfoutput>
    </tbody>

  </table>

</div>

<cfoutput>
	<cfif gotrights("office")>
		  <p>#linkTo(text="New fgbcdelegate", action="submit")#</p>
			<p>#linkTo(text="Download Delegates (unique emails)", action="downloaddelegates")#
	</cfif>
	<p>Church Count w/delegates: #churchcount#</p>
	<p>Delegate Count: #delegatecount#</p>
	<p>Church Count w/o delegates: #nochurchcount#</p>
	<cfset emailall = replace(emailall,"; ","","one")>
	<cfif gotRights("office")>
		<p>#mailto(emailall)#</p>
    <p>#linkto(text="Last Years Delegates", params="year=#getDelegateYear()-1#")#</p>
	</cfif>						
</cfoutput>
