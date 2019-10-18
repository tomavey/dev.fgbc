component extends="model" {

function unLockCode(params){
  session.session.auth.passedString = 'isdefined("params.unlockcode")'
  var thisemail = decrypt(params.unlockcode,application.wheels.passwordkey,"CFMX_COMPAT","HEX")
  var person = model("Handbookperson").findOne(where="email = '#thisemail#' OR email2='#thisemail#' OR spouse_email='#thisemail#'", include="Handbookstate")
  if (isobject(person)) {
    session.auth.email = thisemail
    session.auth.username = thisemail
    session.auth.handbook.basic = true
  }
  if ( isMinistryStaff(person.id) ) {
    session.auth.rightslist = "handbook,ministrystaff"
  } else {
    session.auth.rightslist = "handbook"
  }
}

function isAlreadyAuthorized(required params){
  session.auth.passedString = 'isDefined("session.auth.handbook.basic") and session.auth.handbook.basic'
}

function isAlreadyLoggedInToMainSiteWithHandbookRights(params) {  
  session.auth.passedString = 'structKeyExists(session.auth,"rightslist") and NOT isdefined("params.logoutfirst") and NOT isDefined("params.reviewer") and NOT isDefined("params.handbookUpdate")'
  var handbookRightsRequiredArray = listToArray(getSetting('handbookRightsRequired'))
  for ( var item in handbookRightsRequiredArray ) {
    if ( listfind(session.auth.rightslist,item) ) {
      session.auth.handbook.basic = true
      if ( getSetting('allowHandbookAuthByCookie') ) {
        setAuthCookies()
      }
    }
  }
}

function cookiesSet() {
  session.auth.passedString = 'isDefined("cookie.authhandbookbasic") AND cookie.authhandbookbasic'
  session.auth.email = cookie.authemail
  session.auth.rightslist = "basic"
  session.auth.handbook.basic = true
}

function reviewer(required params){
  session.auth.passedString = 'isDefined("params.reviewer") and len(params.reviewer) and isDefined("params.orgid") and val(params.orgid) and allowHandbookOrgUpdate()'
  session.auth.email = params.reviewer
  session.auth.username = params.reviewer
  session.auth.rightslist = "basic"
  session.auth.handbook.basic = true
  session.auth.handbook.review = true
  request.auth.handbook.review = true
}


function isMinistryStaff(userid){
  try {
    var checkForTag = model("Handbooktag").findOne(where="username IN (#getMinistryStaffAdmin()#) AND itemId= #arguments.userid# AND tag='ministrystaff'")
    if (isObject(checkForTag)) { return true }
    else { return false }
  } catch (any e) {
    return false
  }
 }

function setAuthCookies() {
  cfcookie (
    name="authemail"
    expires="never"
    value="#session.auth.email#"
  )    
  cfcookie ( 
    name="authusername" 
    expires="never" 
    value="#session.auth.username#"
  )  
  cfcookie (
    name="authhandbookbasic" 
    expires="never" 
    value="#session.auth.handbook.basic#"
  )
}  
  
}