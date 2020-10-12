component extends="Controller" {

  public function index(){
    var whereString = "name='fellowshipcouncil'"
    var includeString = "tags"
    var documents = model("Fcdocument").findAllThatExist(whereString, includeString)
    data=queryToJson(data=documents, useSerializeJSON = true);
    renderPage(layout="/layout_json", template="/json.cfm", hideDebugInformation="true");
  }

}