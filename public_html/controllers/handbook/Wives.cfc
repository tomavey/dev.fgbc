component extends="controller" {

  function config(){
    usesLayout(template="/handbook/layout_handbook2")
  }
  
  public function index(){
    var onlyIfEmail = false
    if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
    pastorsWives = model("Handbookperson").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail)
  }

  public function show(){
    pastorsWife = model("Handbookperson").findByKey(key=params.key, include="state,handbookprofile")
  }
  
}