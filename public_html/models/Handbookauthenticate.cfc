component extends="model" {

  function unLockCode(params){
    var thisemail = decrypt(params.unlockcode,getSetting("passwordkey"),"CFMX_COMPAT","HEX")
    var person = model("Handbookperson").findOne(where="email = '#thisemail#' OR email2='#thisemail#' OR spouse_email='#thisemail#'", include="Handbookstate")
    var auth = {}
    if (isobject(person)) {
      auth.email = thisemail
      auth.username = thisemail
      auth.handbook.basic = true
      auth.passedString = 'isdefined("params.unlockcode")'
    }
    if ( isMinistryStaff(person.id) ) {
      auth.rightslist = "handbook,ministrystaff"
    } else {
      auth.rightslist = "handbook"
    }
    return auth
    writeDump(auth);abort;
  }

  function isAlreadyAuthorized(){
    return 'isDefined("session.auth.handbook.basic") and session.auth.handbook.basic'
  }

  function isHandbookUpdater() {
    return 'isDefined("params.handbookUpdate") and val(params.handbookupdate)'
  }

  function isAlreadyLoggedInToMainSiteWithHandbookRights(params) {
    var auth = session.auth  
    auth.passedString = 'structKeyExists(session.auth,"rightslist") and NOT isdefined("params.logoutfirst") and NOT isDefined("params.reviewer") and NOT isDefined("params.handbookUpdate")'
    var handbookRightsRequiredArray = listToArray(getSetting('handbookRightsRequired'))
    for ( var item in handbookRightsRequiredArray ) {
      if ( listfind(session.auth.rightslist,item) ) {
        auth.handbook.basic = true
        if ( getSetting('allowHandbookAuthByCookie') ) {
          setAuthCookies()
        }
      }
    }
    return auth
  }

  function cookiesSet() {
    var auth = {}
    auth.passedString = 'isDefined("cookie.authhandbookbasic") AND cookie.authhandbookbasic'
    auth.email = cookie.authemail
    auth.rightslist = "basic"
    auth.handbook.basic = true
    return auth
  }

  function reviewer(required params){
    var auth = {}
    auth.passedString = 'isDefined("params.reviewer") and len(params.reviewer) and isDefined("params.orgid") and val(params.orgid) and allowHandbookOrgUpdate()'
    auth.email = params.reviewer
    auth.username = params.reviewer
    auth.rightslist = "basic"
    auth.handbook.basic = true
    auth.handbook.review = true
    // request.auth.handbook.review = true
    return auth
  }


  private function isMinistryStaff(userid){
    try {
      var checkForTag = model("Handbooktag").findOne(where="username IN (#getMinistryStaffAdmin()#) AND itemId= #arguments.userid# AND tag='ministrystaff'")
      if (isObject(checkForTag)) { return true }
      else { return false }
    } catch (any e) {
      return false
    }
  }

  private function setAuthCookies() {
    cfcookie (
      name="authemail"
      value="#session.auth.email#"
    )    
    cfcookie ( 
      name="authusername" 
      value="#session.auth.username#"
    )  
    cfcookie (
      name="authhandbookbasic" 
      value="#session.auth.handbook.basic#"
    )
  }  
  
}