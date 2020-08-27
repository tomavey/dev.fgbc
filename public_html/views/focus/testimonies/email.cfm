<cfoutput>
<p>Focus Story</p>
<p>A focus story has been posted #linkto(controller="testimonies", action="show", key=testimony.id, onlypath=false)#</p>
<p>#testimony.testimony#</p>
<p>#linkto(text="APPROVE", controller="focus.testimonies", action="approve", key=testimony.id, onlypath=false, params="code=charis")#</p>
<p>#linkto(text="DELETE", controller="focus.testimonies", action="delete", key=testimony.id, onlypath=false, params="code=charis")#</p>
</cfoutput>