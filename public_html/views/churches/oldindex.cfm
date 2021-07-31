<cfoutput>
<div class="row-fluid well contentStart contentBg">
  <div class="span3">
    #includePartial(partial="sidebar", selected="home")#
  </div>

  <div class="span9">

    <div>
    	#getcontent("churches").content#
    	<cfif gotrights("superadmin,office")>
    	    <div id="addnew">
    			#editTag()#
    	    </div>
    	</cfif>
    </div>


    <form id="searchform">
        Search: <input type="text" id="search">
    </form>

    </cfoutput>
    <div class="postbox statelist">

    	<cfoutput query="churchStates" group="state">
    	#linkTo(action='index', controller='churches', params="state=#state#", text=state)# &middot;  
    	</cfoutput>
    	<cfoutput>#linkTo(action="index", controller="churches", text="List All")#</cfoutput>
    </div>
   
    <div>
      
      <cfoutput query="churches" group="state">
        <h3>#state#</h3>
        <cfoutput>
           <div class="well">
                <div class="name">
                     #name#
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
 <cfoutput>
      </div>
  </div>
</div>
</cfoutput> 
