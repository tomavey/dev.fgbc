component extends="Model" output="false" {

	public void function init() {
                table("fgbcsendemails");
                property(name="strSentAt", sql="date_format(sentAt,'%b %d %Y %h:%i %p')");
                property(name="strCreatedAt", sql="date_format(createdAt,'%b %d %Y')");
	}
}
