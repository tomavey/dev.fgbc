component extends="Controller" output="false" {

    public function hello(){
        writeDump("hello");abort;
    }

    public function index(){
        var whereString = "originalId=0";
        if (isDefined('params.key')) {
            if (val(params.key)) {
                whereString = whereString & " AND id = #params.key#";     
            }
            else {
                whereString = whereString & " AND name = '#params.key#'"; 
            }
        };
        if (isDefined('params.q')){
            whereString = whereString & " AND paragraph LIKE '%#params.q#%'";
        }
        content = model("Fccontent").findAll(where=whereString);
        data=queryToJson(content);
        renderView(layout="/layout_json", template="/json.cfm", hideDebugInformation="true");
    }

}