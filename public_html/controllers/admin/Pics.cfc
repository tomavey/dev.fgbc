component extends="Controller" output="false" {
  
  public function index(folder=""){
    if ( isdefined("params.folder") ) { folder = params.folder }
    files = directoryList(
      path="C:\Users\Surface Pro\Documents\inetpub\wwwroot\fgbc\public_html\images\#folder#", 
      type="file", 
      listInfo="name", 
      sort="size DESC",
      filter="*.jpg|*.png|.gif"
      )
    dirs = directoryList(path="C:\Users\Surface Pro\Documents\inetpub\wwwroot\fgbc\public_html\images\#folder#", type="dir", listInfo="name")
    folderName = folder
  }

  public function getBaseUrl(protocol=cgi.server_protocol, domain=cgi.http_host){
    if ( find("https",protocol) ) { protocol = "https" } else { protocol = "http" }
    return protocol & "://" & domain
    }

}