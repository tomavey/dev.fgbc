<cfparam name="title" default="Welcome">
<div id="welcome" class="row">
	<!-- start content -->
		<div class="well">
                <div class="title">
                    <h1><cfoutput>#title#</cfoutput></h1>
                </div>
                <div class="entry">
                    <cfoutput>#includeContent()#</cfoutput>
                </div>
		</div>
	</div>
	<!-- end content -->
	<div style="clear: both;">&nbsp;</div>
</div>
