		</div>
	</div>
<cfif NOT application.wheels.environment is "production">
<cfoutput>
#includePartial("/_shared/debugfooter")#
</cfoutput>

</cfif>
<cfoutput>
#forcecfcatch()#
</cfoutput>
	<cfoutput>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		#javaScriptIncludeTag("bootstrap,jquery_ujs,handbook,jquery-ui/jquery-ui.min,ajaxdelete")#
	</cfoutput>

</body>
</html>

