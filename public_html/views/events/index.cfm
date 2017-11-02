<cfoutput> 
<div class="row-fluid well contentStart contentBg">
    <div class="span3">
        #includePartial(partial="sidebar", selected="home")#
    </div>

    <div class="span9">
        <div id="instructions">
          #getcontent("events").content#
        <cfif gotrights("superadmin,office")>
            <div id="addnew">
        		    #linkTo(text="<i class='icon-edit'></i>", controller="admin.events", action="index")#
            </div>
        </cfif>
     </div>
  <cfoutput query="events">
  <cfif isbefore(begin)>
       <div class="well ajaxdelete">
            <div class="begin">
                          <cfif begin eq end>
                              #dateformat(begin,"medium")#
                          <cfelse>
                              <cfif datepart("m",begin) is datepart("m",end)>
                                #dateformat(begin,"MMM")# #dateformat(begin,"dd")# - #dateformat(end,"dd")#, #dateformat(begin,"yyyy")#
                              <cfelse>
                                #dateformat(begin,"MMM")# #dateformat(begin,"dd")# - #dateformat(end,"MMM")# #dateformat(end,"dd")#, #dateformat(begin,"yyyy")#
                              </cfif>
                          </cfif>
            </div>
            <h2>
                 <a href="#eventlink#">#event#</a>
            </h2>
            <div class="sponsor">
                 Sponsor: <a href="#sponsorlink#">#sponsor#</a>
            </div>
       </div>
  </cfif>     
  </cfoutput>
     </div>
</div>
</cfoutput>
