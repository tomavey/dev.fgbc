<cfoutput>
<p>Job posting</p>
<p>A job has been posted #linkto(controller="jobs", action="approve", key=params.key, onlypath=false, params="unlock=jobs")#</p>
<p>#description#</p>
<p>#linkto(controller="jobs", action="delete", key=params.key, onlypath=false, params="unlock=jobs")#</p>
</cfoutput>