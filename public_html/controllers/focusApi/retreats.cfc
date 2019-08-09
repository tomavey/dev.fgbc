component extends="Controller" {

  public function init(){
  }

  private function renderJson(){
    renderPage(layout="/layout_json", template="/json", hideDebugInformation=true)
  }

  public function test(){
    var retreat = retreat('southwest12')
    writeDump(retreat);abort;
  }

  public function retreat() {
    var whereString = ""
    if ( isDefined("params.regid") ) {
      whereString = "regid='#params.regid#'"
    }
    if ( isDefined("params.id") ) {
      whereString = "id='#params.id#'"
    }
    if ( isDefined("params.menuname") ) {
      whereString = "menuname='#params.menuname#'"
    }
    data = queryToJson(model('Focusretreat').findAll(where=whereString, order="createdAt DESC", maxrows="1"))
    writeOutput("retreat");abort;
    renderJson()
  }

  public function retreatItems() {
    var whereString = ""
    if ( isDefined("params.regid") ) {
      retreatId = getRetreatIdFromRegid(regid)
      whereString = "retreatId='#retreatId#'"
    }
    if ( isDefined("params.retreatId") ) {
      whereString = "retreatId='#params.retreatId#'"
    }
    if ( isDefined("params.menuname") ) {
      var retreatId = getLatestRetreatIdFromMenuName(params.menuname)
      whereString = "retreatId='#retreatId#'"
    }
    var retreatItems = model("Focusitem").findall(where=whereString)
    data = queryToJson(retreatItems)
    renderJson()
  }

  public function registrations() {
    var whereString = ""
    if ( isDefined("params.regid") ) {
      whereString = "regid='#params.regid#'"
    }
    if ( isDefined("params.retreatId") ) {
      whereString = "retreatId='#params.retreatId#'"
    }
    if ( isDefined("params.menuname") ) {
      var retreatId = getLatestRetreatIdFromMenuName(params.menuname)
      whereString = "retreatId='#retreatId#'"
    }
    var includeString = "item(retreat),registrant,invoice"
    var selectString = "id, retreatId, registrantid, itemid, invoiceid, quantity, cost, name, description, regid, menuname, fname, lname, fullnamelastfirst, fullnamelastfirstid, orderid, email, phone"
    var registrations = model("Focusregistration").findall(where=whereString, select=selectString, include=includeString)
    data = queryToJson(registrations)
    renderJson()
  }

  private function getLatestRetreatIdFromMenuName(menuname) {
    var whereString = "menuname='#menuname#'"
    var retreatId = model('Focusretreat').findAll(where=whereString, order="createdAt DESC", maxrows="1").id
    return retreatId
  }

  private function getRetreatIdFromRegid(regid) {
    var whereString = "id='#regid#'"
    var retreatId = model('Focusretreat').findOne(where=whereString).id
    return retreatId
  }

  public function retreatGeneralInfo(){
    var selectString = "name, content"
    var contents = model("Focuscontent").findall(select=selectString)
    var jsonString = '[{'
    for ( content in contents) {
      jsonString = jsonString & ',"' & contents.name & '":' & '"' & escapeString(contents.content) & '"'
    }
    data = replace(jsonString,",","","one") & '}]'
    renderJson()
  }
}