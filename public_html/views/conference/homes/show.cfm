<style>
  .homes {
    border: 1px solid grey;
    padding:20px;
    margin: 20px;
    border-radius:10px;
    font-size:20px
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
</style>

<div class="container">
<cfoutput>

	<h1>Showing home</h1>

	#includePartial("showFlash")#

	<!--- <cfdump var="#home.properties()#"><cfabort> --->

	#includePartial("contactinfo")#

	#includePartial("availabilityinfo")#

	#includePartial("detailsinfo")#

  #includePartial("office")#
  
	<cfif gotRights("office")>
		#listTag()# #editTag(home.id)#
	</cfif>

</cfoutput>
</div>
