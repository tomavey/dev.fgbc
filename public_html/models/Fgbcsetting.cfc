component extends="Model" output="false" {

	public void function config() {
		table('fgbc_metas');
		validatesUniquenessOf(property="name", message="Settings name must be unique");
	}

}
