<cfoutput query="posts">
<div id="eachpost" class="well">	
<p>
	#post#
</p>
Posted by #createdby# on #dateformat(createdat)# about #linkto(text=subject, action="show", key=id)#.	
</div>
</cfoutput>