<cfoutput>
<div class="row-fluid well contentStart contentBg">
    <div class="span3">
        #includePartial(partial="sidebar", selected="home")#
    </div>

    <div class="span9">
	
							<h1>#content.name#</h1>
					
							#content.content#
					
	
	</div>
</div>
</cfoutput>