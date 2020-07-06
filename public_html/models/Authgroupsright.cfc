component extends="Model" output="false" {

	function init(){
		table("auth_groupsrights")
		belongsTo(modelName="Authgroup", name="Group", foreignKey="auth_groupsId")
		belongsTo(modelName="Authright", name="Right", foreignKey="auth_rightsId")
	}

}
