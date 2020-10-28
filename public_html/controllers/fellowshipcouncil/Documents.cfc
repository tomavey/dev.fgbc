component extends="Controller" {

  public function init() {
  }

	function setAccessControlHeaders() {
		cfheader( name="Access-Control-Allow-Origin", value="http://localhost:8080/" );
		cfheader( name="Access-Control-Allow-Methods", value="GET,PUT,POST,DELETE" );
		cfheader( name="Access-Control-Allow-Headers", value="Content-Type" );
		cfheader( name="Access-Control-Allow-Credentials", value=true );
	}

  public function index(){
    var whereString = "name='fellowshipcouncil'"
    var includeString = "tags"
    var documents = model("Fcdocument").findAllThatExist(whereString, includeString)
    data=queryToJson(data=documents, useSerializeJSON = true);
    renderPage(layout="/layout_json", template="/json.cfm", hideDebugInformation="true");
  }

  public function update(content = "Here's some new content for my file"){
    arguments.content = '#dateTimeFormat(now())#' & '-- ' & arguments.content
    var requestBody = toString(getHttpRequestData().content);
    consoleLog(requestBody)
    data = [{'content':content}]
    data = serialize(data)
    renderPage(layout="/layout_json", template="/json.cfm", hideDebugInformation="true");
  }

  public function consoleLog(newContent){
    var file = getBaseFcDocsFolder() & "console.log.html"
    var content = fileRead(file)  
    fileWrite(file, newContent & "<br/><br/>" & content);
    var content = fileRead(file)  
    // ddd(content)
  }

  public function getBaseFcDocsFolder( folder, baseFolder=GetDirectoryFromPath(GetBaseTemplatePath()) ){
    return baseFolder & "fc\documents\"
  }
}