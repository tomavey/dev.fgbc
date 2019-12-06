component extends="Model" output="false" {

	public void function init() {
		table('equip_homes')
	}
	
	public function findAllHosts() {
		return findAll(where="type='Host'")
	}

	public function findAllGuests() {
		return findAll(where="type='Guest'")
	}

}
