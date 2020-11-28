<cfoutput>
	
<!------------NEWS---------------
---------------------------------------------------->
<div data-role="page" id="news">

	<div data-role="header">
		#includePartial(partial="/mobile/header")#
	</div><!-- /header -->


	<div data-role="content">
		#includePartial(partial="/home/twitterfeed")#
	</div><!-- /content -->


	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<cfset uiBtnActive = "news">
			#includePartial(partial="/mobile/navbar", uiBtnActive = "news")#
		</div><!-- /navbar -->
	</div><!-- /footer -->

</div><!-- /page -->


</cfoutput>