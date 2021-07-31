component extends="Model" output="false" {

	function config (){
		table(name="auth_groups")
		hasMany(name="Groupsright", model="Authgroupsright", shortcut="rights", foreignKey="auth_groupsId")
		nestedProperties(
			associations="Groupsright",
			allowDelete=true
		)
	}

}
