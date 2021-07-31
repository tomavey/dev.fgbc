component extends="Model" output="false" {

  function config(){
    table('handbookpeople')
    belongsTo(name="State", modelName="Handbookstate", foreignkey="stateid")
    hasMany(name="Positions", modelName="Handbookposition", foreignKey="personid", dependent="delete", joinType="outer")
    hasOne(name="Profile", modelName="Handbookprofile", foreignKey="personid", dependent="delete")
    property(
      name="state_mail_abbrev",
      sql="SELECT state_mail_abbrev FROM handbookstates where handbookstates.id = handbookpeople.stateid"
    )
    property(
      name="selectName",
      sql="CONCAT_WS(', ',lname,fname,city,state_mail_abbrev)"
    )
  }

  function findPastorsWives(
    string titleIncludesList = 'pastor,chaplain', 
    string onlyIfEmail = false, 
    string orderString = "lname, spouse",
    string search = ""
    ){
    var titleIncludes = $buildMysqlLikeString(titleIncludesList)
    var selectString = "handbookpeople.id, spouse, lname, spouse_email, phone4, handbookpeople.address1, handbookpeople.address2, city, state_mail_abbrev, handbookpeople.zip, position AS hisPosition, (CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name)) AS churchNameCity"
    var whereString = "deletedAt IS NULL AND fnameGender <> 'F' AND spouse IS NOT NULL AND length(spouse) AND (#titleIncludes#)"
    if ( onlyIfEmail ) {
      whereString = whereString & " AND spouse_email IS NOT NULL"
    }
    if ( len(search) ) {
      whereString = whereString & " AND (spouse like '%#search#%' OR lname like '%#search#%')"
    }
    var includeString = "State,Positions(Handbookorganization)"
    var maxRows = -1
    var pastorsWives = model("Handbookpastorswives").findAll(
      select = selectString,
      where = whereString,
      maxRows = maxRows,
      include = includeString,
      order = orderString,
      group="id"
    )
    return pastorsWives
  }

}