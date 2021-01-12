component extends="controller" {

  function config(){
    usesLayout(template="/handbook/layout_handbook2")
    filters(through="setReturn", only="index,show")
  }
  
  public function index(){
    var onlyIfEmail = false
    var sortBy = "lname, spouse"
    var search = ""
    if ( isDefined('params.sortBy') ) { sortBy = params.sortBy }
    if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
    if ( isDefined('params.search') ) { search = params.search }
    pastorsWives = model("Handbookpastorswives").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail, orderString=sortBy, search=search)
    if ( isDefined('params.download') ) { 
      renderView(layout="/layout_download")
    }
  }

  public function show(){
    pastorsWife = model("Handbookpastorswives").findByKey(key=params.key, include="state,profile")
  }

  public function findme(){
    if ( isDefined("params.key") ) {
      redirectTo(action="editMe", key=params.key)
    } else {
      var onlyIfEmail = false
      if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
      pastorsWives = model("Handbookpastorswives").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail)
      pastorsWives.addColumn('wifeSelectName','string')
      pastorsWives = queryMap(pastorsWives,function(wife){
        wife.wifeSelectName = wife.lname & ', ' & wife.spouse
        return wife
      })
    }
  }

  public function editme(){
    person = model("Handbookpastorswives").findOne(where="id=#params.key#", include="state,profile")
  }

  public function updateme(){
    var person = model("Handbookpastorswives").findOne(where="id=#params.key#", include="state", reload=true)
    writeOutput("Before Params: ") 
    writeDump(person.properties().spouse_email)
    person.spouse_email = params.person.spouse_email
    person.phone4 = params.person.phone4
    writeOutput("Before Save: ") 
    writeDump(person.properties().spouse_email)
    ddd(pastorsWife.properties())
    if ( person.update() ) {
      writeOutput("After Save: ") 
      ddd(personcheck.properties().spouse_email)
      flashInsert(success="Information was updated successfully");
      returnBack()
    } else { 
      flashInsert(error="There was an error updating the information.");
      returnBack();    
    }  
  }
  
}