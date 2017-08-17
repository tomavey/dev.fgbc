component extends="Model" output="false" {

	public void function init() {

                table("equip_events_instructors");
                belongsTo(name="event", model="Conferenceevent", foreignKey="eventid");
                belongsTo(name="instructor", model="Conferenceinstructor", foreignKey="instructorid");
	}

}
