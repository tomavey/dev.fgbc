component extends="controller" {

  function config(){
    usesLayout(template="/handbook/layout_handbook2")
  }
  
  public function index(){
    var onlyIfEmail = false
    var sortBy = "lname, spouse"
    var search = ""
    if ( isDefined('params.sortBy') ) { sortBy = params.sortBy }
    if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
    if ( isDefined('params.search') ) { search = params.search }
    pastorsWives = model("Handbookperson").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail, orderString=sortBy, search=search)
    if ( isDefined('params.download') ) { 
      renderView(layout="/layout_download")
    }
  }

  public function show(){
    pastorsWife = model("Handbookperson").findByKey(key=params.key, include="state,handbookprofile")
  }

  public function findme(){
    if ( isDefined("params.key") ) {
      redirectTo(action="editMe", key=params.key)
    } else {
      var onlyIfEmail = false
      if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
      pastorsWives = model("Handbookperson").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail)
      pastorsWives.addColumn('wifeSelectName','string')
      pastorsWives = queryMap(pastorsWives,function(wife){
        wife.wifeSelectName = wife.lname & ', ' & wife.spouse
        return wife
      })
    }
  }

  public function editme(){
    pastorsWife = model("Handbookperson").findByKey(key=params.key, include="state,handbookprofile")
  }

  public function updateme(){
    var person = model("Handbookperson").findByKey(key=params.key, include="state")
    ddd(params)
    // pastorsWife.spouse_email = params.pastorsWife.spouse_email
    // pastorsWife.phone4 = params.pastorsWife.phone4
    // ddd(pastorsWife.properties())
    ddd(person.save(params.pastorsWife))
    if ( person.update(params.pastorsWife) ) {
      ddd(person.properties())
    } else { 
      ddd(params)
    }  
  }
  
}