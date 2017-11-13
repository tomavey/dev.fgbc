<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
	</cffunction>

<!--------------------------------->
<!------------CRUD----------------->
<!--------------------------------->


	<!--- contents/index --->
	<cffunction name="index">
		<cfset setreturn()>
		<cfset contents = model("Maincontent").findAll(order="createdAt DESC")>
	</cffunction>

	<!--- contents/show/key --->
	<cffunction name="show">
		<cfset setreturn()>

		<!--- Find the record --->
		<cfif val(params.key) and len(params.key) LTE 4>
				<cfset whereString = "id=#params.key#">
		 <cfelse>
		 		<cfset whereString = "shortlink='#params.key#'">
		</cfif>

   		<cfset content = model("Maincontent").findOne(where=whereString)>
		

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="Content #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

<!---Special view controllers--->

	<cffunction name="manualOfProcedure">
   		<cfset content = model("Maincontent").findByKey(19)>
		<cfset renderpage(action="show")>
	</cffunction>

	<cffunction name="charisgraphics">
   		<cfset content = model("Maincontent").findByKey(78)>
		<cfset renderpage(action="show")>
	</cffunction>

	<cffunction name="constitution">
   		<cfset content = model("Maincontent").findByKey(18)>
		<cfset renderpage(action="show")>
	</cffunction>

	<cffunction name="statementoffaith">
   		<cfset content = model("Maincontent").findByKey(30)>
		<cfset renderpage(action="show")>
	</cffunction>

	<cffunction name="newname">
   		<cfset content = model("Maincontent").findByKey(101)>
		<cfset renderpage(action="show")>
	</cffunction>

	<cffunction name="newnameQA">
   		<cfset content = model("Maincontent").findByKey(102)>
		<cfset renderpage(action="show")>
	</cffunction>

</cfcomponent>
