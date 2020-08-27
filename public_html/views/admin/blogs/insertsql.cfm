<cfoutput query="blogs">
	<div>
INSERT INTO 'fgbc_blogs'<br/>
(
#lcase(fieldslist)#
)
<br/>
VALUES<br/>
(
<cfloop list="#columnlist#" index="i">
	#evaluate(i)#
	<cfif listLast(columnlist) is not i>
		,
	</cfif>
</cfloop>
)
<cfif currentRow is not recordcount>
	<br/>;
</cfif>	
</div>
</cfoutput>