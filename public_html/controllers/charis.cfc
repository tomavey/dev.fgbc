component extends="Controller" {

    private function init(){
        usesLayout("layout");
    }

    public function index2(){
        renderPage(layout="layout");
    }

}