component extends="Controller" output="false" {

  public function init(){
    filters(through="isOffice")
  }
  
  public function isOffice(){
    if ( gotrights('office') ) { return true }
    else { renderText("You do not have permission to view this page") }
  }

  public function index(folder=""){
    if ( isdefined("params.folder") ) { folder = params.folder }
    files = getFiles(folder)
    dirs = getDirs(folder)
    folderName = folder
  }

  public function uploadPic(){
      cffile(
        action="upload",
        fileField = "FileContents",
        destination = getBaseImageFolder(), 
        nameConflict = "MakeUnique",
        result = "results",
        );
      if ( results.filewassaved && find(" ",results.serverfilename) ) {
        var oldFileName = results.serverdirectory & "\" & results.serverfile
        var newFileName = replace(results.serverfile," ","_","all")
        cffile(
          action="rename",
          source=oldFileName,
          destination=newFileName,
          mode="664"
        );  
      }  
    redirectTo(action="index")
  }

  public function deletePic(pic = params.pic) {
    var fileToDelete = getBaseImageFolder() & "\" & pic
    try {
      cffile (
        action="delete",
        file= fileToDelete
      );
    } catch (any e) {
      renderText("oops... did not delete")
    }
    redirectTo(action="index")
  }

  public function getBaseUrl(protocol=cgi.server_protocol, domain=cgi.http_host){
    if ( find("https",protocol) ) { protocol = "https" } else { protocol = "http" }
    return protocol & "://" & domain
    }

  public function getBaseImageFolder( folder, baseFolder=GetDirectoryFromPath(GetBaseTemplatePath()) ){
    return baseFolder & "images"
  }

  private function getFiles(required string folder, sortBy="directory ASC, size DESC, datelastmodified"){
    var filePath = getBaseImageFolder(folder) & "\" & folder
    var files = directoryList(
      path=filePath, 
      type="file", 
      listInfo="query", 
      sort=sortBy,
      filter="*.jpg|*.png|.gif"
      )
      return files
  }

  private function getDirs(required string folder){
    var filePath = getBaseImageFolder(folder) & "\" & folder
    var dirs = directoryList(path=filePath, type="dir", listInfo="name")
    return dirs
  }

  public function filesAsJson(folder=""){
    if ( isdefined("params.folder") ) { folder = params.folder }
    data = queryToJson(getfiles(folder))
    renderJson(data)
  }

  public function dirsAsJson(folder=""){
    if ( isdefined("params.folder") ) { folder = params.folder }
    data = serializeJson(getDirs(folder))
    renderJson(data)
  }

  public function renderJson(required string data){
    renderPage(template="/json.cfm", layout="/layout_json.cfm", hideDebugInformation=true)
  }

}