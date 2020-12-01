component extends="Controller" output="false" {

 public void function config(){
    filters(through="checkauth", except="new,content,show,index,email,questions,showjson,delete,list,submit");
    usesLayout("/layoutadmin");
  }

 public void function checkauth(){
    if (!gotrights("office")){
    rendertext("You don't have authorization to see this page.");
    }
 }

 public void function new(){
    welcome = "hello";
 }

 public void function content(){
    renderView(layout="/layout_json", template="content", hideDebugInformation=true)
 }

 public void function email(){
    ministryname = params.name;
    ministryid = params.id;
    contactemail = params.email;
    sendEMail(from="tomavey@fgbc.org", to=contactemail, subject="A New Cooperating Ministry application for #ministryname#", template="email", layout="/layout_for_email");
    renderView(template="emailsent");
 }

 public void function submit(){
        var requestBody = "";
        if (isDefined("params.test")) {
            requestBody = "{'need some test data'}";
        }
        else {
            requestBody = toString(getHttpRequestData().content);
        };

        var params.answer = jsonToStruct(requestBody);
        var list = ["createdAt","deletedAt","updatedAt"];

        for (answer in params.answer) {
          for (field in list) {
            if (answer is field) {
              structDelete(params.answer,field)
            };
          };
        };


        if (isdefined("params.answer.id")) {
          answer = model("Crud").findOne(where = "id=#params.answer.id#");
          if (answer.update(params.answer)){
            data=true;
          }
          else {
            data=false;
          }
        }
        else
        {
          var answer = model("Crud").new(params.answer);
          if (answer.save()){
              data = true;
           }
           else {
              data=false;
           };
        }

        renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
        }

 public void function  list(){
    var answers = model("Crud").findAll();
    answers = queryToJson(answers);
    data = answers;
    renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
  }

  public void function delete(){
    var item = model("Crud").findOne(where="id = #params.id#");
    var delete = item.delete();
        if (delete){
            data = true;
         }
         else {
            data=false;
         };
        renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
  }

  public void function showjson(){
    var answer = model("Crud").findAll(where="id=#params.id#");
        if(answer.recordcount){
            data = queryToJson(answer);
        }
          else {
              data=false;
        };
        renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
  }

}