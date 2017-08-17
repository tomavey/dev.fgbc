<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<cfif isDefined("params.doc")>
        <cfheader name="Content-disposition" value="inline;filename=download.doc">
        <cfcontent type="application/msword">
</cfif>

<head>
<cfoutput>
		#styleSheetLinkTag("bootstrap,forums")#    
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
</cfoutput>
</head>
<body>

	<div class="container">
		<p id="ajaxform">
		</p>	

		<cfoutput>#contentForLayout()#</cfoutput>
	<div>
<cfif isDefined("session.membershipapplication.language")>	
<cfoutput><span style="font:.8em gray">Language = #session.membershipapplication.language#</span></cfoutput>
</cfif>	
</div>
	</div>	
	
<!---<cfdump var="#session.membershipapplication#">
--->
</body>

<cfoutput>		
	#javaScriptIncludeTag("forums,bootstrap")#
</cfoutput>


