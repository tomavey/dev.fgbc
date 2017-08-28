component extends="Controller" output="false" {
  
  public void function init(){
    usesLayout("/conference/layout2017");
    filters(through="getCourses", only="new,edit,create");
    filters(through="setReturn", only="index,list");
  }

  private function getCourses(orderby="title", type="cohort", event=getEvent()){
		courses = model("Conferencecourse").findAll(where="event='#arguments.event#' AND type='#arguments.type#'", order=arguments.orderby, type="#arguments.type#", event=arguments.event);
  }

  // Conferencecourseresources/index
  public void function index(){
    Resources = model("Conferencecourseresource").findAll(include="course", order="createdAt DESC");
  }
  
  // Conferencecourseresources/list
  public void function list(){
    var whereString = "";
    if (isDefined("params.courseid")){
      whereString = "courseid=#params.courseid#";
      Resource.courseTitle = model("Conferencecourse").findOne(where="id=#params.courseid#").title;
    }
    if (isDefined("params.search")){
      whereString = "title LIKE '%#params.search#%' OR comment LIKE '%#params.search#%'";
    }
      Resources = model("Conferencecourseresource").findAll(where=whereString, include="course", include="course", order="courseid, createdAt DESC");
  }

  // Conferencecourseresources/show/key
  public void function show(){
    Resource = model("Conferencecourseresource").findOne(where="uuid='#params.key#'");
    Resource.courseTitle = model("Conferencecourse").findOne(where="id=#resource.courseid#").title;
    	
    if (!IsObject(Resource)){
      flashInsert(error="Resource #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // Conferencecourseresources/new
  public void function new(){
    Resource = model("Conferencecourseresource").new();
      message = "Create a new resource";
    if (isDefined("params.courseid")){
      Resource.courseid = params.courseid;
      Resource.courseTitle = model("Conferencecourse").findOne(where="id=#params.courseid#").title;
      message = "Create a new resource for #Resource.courseTitle#";
      };
    formaction = "create";
  }
  
  //Conferencecourseresources/edit/key
  public void function edit(){
    Resource = model("Conferencecourseresource").findOne(where="uuid='#params.key#'");
    formaction = "update";
    message = "Edit this resource";
    	
    if (!IsObject(Resource)){
	    flashInsert(error="Resource #params.key# was not found");
			redirectTo(action="index");
	  }
    renderPage(template="new");
  }
  
  // Conferencecourseresources/create
  public void function create(){

    Resource = model("Conferencecourseresource").new(params.resource);

    if (!gotRights("office")){
      var captchaValue = params["g-recaptcha-response"];
      var httpService = new http(method = "POST", charset = "utf-8", url = "https://www.google.com/recaptcha/api/siteverify"); 
      httpService.addParam(name = "response", type = "formfield", value = "#captchaValue#"); 
      httpService.addParam(name = "secret", type = "formfield", value = "6Lc-MB4TAAAAAOcSyIJ0Y1Gd9dZnrJU5SrgfOXBs"); 
      var result = httpService.send().getPrefix(); 

 
      if (!deserializeJson(result.filecontent).success) {
          flashInsert(error="Be sure to click the captcha button!");
          redirectTo(action="new");
      };
    };


    Resource.uuid = CreateUUID();
    Resource.uuid = replace(resource.uuid,"-","","all");

    Resource.url_exists = urlExists(resource.link);
    
    if (isDefined("Resource.uploaded_file") && len(Resource.uploaded_file)){
      var directory = GetDirectoryFromPath(GetBaseTemplatePath()) & "files\courseresources";
      var mimetypes = getMimeTypes();
      try {
      var result = fileUpload('#directory#',Resource.uploaded_file,mimetypes,'overwrite');
      Resource.uploaded_file = result.serverFile;
      if (result.filewassaved){
          Resource.file_saved = "yes"
          }
      else {
        writeDump(result);abort;
        };
      }
      catch (any e)
      {
        flashInsert(error="There was an error creating the resource: #e.message#");
        redirectTo(action="new");
      }  
    }
    

    message = "Create a new resource";
    formaction = "create";

		if (Resource.save()){
			flashInsert(success="The resource was created successfully.");
      sendEditEmail(resource.author_email,resource.uuid);
      returnBack();
		} else {
		  flashInsert(error="There was an error creating this resource.");
      message = "oops";writeDump(message);
		  renderPage(action="new");
		}
  
  }
  
  // Conferencecourseresources/update
  public void function update(){
    Resource = model("Conferencecourseresource").findOne(where="uuid='#params.resource.uuid#'");
		
		if (Resource.update(params.resource)){
		  flashInsert(success="The resource was updated successfully. Check your email for an edit link.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error updating the resource.");
			renderPage(action="edit");
		}
    returnBack();
  }
  
  // Conferencecourseresources/delete/key
  public void function delete(){
    Resource = model("Conferencecourseresource").findOne(where="uuid='#params.key#'");

		if (Resource.delete()){
			flashInsert(success="The resource was deleted successfully.");
      if (isDefined("params.return") && params.return is "list"){
        redirectTo(action="list");
      }
      else {
        redirectTo(action="index");
      };
    } else {
      flashInsert(error="There was an error deleting the resource.");
      if (isDefined("params.return") && params.return is "list"){
        redirectTo(action="edit");
      }
      else {
        redirectTo(action="index");
      };
    }
  }

  public function getAdminEmail(){
    return "tomavey@fgbc.org";
  }

  public function sendEditEmail(required string email, required string uuid){
   var confirmation = "";
   try {
   sendEmail(
      to=email, 
      from=getAdminEmail(), 
      type="html", 
      subject="Your Cohort Resource Post", 
      cc=getAdminEmail(), 
      template="sendEditEmail", 
      layout="/layout_for_email",
      uuid = uuid);
      confirmation = true;
   }
   catch (any e) {
    confirmation = false;
   }
    return confirmation;  
  }

  private function getMimeTypes(){
    return 'application/epub+zip,
    application/java-archive,
    application/javascript,
    application/json,
    application/msword,
    application/octet-stream,
    application/ogg,
    application/pdf,
    application/rtf,
    application/vnd.amazon.ebook,
    application/vnd.apple.installer+xml,
    application/vnd.mozilla.xul+xml,
    application/vnd.ms-excel,
    application/vnd.ms-excel,
    application/vnd.mspowerpoint,
    application/vnd.ms-powerpoint,
    application/vnd.oasis.opendocument.presentation,
    application/vnd.oasis.opendocument.spreadsheet,
    application/vnd.oasis.opendocument.text,
    application/vnd.openxmlformats-officedocument.presentationml.presentation,
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,
    application/vnd.openxmlformats-officedocument.wordprocessingml.document,
    application/vnd.visio,
    application/x-7z-compressed,
    application/x-abiword,
    application/x-bzip,
    application/x-bzip2,
    application/x-csh,
    application/xhtml+xml,
    application/x-iwork-keynote-sffkey,
    application/x-iwork-numbers-sffnumbers,
    application/x-iwork-pages-sffpages,
    application/xml,
    application/x-rar-compressed,
    application/x-sh,
    application/x-shockwave-flash,
    application/x-tar,
    application/zip,
    audio/*,
    audio/3gpp,
    audio/3gpp2,
    audio/midi,
    audio/mpeg,
    audio/ogg,
    audio/webm,
    audio/x-wav,
    font/ttf,
    font/woff,
    font/woff2,
    image/gif,
    image/jpeg,
    image/pjpegimage/jpg,
    image/png,
    image/svg+xml,
    image/tiff,
    image/webp,
    image/x-icon,
    text/calendar,
    text/css,
    text/csv,
    text/html,
    text/plain,
    video/3gpp,
    video/3gpp2,
    video/mp4,
    video/mpeg,
    video/ogg,
    video/webm,
    video/x-msvideo,
    video/x-ms-wmv';
  }

}
