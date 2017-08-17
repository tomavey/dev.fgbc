<div id="footer"><p><cfoutput>#session.auth.email#</cfoutput> - If you are having trouble reading Word 2007 files (.docx), use this link to download and install a translator: <a href="http://www.microsoft.com/downloads/details.aspx?familyid=941b3470-3ae9-4aee-8f43-c6bb74cd1466&displaylang=en"> http://www.microsoft.com/downloads/details.aspx?familyid=941b3470-3ae9-4aee-8f43-c6bb74cd1466&displaylang=en</a> </p></div>
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

<cfif isdefined("url.debug")>
	Session:<cfdump var="#session#">
	Cookies:<cfdump var="#cookie#">
</cfif>


</body>

</html>