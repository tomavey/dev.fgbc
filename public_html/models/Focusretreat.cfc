<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("focus_retreats")>

<!---Use on laptop--->
		<cfset uploadableFile(property="image", destination="#replace(GetBaseTemplatePath(),'index.cfm','')#images/")>		
		
<!---Use on alurium
		<cfset uploadableFile(property="image", destination="/home/fgbcalur/public_html/focus/images/")>
--->
		<cfset validatesUniquenessOf(property="regid")>
	</cffunction>

</cfcomponent>