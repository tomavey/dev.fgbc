component extends="Controller" output="false" {
	dsn = "fgbc_main_3";

	public function init() {
		usesLayout("/conference/adminlayout");
		filters(through="officeOnly", except="backupall");
	}

	public function list() {
		alltables = Model("Conferencebackup").getTables();
	}

	public function xbackup() {
		var results = structNew();
		results = backupTable(params.key);
		if ( isdefined("results.message") ) {
			writeDump( var=results );
			abort;
		} else {
			redirectTo(controller="conference.backups", action="list");
		}
	}

	public function backupall() {
		var loc = {}
		loc.alltables = model("Conferencebackup").getTables();
		for ( loc.table in loc.alltables ) {
			model("Conferencebackup").backupTable(loc.table.Tables_in_fgbc_main_3)
		}
		redirectTo(controller="conference.backups", action="list");
	}

	public function backup(string tablename) {
		var loc = structNew();
		if ( isDefined("arguments.tablename") ) {
			loc.table = arguments.tablename;
		} else {
			loc.table = params.key;
		}
		loc.newtable = model("Conferencebackup").backupTable(loc.table);
		redirectTo(controller="conference.backups", action="list");
	}

	public function getLastBackup(required table) {
		try {
			lastBackup = model("Conferencebackup").findAll(where="name='#arguments.table#'", order="ID DESC");
		} catch (any cfcatch) {
			lastBackup.records="NA";
			lastBackup.createdAt="NA";
		}
		return lastBackup;
	}

	public function dump() {
		// Get Column Info from Selected Table
		cfquery( name="columns", datasource=dsn ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("SHOW columns
				FROM #params.key#");
		}
		cfquery( name="data", datasource=dsn ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("SELECT *
				FROM #params.key#");
		}
	}

	public function testGetLastBackup() {
		test = getLastBackup("equip_prayer_triplets");
		writeDump( var=test );
		abort;
	}

	public function fieldSQL(required string fieldName, required fieldData) {
		var sqltxt = "";
		var data = "";
		var columns = "";
		var columnInfo = "";
		cfquery( name="columns", datasource=dsn ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("SHOW columns
				FROM #params.key#");
		}
		cfquery( dbtype="query", name="columninfo" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("SELECT * FROM columns
				WHERE upper(field) = '#ucase(arguments.fieldname)#'");
		}
		if ( columnInfo.type contains "int" ) {
			sqltxt = arguments.fieldData & ", ";
		} else if ( columnInfo.type contains "decimal" ) {
			sqltxt = arguments.fieldData & ", ";
		} else if ( columnInfo.type contains "text" ) {
			sqltxt = "'" & arguments.fieldData & "'', ";
		} else if ( columnInfo.type contains "char" ) {
			sqltxt = "'" & arguments.fieldData & "'', ";
		}
		return sqltxt;
	}

}
