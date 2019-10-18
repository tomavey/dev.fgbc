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

  function isMinistryStaff(userid){
    try {
      var checkForTag = model("Handbooktag").findOne(where="username IN (#getMinistryStaffAdmin()#) AND itemId= #arguments.userid# AND tag='ministrystaff'")
      if (isObject(checkForTag)) { return true }
      else { return false }
    } catch (any e) {
      return false
    }

  }
  
}