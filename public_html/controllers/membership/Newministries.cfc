component extends="Controller" output="false" {

 public void function init(){
    filters(through="checkauth", except="new,questions,show,index,email");
    usesLayout("/layout");
  }

 public void function checkauth(){
    if (!gotrights("office")){
    rendertext("You don't have authorization to see this page.");
    }
 }

 public void function new(){
    welcome = "hello";
 }

 public void function questions(){
    renderPage(layout="/layout_json", template="questions", hideDebugInformation=true)
 }

 public void function email(){
    ministryname = params.name;
    ministryid = params.id;
    contactemail = params.email;
    sendEMail(from="tomavey@fgbc.org", to=contactemail, subject="A New Cooperating Ministry application for #ministryname#", template="email", layout="/layout_for_email");
    renderPage(template="emailsent");
 }

}