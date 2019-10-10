<!--- <cfdump var="#websites#"> --->

<cfoutput query='webSites'>
  #linkto(text=id, controller="handbook.organizations", action="show", key=id, target="new")# - #linkto(text=fixWebSite(website), href="http://#fixWebSite(website)#", target="new")# 
  <br/>
</cfoutput>