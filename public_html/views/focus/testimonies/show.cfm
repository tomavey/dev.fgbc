<cfparam name="testimony" type="struct">

<!---cfdump var="#testimony#"><cfabort--->
<h3>Your story has been saved in a table and once approved will show up on the focus web page. <br/> Thanks so much for sharing your story!</h3>
<hr/>
<cfoutput>
<p>#testimony.name#</p>
<p>#testimony.email#</p>
<div class="well">
#testimony.testimony#
</div>
<p>Created: #dateformat(testimony.createdAt)#</p>
<p>Retreat: #testimony.retreat.regid#</p>
#linkto(text="Edit this testimony", action="edit", key=params.key)#
</cfoutput>
