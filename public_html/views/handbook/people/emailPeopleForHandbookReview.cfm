<cfoutput>
<table align="center" width="50%" style="background-color:white;padding:20px">
<tr>
<td>

#emailMessage#

<!--- <p>Link for #args.selectName#: #linkto(controller="handbook.welcome", action="welcome", params='id=#encrypt(args.email,application.wheels.passwordkey,"CFMX_COMPAT","HEX")#', onlyPath=false)#</p> --->
<p>Link for #args.selectName#: 
  <a href='https://charisfellowship.us/index.cfm/handbook/unlock/?id=#encrypt(args.email,application.wheels.passwordkey,"CFMX_COMPAT","HEX")#'>
    charisfellowship.us/index.cfm/handbook/unlock/?id=#encrypt(args.email,application.wheels.passwordkey,"CFMX_COMPAT","HEX")#
  </a>
</p>
<p style="font-weight:bold">Thanks so much for your help! If you need assistance, reply to this email.</p>
<p style="font-size:.8em;color:grey"><span>From</span>: #getHandbookReviewSecretary()#</p>
<p style="font-size:.8em;color:grey"><span>To</span>: #args.email#</p>
<p style="font-size:.8em;color:grey"><span>For</span>: #args.selectName#</p>
<p style="font-size:.8em;color:grey"><span>Last Reviewed</span>: #args.reviewedAt# by #args.reviewedBy#</p>
</td>
</tr>
</table>
</cfoutput>