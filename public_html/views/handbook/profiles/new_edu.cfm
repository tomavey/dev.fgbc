<div id="profile">
<h1>Step #3: Education... </h1>
<div class="progress">
    <div class="bar"
    style="width: 50%;">Progress = 50%</div>
    </div>
<cfoutput>

			#errorMessagesFor("handbookprofile")#
	
			#startFormTag(action="update", key=params.key, params="next=pers")#
		
			#hiddenFieldTag(name="params.key", value=params.key)#

			#includePartial(partial="form2")#					

			#submitTag(name="submit", value="Save and go to personal experience")#
			#submitTag(name="submit", value="Save and exit")#
				
			#endFormTag()#
			

</cfoutput>
</div>