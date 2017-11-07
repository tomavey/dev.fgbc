component extends="Controller" output="false" {



  public void function init(){
  }

  public function usetestlist(){
    if (isDefined('session.handbook.sendemail') && session.handbook.sendemail == true)
      {return false;}
        else
      {return true;}
  }

  public function testlist(){
    var list = "tomavey@fgbc.org,tomavey@comcast.net";
    return list;
  }

  public function testlistasquery(){
    var list = testlist();
    list = listToQuery(list,"email");
    return list;
  }

  public function turnOffTestList(){
    session.handbook.sendemail = true;
    redirectTo(action="index");
  }

  public function turnOnTestList(){
    session.handbook.sendemail = false;
    redirectTo(action="index");
  }

  // sendemails/index
  public void function index(){
    sendemails = model("Fgbcsendemail").findAll();
  }

  // api/sendemails/json
  public void function json(){
    sendemails = model("Fgbcsendemail").findAll(select="id,subject,strSentAt,sentTo,fromemail,fromname,tags,strcreatedAt");
    data = queryToJson(sendemails);
    renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)
  }

  // sendemails/show/key
  public void function show(){
    sendemails = model("Fgbcsendemail").findByKey(params.key);

    if (!IsObject(sendemails)){
      flashInsert(error="Send-emails #params.key# was not found");
      redirectTo(action="index");
    }
  }

  // sendemails/new
  public void function new(){
    sendemails = model("Fgbcsendemail").new();
    if (isDefined("session.auth.username")) {
    sendemails.tagsusername = session.auth.username;
    sendemails.backgroundcolor = '##4D7486';
    };
  }

  //sendemails/edit/key
  public void function edit(){
    sendemails = model("Fgbcsendemail").findByKey(params.key);

    if (!IsObject(sendemails)){
	    flashInsert(error="Send-emails #params.key# was not found");
			redirectTo(action="index");
	  }
  }

  //sendemails/send/key
  public void function send(){
    allEmails = "";
    message = model("Fgbcsendemail").findOne(where="id=#params.key#");
    if (!len(message.tagsusername) AND isDefined('session.auth.username')) {
      message.tagsusername = session.auth.username;
    }
    if (useTestList()){
      sendemails = testlistasquery();
      message.subject = "TEST: " & message.subject;
    }
    else
    {
      sendemails = model("Handbooktag").findAllTags(message.tags,message.tagsusername);
    }

    for ( i = 1 ; i LTE sendemails.RecordCount ; i = (i + 1))
    {
      if (isvalid("email",sendemails.email[i])) {

            sendEmail(subject=message.subject, to=sendemails.email[i], from=message.fromemail, template="sendemail", layout="layout_for_email", type="html");

          allEmails = allEmails & "," & sendemails.email[i];
          setSentAt(message.id);
          }
    }

    allEmails = replace(allEmails,",","","one");
    setSentTo(message.id,allEmails);

    if (message.sendplaintext)
    {
      renderPage(template="sendemail", layout="/layout_naked");
    }
    else
    {
      renderPage(template="sendemail", layout="layout_for_email");
    }
  }

  //sendemails/copy/key
  public void function copy(){
    sendemails = model("Fgbcsendemail").findByKey(params.key);

    if (!IsObject(sendemails)){
      flashInsert(error="Send-emails #params.key# was not found");
      redirectTo(action="index");
    }
  }

  // sendemails/create
  public void function create(){
    sendemails = model("Fgbcsendemail").new(params.sendemails);

		if (sendemails.save()){
			flashInsert(success="The send-emails was created successfully.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error creating the send-emails.");
		  renderPage(action="new");
		}
  }

  // sendemails/update
  public void function update(){
    sendemails = model("Fgbcsendemail").findByKey(params.key);

		if (sendemails.update(params.sendemails)){
		  flashInsert(success="The send-email was updated successfully.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error updating the sendemails.");
			renderPage(action="edit");
		}
  }

  // sendemails/delete/key
  public void function delete(){
    sendemails = model("Fgbcsendemail").findByKey(params.key);

		if (sendemails.delete()){
			flashInsert(success="The send-email was deleted successfully.");
      redirectTo(action="index");
    } else {
      flashInsert(error="There was an error deleting the send-email.");
			redirectTo(action="index");
    }
  }

  // sendemails/setSentAt
  private function setSentAt(id){
    message = model("Fgbcsendemail").findone(where="id=#id#");
    message.sentAt = now();
    message.update();
    return true;
  }

  // sendemails/setSentTo
  private function setSentTo(id,emails){
    var message = model("Fgbcsendemail").findone(where="id=#id#");
    message.sentTo = emails;
    message.update();
    return true;
  }

}
