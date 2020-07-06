<cfcomponent extends="Model" output="false"><cfscript>

	function init() {
		table("equip_coursequestions");
		belongsTo(name="person", modelName="Conferenceperson", foreignKey="personid");
		belongsTo(name="course", modelName="Conferencecourse", foreignKey="courseid")
	}

</cfscript></cfcomponent>
