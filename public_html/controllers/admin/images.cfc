component extends="Controller" {
  
  public function directory(folder=""){
    var loc = arguments
    if ( isdefined("params.folder") ) { loc.folder = params.folder }
    files = directoryList(path="C:\Users\Surface Pro\Documents\inetpub\wwwroot\fgbc\public_html\images\#loc.folder#", listInfo="name")
    dirs = directoryList(path="C:\Users\Surface Pro\Documents\inetpub\wwwroot\fgbc\public_html\images\#loc.folder#", type="dir", listInfo="name")
  }

}