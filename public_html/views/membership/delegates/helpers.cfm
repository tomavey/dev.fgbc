<cfscript>

  function fixEmailList(list) {
    var newList = ""
    newList = replace(list,"; ", "", "one")
    newList = replace(newList,"; ;",";","all")
    return newList
  }

  function validateEmailList (list) {
    
  }
  
</cfscript>