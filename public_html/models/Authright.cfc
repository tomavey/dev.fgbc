component extends="Model" output="false" {
	
	function init() {
		table("auth_rights")
		hasMany(name="Groupsright", modelName="Authgroup", foreignKey="auth_rightsId")
	}
}
