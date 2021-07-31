component extends="Model" {

    public function config(){
        table('content_documents_tags')
        belongsTo(name="Documents", modelName="Fcdocument", foreignKey="docid")
      }

}