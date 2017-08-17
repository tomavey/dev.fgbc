<div id="footer"><p><cftry><cfoutput>#session.auth.email#</cfoutput><cfcatch></cfcatch></cftry> - Use this username and password for downloads: username: fc ; password: charis </p></div>
</div>

<cfif traceon>
<div id="debugstuff">
  <cfloop list="FORM,URL,APPLICATION,SESSION,REQUEST,COOKIE,CGI" index="i">
    <h5>
       <cfoutput>#i#</cfoutput> VARIABLES
    </h5>
    <cftry>
       <cfswitch expression="#i#">
           <cfcase value="session">
               <!--- lock the session scoped variables --->
               <cflock timeout="10" type="READONLY" scope="SESSION">
                    <cfdump var="#evaluate(i)#">
               </cflock>
           </cfcase>
           <cfcase value="application">
               <!--- also should lock the application scoped variables --->
               <cflock timeout="10" type="READONLY" scope="APPLICATION">
                    <cfdump var="#evaluate(i)#">
               </cflock>
           </cfcase>
           <cfdefaultcase>
                <cfdump var="#evaluate(i)#">
           </cfdefaultcase>
        </cfswitch>
        <cfcatch>
            <p>An error occurred while trying to display <strong><cfoutput>#i#</cfoutput></strong> variables.</p>
        </cfcatch>
    </cftry>
  </cfloop>
 </div>
</cfif>

<cfif isDefined("url.debug")>
  <cfdump var="#session.auth#">
</cfif>

</body>

</html>