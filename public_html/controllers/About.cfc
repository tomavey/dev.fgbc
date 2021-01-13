//TODO: Finish Coversion to cfscript - however, not sure this controller is used
<cfcomponent extends="Controller" output="false">

<cfscript>
	function config(){
		filters(through="showContent", except="contactUs,cci,cci_es,commoncommitment,ccm")
		return this
	}

	function commonCommitment(){
		redirectTo(controller="page", action="64")
	}

	function ccm(){}
	function contactUs(){}
	function manualOfProcedure(){}
	function ourConstitution(){}
	function ourStory(){}
	function statementOfFaith(){}
	function messageOfTheBrethrenMinistry(){}

	function showContent (){
		setreturn()
		switch(params.action) {
			case "constitution":
				params.key=18
				break;
			case "commoncommitment":
				params.key=64
				break;
			case "ccm":
				params.key=64
				break;
			case "manualOfProcedure":
				params.key=19
				break;
			case "statementOfFaith":
				params.key=30
				break;
			case "ourStory":
				params.key=33
				break;
			case "messageOfTheBrethrenMinistry":
				params.key=59
				break;	 	
		}
		content = model("Maincontent").findByKey(params.key)
		if ( !isObject(content) ) {
			flashInsert(error="Content #params.key# was not found")
			redirectTo(action="index")
		}
	}

	public function cci(){
	}

	public function cci_es(){
	}

	public function getFootnote(id){
			if ( isDefined('params.noFootnotes') ) {
					return "";
			}
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