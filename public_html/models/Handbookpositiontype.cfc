component extends="Model" output="false" {

	public function init() {
		Table("handbookpositiontypes");
		hasMany(name="Handbookpositions", foreignKey="positiontypeid");
		beforeSave("positionTypeRequired");
		beforeUpdate("positionTypeRequired");
	}

}