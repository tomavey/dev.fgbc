<cfif gotrights("superadmin") and application.wheels.environment is "design">
	<div id="debug">
		<cfoutput><center>
			Username:#session.auth.username#
		</cfoutput>
		<cfif isdefined("session.reg")>Reg:<cfdump var="#session.reg#"></cfif>
		<cfif isdefined("session.cart")>Cart:<cfdump var="#session.cart#"></cfif>
		<cfif isdefined("session.return")>Return:<cfdump var="#session.return#"></cfif>
	</div>
</cfif>

</div id="wrapper">

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<cfoutput>
    #javaScriptIncludeTag("angular,focus/app,focus/controllers,focus/services,bootstrap,focus,ajaxdelete")#
</cfoutput>

</body>


</html>
