component extends="Model" output="false" {

	public function init() {
		Table("handbookpositions");
		belongsTo(name="Handbookperson", foreignKey="personid", joinType="outer");
		belongsTo(name="Handbookorganization", foreignKey="organizationid", joinType="outer");
		belongsTo(name="Handbookpositiontype", foreignKey="positiontypeid");
		beforeUpdate("logUpdates,positionTypeRequired,setPositionSortOrderForDeceased");
		beforeSave("positionTypeRequired,setPositionSortOrderForDeceased");
		afterCreate("logCreates");
		afterDelete("logDeletes");
	}

	public function setPositionSortOrderForDeceased() {
		if ( val(this.positiontypeid) == 39 ) {
			this.p_sortorder = 999;
		}
	}

	public function positionTypeRequired() {
		if ( !val(this.positiontypeid) ) {
			this.positiontypeid = 12;
		}
	}

	public function logUpdates(modelName="Handbookposition", createdBy="na") {
		if ( isDefined("session.auth.email") ) {
			arguments.createdBy = session.auth.email;
		}
		old = model("#arguments.modelName#").findByKey(key=this.id);
		new = this;
		changes= new.changedProperties();
    for ( i in changes ) {
      if ( !i == "updatedAt" ) {
        newupdate.modelName = arguments.modelName;
        newupdate.recordId = this.id;
        newupdate.columnName = i;
        newupdate.datatype = "update";
        newupdate.olddata = old[i];
        newupdate.newData = new[i];
        newupdate.createdBy = "#arguments.createdBy#";
        update = model("Handbookupdate").create(newupdate);
      }
		}
		return true;
	}

	public function logCreates(modelName="Handbookposition", createdBy="#session.auth.email#") {
		newSave.modelName = arguments.modelName;
		newSave.recordId = this.id;
		newSave.datatype = "new";
		newSave.createdBy = "#arguments.createdBy#";
		update = model("Handbookupdate").create(newSave);
		return true;
	}

	public function logDeletes() {
		position = model("Handbookposition").findByKey(key=this.id);
		if ( isObject(position) ) {
			superLogDeletes('Handbookposition');
		}
		return true;
	}

}
