<cfoutput>

   #hiddenField(objectName="home", property="type")#

   <cfif isDefined("home.requestedHomeId") && params.action != "edit">
    #hiddenField(objectName="home", property="requestedHomeId")#
    #hiddenFieldTag(name="home.approved", value="no")#
  <cfelse>

    <div class="homes homes-contactinfo">
      #select(
        objectName="home", 
        property="requestedHomeId", 
        options=hostHomes, 
        textField="selectNameId", 
        valueField="homeId", 
        includeBlank="---Select a host home id---"
        )#
        </div>

  </cfif>  

</cfoutput>
