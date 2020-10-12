component extends="controller" {

  public function index(){
    var tagsToInclude = "'fc,fc_membership,fc_structures,fc_finance,fc_positions,fc_executive,fc_transition,fc-execs-plus,fc_execs,fc_admin'"
    var whereString = "tag IN #tagsToInclude# AND username='tomavey'"
    var includeString = "Handbookperson(state)"
    var selectString="tag,fname,lname,city,state_mail_abbrev AS state,CONCAT(fname,' ',lname,'; ',city,', ',state) AS selectName,phone AS homephone,phone2 AS mobilephone,phone3 AS officephone,email,email2"
    var members = model("Handbooktag").findAll(select=selectString, where=whereString, include=includeString)
    data=queryToJson(data=members, useSerializeJSON = true);
    renderPage(layout="/layout_json", template="/json.cfm", hideDebugInformation="true");
  }

}