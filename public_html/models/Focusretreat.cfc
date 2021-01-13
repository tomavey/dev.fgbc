//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("focus_retreats")>
		<cfset hasMany(name='focusitems', modelName="Focusitem", foreignKey="id")>

<!---Use on laptop
		<cfset uploadableFile(property="image", destination="#replace(GetBaseTemplatePath(),'index.cfm','')#images/")>		
--->
		
<!---Use on alurium
		<cfset uploadableFile(property="image", destination="/home/fgbcalur/public_html/focus/images/")>
--->
		<cfset validatesUniquenessOf(property="regid")>

	</cffunction>

</cfcomponent>