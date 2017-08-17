<div id="extra" class="menu">
<!---get email info from group--->
<cfinvoke component="control" method="getstaffinfo" tag="EVLC" returnvariable="staff" />
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
<cfset key = getkey(email)>
<cfif session.auth.email is "tomavey@fgbc.org">
<a href="mailto:#email#&body=http%3A%2F%2Fwww.fgbc.org/imagine/%3Fkey%3D#key#" class="sendlink">Send Link</a>
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
