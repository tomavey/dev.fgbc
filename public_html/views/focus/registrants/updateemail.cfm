<cfparam name="formaction" default="updateemail">
<!--- <cfscript>
  for ( email in emaillist ) {
    writeOutput(
      #email.newEmail# - #email.currentEmail#<br/>
    )
  }
</cfscript> --->
<cfoutput>
  <cfif flashKeyExists("success")>
    <p class="well" style="font-weight:bold;font-size:1.5em;color:red">
      #flash("success")#
    </p>
  </cfif>  
  <cfif arrayLen(emailList)>
    <p>
      #linkTo(
        text="Make all these changes", 
        controller="focus.registrants", 
        action="updateemail", 
        params="oldEmail=#args.oldEmail#&newEmail=#args.newEmail#&wholeword=#args.wholeword#&go=true",
        class="btn")#
    </p>
    <cfloop array='#emaillist#' index="email">
      #email.currentEmail# => #email.newEmail#<br/>
    </cfloop>
  <cfelse>
    <h1>Update multiple emails in focus registrations</h1>
    <p>Use this form to update multiple emails in past focus retreat registrants. 
      <ul>
        <li>Step ##1: Enter either a full email address or part of an email address (ie: everything after the "@"). </li>
        <li>Step ##2: The next page will show you the updates that have not yet been posted.</li>
        <li>Step ##3: On that page click "Make all there changes" to update the database.</li>
      </ul>
    </p> 

    #startFormTag(action=formaction)#

    #textFieldTag(Name='oldEmail', label='Current Email (or part of email): ')#

    #textFieldTag(Name='newEmail', label='New Email (or part of email): ')#

    #submitTag("View the changes then update.")#
				
    #endFormTag()#
  </cfif>
</cfoutput>
