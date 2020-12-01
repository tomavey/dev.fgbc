component extends="Model" output="false" {

	public function config() {
		Table("handbookpositiontypes");
		hasMany(name="Handbookpositions", foreignKey="positiontypeid");
		beforeSave("positionTypeRequired");
		beforeUpdate("positionTypeRequired");
	}

}