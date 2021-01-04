<cfoutput>
<p>Job posting</p>
<p>A job has been posted #linkto(controller="admin.jobs", action="approve", key=params.key, onlypath=false, params="unlock=jobs&id=#job.uuid#")#</p>
<p>#description#</p>
<p>#linkto(Text="Edit This Job", controller="admin.jobs", action="edit", key=params.key, onlypath=false, params="unlock=jobs&id=#job.uuid#")#</p>
</cfoutput>