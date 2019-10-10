<!--- <cfdump var="#websites#"> --->
<cfset count = 1>
<cfoutput query='webSites' group="website">
  #linkto(text=id, controller="handbook.organizations", action="show", key=id, target="new")# - #linkto(text=fixWebSite(website), href="http://#fixWebSite(website)#", target="new")#
  <br/>
  <cfset count = count + 1>
</cfoutput>

<cfoutput>
  Count = #count#
</cfoutput>