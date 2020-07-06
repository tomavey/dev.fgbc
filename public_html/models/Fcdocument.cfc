component extends="Model" {

    public function init(){
        table('content_documents')
        hasMany(name="tags", modelName="Fcdocumentstag", foreignKey="docid")
    }

    public function findAllThatExist(whereString, includeString){
        var records = findAll(where = '#whereString#', include="#includeString#")
        records = queryFilter( records, filterDocs )
        return records
    }

    private function filterDocs(el){
        return fileExists(Expandpath("/fc/documents/" & el.filename))
    }

}