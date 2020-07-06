component extends="Model" output="false" {

    public void function init(){
        table("crud");
        property(
            name="datetime",
            sql="DATE_FORMAT(createdAt,'%Y-%m-%dT%TZ')"
        );
        property(
            name="$id",
            sql="id"
        );
    }

}
