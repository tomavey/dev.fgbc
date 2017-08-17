component extends="Controller" output="false" {

 public void function init(){
    filters(through="checkauth", except="new,questions,show,index,email,editor");
    usesLayout("/conference/layout");
  }

 public void function checkauth(){
    if (!gotrights("office")){
    rendertext("You don't have authorization to see this page.");
    }
 }

 public void function new(){
    welcome = "hello";
    introTitle = "Lodging Request"
 }

 public void function show(){
    introTitle = "Lodging Request"
 }

 public void function index(){
    introTitle = "Lodging Request"
 }

 public void function questions(){
    renderPage(layout="/layout_json", template="questions", hideDebugInformation=true)
 }

 public void function email(){
    name = params.name;
    lodgingrequestid = params.id;
    email = params.email;
    sendEMail(from="tomavey@fgbc.org", to=email, subject="A New Lodging Assistance Request for #name#", template="email", layout="/layout_for_email");
    renderPage(template="emailsent");
 }

}