component extends="Model" {

    public function init(){
        table('content_documents_tags')
        belongsTo(name="Documents", modelName="Fcdocument", foreignKey="docid")
      }

}