<cfoutput>
<div data-role="page" id="churches">

    <div data-role="header">
        #includePartial("/mobile/header")#
    </div><!-- /header -->

    <div data-role="content">

      <cfoutput query="job">
        
        <div class="well" >
        
        
                  <h1>#job.title#</h1>
                
                  <p>#job.description#</p>
        
                  <p><span>Email: </span>#mailTo(emailAddress=job.contactemail, encode=true)#</p>
                  
                  <cfif job.phone is not "">
                  <p><span>Phone: </span>#job.phone#</p>
                  </cfif>
                          
                  <p><span>Job post will expire: </span>#dateformat(job.expirationdate)#</p>
                
        </div>
        
      
      </cfoutput>
    </div><!-- /content -->

  <div data-role="footer" data-position="fixed">
    <div data-role="navbar">
      <cfset uiBtnActive = "opportunities">
      #includePartial(partial="/mobile/navbar")#
    </div><!-- /navbar -->
  </div><!-- /footer -->

</div><!-- /page -->

</cfoutput>