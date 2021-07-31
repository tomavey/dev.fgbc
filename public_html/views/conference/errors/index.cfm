<cfparam name="errors" type="query">
<div>
	<cfoutput query="errors">
			Error status recorded on: #dateformat(createdAt,"yy-mm-dd")# #timeFormat(createdAt,"HH:mm")#
			<p>Session: </p>
			#replace(errors.session,",",",<br/>","all")#
			<p>Url:</p> 
			#replace(errors.url,",",",<br/>","all")#
			<p>Form:</p> 
			#replace(errors.form,",",",<br/>","all")#
			<p>CGI: </p>
			#replace(errors.cgi,",",",<br/>","all")#
			<hr/><p>&nbsp;</p>
	</cfoutput>
</div>