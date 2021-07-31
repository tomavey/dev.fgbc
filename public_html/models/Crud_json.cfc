component extends="Model" output="false" {

    public void function config(){
        table("Json");
        beforeSave("setTable");
    }

    public void function setTable(){
        this.table = "crud";
    }

}
