<cfset thisquestion = #url.question# & "comments">

<cfif url.question is "suggestions" or url.question is "leadership" or url.question is "churchplanting" or url.question is "integrated">
<cfset thisquestion = #url.question#>
</cfif>

<cfset comments = getComments(thisquestion)>
<div id="survey">
<cfoutput query="comments">
<cfif evaluate(thisquestion) is not "">
<div class="eachcomment" style="border:1px solid gray;margin:5px;padding:3px">

#evaluate(thisquestion)#<br>

<p style="text-align:right">#linkTo(text="Read complete survey", controller="conference.surveys", action="all", params="id=#id#&event=#params.event#")#
</p>
</div>
</cfif>
</cfoutput>
</div>
