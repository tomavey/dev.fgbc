<cfset spread = model("Conferencesurvey").getspread(question=params.question,event=params.event)>
<cfset total = 0>
<div id="survey">
<table>
<cfoutput>
#spread.recordcount# responses for "#params.question#":
</cfoutput>
<cfoutput query="spread">
<cfset total = total + evaluate(params.question)>
<tr>
<td width="200">#evaluate(params.question)#</td>
<td style="font-size:.7em">#linkTo(text="See Survey", controller="conference.surveys", action="all", params="event=#params.event#&id=#id#")#</td>
</tr>
</cfoutput>
</table>
<cfoutput>
<p>Average = #total/spread.recordcount#</p>
</cfoutput>
</div>
