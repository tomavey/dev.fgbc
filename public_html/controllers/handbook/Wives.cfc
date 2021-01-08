component extends="controller" {

  function config(){
    usesLayout(template="/handbook/layout_handbook2")
  }
  
  public function index(){
    var onlyIfEmail = false
    var sortBy = "lname, spouse"
    var paramsString = ""
    if ( isDefined('params.sortBy') ) { sortBy = params.sortBy }
    if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
    pastorsWives = model("Handbookperson").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail, orderString=sortBy, params=paramsString)
  }

  public function show(){
    pastorsWife = model("Handbookperson").findByKey(key=params.key, include="state,handbookprofile")
  }

  public function findme(){
    if ( isDefined("params.key") ) {
      redirectTo("edit")
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
    pastorsWife = model("Handbookperson").findByKey(key=params.key, include="state,handbookprofile")
    pastorsWife.spouse_email = params.pastorsWife.spouse_email
    pastorsWife.phone4 = params.pastorsWife.phone4
    // ddd(pastorsWife.properties())
    if ( pastorsWife.save() ) {
      ddd(params)
    } else { 
      ddd("oops")
    }  

  }
  
}