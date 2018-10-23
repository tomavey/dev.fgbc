<cfoutput>

	#includePartial("/handbook/header")#
 <link href='https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons' rel="stylesheet">
 <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">

	<cfif !isMobile() && params.action NEQ "inspire">
	#includePartial("/handbook/banner")#
	</cfif>

<div class="row">	
	
	
	<div id="content" class="span12">
	    	<cfoutput>#contentForLayout()#</cfoutput>
	</div>
	
</div>
	
	#includePartial("/handbook/footer")#

</cfoutput>