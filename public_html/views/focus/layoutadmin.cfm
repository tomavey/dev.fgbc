<cfinclude template="_header.cfm">
<cfinclude template="_navigationadmin.cfm">
<div id="page">
	<!-- start content -->
		<div class="post">
                <div class="entry">
                    <cfoutput>#includeContent()#</cfoutput>
                </div>
		</div>
	</div>
	<!-- end content -->
	<div style="clear: both;">&nbsp;</div>
</div>
<cfinclude template="_footer.cfm">