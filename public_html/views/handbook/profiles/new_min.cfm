<div id="profile">
<h1>Step #2: Ministry... </h1>
<div class="progress">
    <div class="bar"
    style="width: 25%;">Progress = 25%</div>
</div>
<cfoutput>

			#errorMessagesFor("handbookprofile")#
	
			#startFormTag(action="update", key=params.key, params="next=edu")#
		
			#hiddenFieldTag(name="handbookprofile[id]", value=params.key)#

			#includePartial(partial="form3")#					

			#submitTag(name="submit", value="Save and go to education information")#
			#submitTag(name="submit", value="Save and exit")#
				
			#endFormTag()#
			

</cfoutput>
</div>