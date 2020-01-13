component extends="controller" {
  
  public function index(){
    var whereString = "tag='fc' AND username='tomavey'"
    var includeString = "Handbookperson(state)"
    var members = model("Handbooktag").findAll(where=whereString, include=includeString)
    data=queryToJson(members);
    renderPage(layout="/layout_json", template="/json.cfm", hideDebugInformation="true");
  }

}