component extends="Model" output="false" {

	function config(){
		table("auth_usersgroups")
		belongsTo(name="Group", modelName="auth_groups", foreignKey="auth_groupsid")
		belongsTo(name="User", foreignKey="auth_usersid")
		hasMany(name="Groupsright", foreignKey="auth_groupsid") //not sure this is needed
	}

}
