component extends="Model" output="false" {

    public void function init(){
        table("Json");
        beforeSave("setTable");
    }

    public void function setTable(){
        this.table = "crud";
    }

}
