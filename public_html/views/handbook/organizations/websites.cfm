<!--- <cfdump var="#websites#"> --->

<cfoutput query='webSites'>
  #linkto(text=id, controller="handbook.organizations", action="show", key=id)# - #linkto(text=fixWebSite(website), href="http://#fixWebSite(website)#", target="new")# 
  <cftry>
    <cfif !urlExists(fixWebSite(website))>
      <span>...WEBSITE NOT WORKING!!!</span>  
    </cfif>
  <cfcatch>
    <span>...WEBSITE NOT WORKING!!!</span>
  </cfcatch>  
  </cftry>
  <br/>
</cfoutput>