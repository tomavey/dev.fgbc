<cfoutput>
<div data-role="page" id="churches">

    <div data-role="header">
        #includePartial(partial="/mobile/header")#
    </div><!-- /header -->

    <div data-role="content">
      <cfset count = 0>  
      <cfoutput query="churches" group="state">
        <h3>#state#</h3>
        <cfoutput>
            <cfset count = count + 1>
           <div class="well">
                <div class="name">
                    <cfif gotRights("handbook")>
                       #linkTo(text=name, controller="handbook.organizations", action="show", key=id, data_ajax=false)#
                    <cfelse>  
                       #name#
                    </cfif>
                </div>
                <div class="address1">
                     #address1#
                </div>
                <div class="address2">
                     #address2#
                </div>
                <div class="org_city">
                     #org_city#, #state# #zip#
                </div>
                <div class="phone">
                     #phone#
                </div>
                <div class="fax">
                		<cfif len(fax)>
                      Fax:
                      </cfif>
                     #fax#
                </div>
                <cfif gotrights("superadmin,office,handbook")>
                <div class="email">
                     <a href="mailto:#email#">#email#</a>
                </div>
                </cfif>
                <div class="website">
                		<cfset website = replace(website,"http://","","one")>
                     <a href="http://#website#">#website#</a>
                </div>
                <div class="meetingplace">
                     <cfif meetingplace is not "">Meeting at: #meetingplace#</cfif>
                </div>
                <div class="googlemap">
                <cfif not address1 contains "box">
                </cfif>
                </div>
                                
           </div>
        </cfoutput>    
        </cfoutput>    
        <p>Count = #count#
            </p>
    </div><!-- /content -->

  <div data-role="footer" data-position="fixed">
    <div data-role="navbar">
      #includePartial(partial="/mobile/navbar")#
    </div><!-- /navbar -->
  </div><!-- /footer -->

</div><!-- /page -->

</cfoutput>