component extends="Model" output="false" {

	public void function init() {
		table('equip_homes')
	}
	
	public function findAllHosts(required string where, required string order) {
		whereString = createWhereString(arguments.where,"Host")
		var orderString = arguments.order
		return findAll(where=whereString, order=orderString)
	}

	public function findAllGuests(required string where, required string order) {
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
