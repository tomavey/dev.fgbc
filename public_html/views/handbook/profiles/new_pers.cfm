<div id="profile">
<h1>Step #4: Personal interests... </h1>
<div class="progress">
    <div class="bar"
    style="width: 75%;">Progress = 75%</div>
    </div>

<cfoutput>

			#errorMessagesFor("handbookprofile")#
	
			#startFormTag(action="update", key=params.key)#
		
			#hiddenFieldTag(name="params.key", value=params.key)#

			#includePartial("form4")#					

			#submitTag(name="submit", value="Save and exit")#
				
			#endFormTag()#
			

</cfoutput>
</div>