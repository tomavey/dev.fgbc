component extends="Model" output="false" {

	public void function init() {
		table("equip_course_resources");
		belongsTo("Conferencecourse");	
	}
}
