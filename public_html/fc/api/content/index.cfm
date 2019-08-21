<cfcontent type="text/plain">
<cfsetting enablecfoutputonly="true">
<cfprocessingdirective suppresswhitespace="yes">
<cfsetting showdebugoutput="no">
<cfinvoke component="fc.api.control" 
  method="get_content_fc" 
  returnvariable="content" 
  name='#url.name#' 
  asJson="yes">

<cfoutput>#trim(content)#</cfoutput>


</cfsetting>
</cfprocessingdirective>
</cfsetting>
</cfcontent>