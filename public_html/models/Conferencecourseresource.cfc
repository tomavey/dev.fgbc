component extends="Model" output="false" {

	public void function init() {
		table("equip_course_resources");
		belongsTo(name="course", modelName="Conferencecourse", foreignKey="courseid");	
		validatesPresenceOf(properties="Author", minimum=5, Message="Authors full name required");
		validatesNumericalityOf(properties="courseid", Message="Please select a cohort from the drop down list.");
		validatesPresenceOf(properties="Author_email", minimum=5, Message="Please provide a valid email address");
		validate(method="validateEmailFormat");
	}

	private function validateEmailFormat () {
    if (!IsValid("email", this.author_email)) {
        addError(property="author_email", message="Email address is not in a valid format.");
	}
	}
}
