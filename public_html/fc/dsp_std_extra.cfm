<div id="extra" class="menu">
<!---get email info from group--->
<cfscript>
  staff = control.getstaffinfo(tag="fc", username="office")
</cfscript>
<!---create an emailall string--->
<cfset emailall="">
<cfloop query="staff">
<cfif email is not "">
  <cfset emailall = #emailall# & "; " & #email#>
</cfif>
</cfloop>
<!---Trim Emailall--->
<!--- remove lead ; from all email address --->
<cfif emailall is not "">
<cfset emailall = removechars(emailall,1,2)>
<cfset emailall = "#emailall#">
</cfif>
<p>Project Participants:</p>
<ul>
<cfoutput query="staff">
<li><a href="mailto:#scramble(email)#">#fname# #lname#</a>
<cfif gotrights("superadmin")>
<cfset subject = "Your%20Link%20to%20the%20Fellowship%20Council%20Web%20Page">
<cfset body = "http%3A%2F%2F#getDomainName()#%2Ffc%2F%3Fcode%3Dfellowshipcouncil%26email%3D#email#">
<a href="mailto:#email#&subject=#subject#&body=#body#" class="sendlink">Send Link</a>
</cfif>
</li>
</cfoutput>
<li><a href="mailto:<cfoutput>#scramble(emailall)#</cfoutput>">Email Everyone!</a></li>
</ul>
<cfset xfa.formaction="getstaff">
<p>Search the FGBC Database by last or first name</p>
<cfform action="#fbx(xfa.formaction)#" method="POST">
<div id="searchform">
<cfinput name="searchby" type="text">
<cfinput type="submit" name="submit" value="Search">
</cfform>
</div>
</div>
