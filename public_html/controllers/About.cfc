<cfcomponent extends="Controller" output="false">

	<!--- filters --->
	<cffunction name="init">
		<cfset filters(through="showContent", except="contactUs,cci,commoncommitment,ccm")>
		<cfreturn this>
	</cffunction>

	<cffunction name="commonCommitment">
		<cfset redirectTo(controller="page", action="64")>
	</cffunction>

	<cffunction name="ccm">

	</cffunction>

	<cffunction name="contactUs">

	</cffunction>

	<cffunction name="manualOfProcedure">

	</cffunction>

	<cffunction name="ourConstitution">

	</cffunction>

	<cffunction name="ourStory">

	</cffunction>

	<cffunction name="statementOfFaith">

	</cffunction>

	<cffunction name="messageOfTheBrethrenMinistry">

	</cffunction>

	<cffunction name="showContent">
		<cfset setReturn()>

		<cfswitch expression="#params.action#">
			<cfcase value = "constitution">
				<cfset params.key = 18>
			</cfcase>
			<cfcase value = "commoncommitment">
				<cfset params.key = 64>
			</cfcase>
			<cfcase value = "ccm">
				<cfset params.key = 64>
			</cfcase>
			<cfcase value = "manualOfProcedure">
				<cfset params.key = 19>
			</cfcase>
			<cfcase value = "statementOfFaith">
				<cfset params.key = 30>
			</cfcase>
			<cfcase value = "ourStory">
				<cfset params.key = 33>
			</cfcase>
			<cfcase value = "messageOfTheBrethrenMinistry">
				<cfset params.key = 59>
			</cfcase>
		</cfswitch>

		<!--- find record --->
		<cfset variables.content = model("Maincontent").findByKey(params.key)>

		<!--- check if the record exists --->
		<cfif not isObject(content)>
			<cfset flashInsert(error="Content #params.key# was not found")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cfscript>
		public function cci(){
		}

		public function getFootnote(id){
		    var footnote = "";
		    var footnotes = getFootnotesAsStruct();

		    footnote  = "<a href='###id#'><sup>" & id & "</sup></a><span class='popup'>" & footnotes[id] & "</span>";
		    return footnote;
		}

		public function getFootnotesAsStruct(){
		    var footnotes = model("Maincontent").findFootnotesAsStruct();
		    return footnotes;
		}
	</cfscript>
</cfcomponent>