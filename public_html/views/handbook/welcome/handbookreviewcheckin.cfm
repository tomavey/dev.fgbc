<div class="well span11" style="text-align:center">
<cfset params.key = simpleEncode(params.key)>

<cfoutput>
	#startFormTag(route="reviewhandbook", orgid=params.key)#
	#hiddenFieldTag(name="key", value=#params.key#)#
	#putFormTag()#		
	#textFieldTag(name="reviewer", label="Please start by entering your email address here: ")#
	#submitTag("Submit")#
	#endFormTag()#
</cfoutput>
</div>