component extends="Controller" output="false" {
  
  public function index(folder=""){
    if ( isdefined("params.folder") ) { folder = params.folder }
    var dirPath = GetDirectoryFromPath(GetCurrentTemplatePath())
    ///ddd(GetDirectoryFromPath(GetBaseTemplatePath()))
    var filePath = getBaseImageFolder(folder) & "\" & folder
    ///ddd(filePath)
    files = directoryList(
      path=filePath, 
      type="file", 
      listInfo="query", 
      sort="directory ASC, size DESC, datelastmodified",
      filter="*.jpg|*.png|.gif"
      )
    dirs = directoryList(path=filePath, type="dir", listInfo="name")
    folderName = folder
  }

  public function getBaseUrl(protocol=cgi.server_protocol, domain=cgi.http_host){
    if ( find("https",protocol) ) { protocol = "https" } else { protocol = "http" }
    return protocol & "://" & domain
    }

  public function getBaseImageFolder( folder, baseFolder=GetDirectoryFromPath(GetBaseTemplatePath()) ){
    return baseFolder & "images"
  }

}