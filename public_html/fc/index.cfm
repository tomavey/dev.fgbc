<!--- 
 ************************************************************
 *
 * "Lite" version of Fusebox framework. This version has less
 * indirection than the "formal" version and is far less code.
 *
 ************************************************************
 --->


 <!--- Local Settings --->


 <CFPARAM NAME="traceOn" DEFAULT="False">   <!--- useful for debugging --->
 <CFPARAM NAME="pageTitle" DEFAULT="Fellowship Council">
 <CFPARAM NAME="defaultFuseAction" DEFAULT="content">


<cfscript>
  control = createObject("control")
  dsn = "fgbc_main_3"
</cfscript>



 <!---  --->


 <cfset fusebox = structNew()>


 <!--- Get fuseaction from either url or form --->


 <cfif isDefined('url.fuseaction')>
   <cfset fusebox.fuseaction = url.fuseaction>
 <cfelseif isDefined('form.fuseaction')>
   <cfset fusebox.fuseaction = form.fuseaction>
 <cfelse>
   <cfset fusebox.fuseaction = defaultFuseAction>
 </cfif>



 <cfif traceOn>   <!--- Output to HTML comment --->
   <!-- TRACE: using fuseaction: <cfoutput>#fusebox.fuseaction#</cfoutput> -->
 </cfif>


 <cfinclude template="fbx_utils.cfm">    <!--- optional --->


 <cfinclude template="fbx_switch.cfm">


