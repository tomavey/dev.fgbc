<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset Table("handbookpositions")>
		<cfset belongsTo(name="Handbookperson", foreignKey="personid", joinType="outer")>
		<cfset belongsTo(name="Handbookorganization", foreignKey="organizationid", joinType="outer")>
		<cfset belongsTo(name="Handbookpositiontype", foreignKey="positiontypeid")>
        <cfset beforeUpdate("logUpdates,positionTypeRequired")>
        <cfset beforeSave("positionTypeRequired")>
        <cfset afterCreate("logCreates")>
        <cfset afterDelete("logDeletes")>

	</cffunction>

	<cffunction name="positionTypeRequired">
		<cfif !val(this.positiontypeid)>
			<cfset this.positiontypeid = 12>
		</cfif>
	</cffunction>

        <cffunction name="logUpdates">
        <cfargument name="modelName" default="Handbookposition">
        <cfargument name="createdBy" default="na">
        <cfif isDefined("session.auth.email")>
            <cfset arguments.createdBy = session.auth.email>
        </cfif>

            <cfset old = model("#arguments.modelName#").findByKey(key=this.id)>
            <cfset new = this>
            <cfset changes= new.changedProperties()>
            <cfoutput>
            <cfloop list="#changes#" index="i">
                <cfif not i is "updatedAt">
                    <cfset newupdate.modelName = arguments.modelName>
                    <cfset newupdate.recordId = this.id>
                    <cfset newupdate.columnName = i>
                    <cfset newupdate.datatype = "update">
                    <cfset newupdate.olddata = old[i]>
                    <cfset newupdate.newData = new[i]>
                    <cfset newupdate.createdBy = "#arguments.createdBy#">
                    <cfset update = model("Handbookupdate").create(newupdate)>
                </cfif>
            </cfloop>
            </cfoutput>
            <cfreturn true>
        </cffunction>

        <cffunction name="logCreates">
            <cfargument name="modelName" default="Handbookposition">
            <cfargument name="createdBy" default="#session.auth.email#">

            <cfset newSave.modelName = arguments.modelName>
            <cfset newSave.recordId = this.id>
            <cfset newSave.datatype = "new">
            <cfset newSave.createdBy = "#arguments.createdBy#">
            <cfset update = model("Handbookupdate").create(newSave)>

        <cfreturn true>

    </cffunction>

    <cffunction name="logDeletes">
        <cfset position = model("Handbookposition").findByKey(key=this.id)>
        <cfif isObject(position)>
              <cfset superLogDeletes('Handbookposition')>
        </cfif>
        <cfreturn true>
    </cffunction>

</cfcomponent>