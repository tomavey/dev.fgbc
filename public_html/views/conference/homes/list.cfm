<style>
  .homes {
    border: 1px solid grey;
    padding:20px;
    margin: 20px;
    border-radius:10px;
    font-size:20px;
    font-weight: bold
  }
  .homes-section {
    border: 1px solid black;
    width: 300px;
    padding: 5px;
    margin-top: -30px;
    background-color: white;
    font-size: 110%;
    font-weight: bold;
    border-radius: 5px
  }
  .homes span {
    padding-right:10px;
    width:50%;
    font-style: italic;
    font-weight: normal
  }
  .homes-question {
    margin-bottom:40px
  }
  .homes-multi {
    margin-left: 30px
  }
  .homes label {
    font-size:105%
  }
  .homes-multi label input {
    margin-left:10px
  }
  .homes-input-wide {
    width: 90%
  }
  .homes-input-half {
    width: 50%
  }
  .homes-input-short {
    width: 100px
  }
  .homes-status {
    float:right;
    font-size: 1.3em
  }
</style>

<cfparam name="instructions" default="AccessHostRequestInstructions">
<cfparam name="instructionsId" default=0>

<div class="container" style="background-color:white;padding:20px;border-radius:10px">
<cfoutput>

    <cfif gotRights("office")>
      <p class="pull-right">
        #linkto(text="<i class='fa fa-pencil-square'></i>", controller="admin.contents", action="edit", key=instructionsId)#
      </p>
    </cfif>
  
    <p>#instructions#</p>
  
  
  <!--- <cfdump var="#homes#"><cfabort> --->
  
  <cfscript>
    for ( home in homes ) {
        writeOutput(includePartial("list"))
    }
  </cfscript>
    
  

</cfoutput>
</div>
