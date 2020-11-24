component extends="Model" output="false" {

	public void function config() {
		table('equip_homes')
		property(
			name="selectNameId",
			sql="CONCAT(equip_homes.homeid,'(',equip_homes.name,')')"
		)
		// validatesUniquenessOf(property="homeid", condition="isDefined('this.homeid') && len(this.homeid) != 0 && this.type != 'guest'", message="Sorry, this home id is already assigned.")
		// validatesLengthOf(property="homeid", condition="isDefined('this.homeid') && len(this.homeid) != 0 && this.approved == 'yes'", message="A Home ID must be set for approved homes.")
	}
	
	public function findAllHosts(where="", order="") {
		whereString = createWhereString(arguments.where,"Host")
		writeDump(whereString);abort;
		var orderString = arguments.order
		return findAll(where=whereString, order=orderString)
	}

	public function findAllGuests(where="", order="") {
		whereString = createWhereString(arguments.where,"Guest")
		var orderString = arguments.order
		return findAll(where=whereString, order=orderString)
	}

	function createWhereString(required string where, required string type) {
		var whereString = ""
		IF ( len(arguments.where) ) { 
			whereString = arguments.where & " AND type='#arguments.type#'" 
		} ELSE { 
			whereString = "type='#arguments.type#'"
		}
		return whereString
	}

}
