component extends="Controller" {

    private function init(){
        usesLayout("layout");
    }

    public function index2(){
        renderPage(layout="layout");
    }

    public function events(){
        events = model("Mainevent").findAll(where="begin > now()", order="begin,end");
    }

    public function index(){
        writeOutput("Hi");abort;
    }

    public function opportunities(){
        var loc = structNew();
		if (isdefined("params.key")) {
            loc.whereString = "id=#params.key#";
        }
        else if (gotrights("superadmin,office")) {
            loc.whereString = "";
        }
        else {
            loc.whereString = "expirationdate > now() AND approved='Y'";
        }
		opportunities = model("Mainjob").findAll(where=loc.whereString, order="id desc");
    }

    public function churches(){
        var loc = structNew();
		if (isdefined("params.state")) {
			churches = model("Handbookorganization").findAll(where="state='#params.state#' AND statusid in (1,8,4,2)", include="Handbookstate", order="state,org_city,name");
        }
		else {
			churches = model("Handbookorganization").findAll(where="statusid in (1,8,4,2)", include="Handbookstate", order="state,org_city,name");
        };
		churchStates = model("Handbookorganization").findAll(order="state", distinct=true, select="state", include="Handbookstate");
    }
}