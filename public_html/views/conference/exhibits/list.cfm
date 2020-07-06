<cfparam name="exhibits" required="true">

<div class="container">
    <cfoutput query = "exhibits">
        <div class="well">
                <cfif len(logo) && len(website)>
                    <a href="http://#fixWebsite(website)#">
                        <img src="/images/conference/exhibitors/#logo#" class="pull-right"/>
                    </a>
                <cfelseif len(logo)>    
                    <img src="/images/conference/exhibitors/#logo#" class="pull-right"/>
                </cfif>        
            <h2>
                #organization#
            </h2>
            <p>
                
                #description#
            </p>
            <p>
                <cfif len(website)>
                    <a href="http://#fixWebsite(website)#">#website#</a>
                </cfif>
            </p>
            
    <cfif gotRights("office")>
        #linkTo(text="Edit", controller="conference.exhibits", action="edit", key=id, class="pull-right")#
    </cfif>
        </div>
    </cfoutput>
</div>