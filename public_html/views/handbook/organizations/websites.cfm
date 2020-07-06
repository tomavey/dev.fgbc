<!--- <cfdump var="#websites#"> --->
<cfset count = 1>

<div class="container">
  <h3>
    Click the ID number to view the organizations page.  Click the web site to view the site.
  </h3>
  <div style="width:100%;font-size:1.3em;line-height:1.5">
  <cfoutput query='webSites' group="website">
    #linkto(text=selectName, controller="handbook.organizations", action="show", key=id, target="new")# === #linkto(text=fixWebSite(website), href="http://#fixWebSite(website)#", target="new", style="color:blue;font-weight:bold")#
    <br/>
    <cfset count = count + 1>
  </cfoutput>
  </div>
  
  <cfoutput>
    Count = #count#
  </cfoutput>
</div>
