<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<cfoutput>
		#styleSheetLinkTag("bootstrap,forums")#    
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
</cfoutput>
</head>
<body>
	<cfoutput>
		#includePartial(partial="/forums/navbar")#
	</cfoutput>
	<div class="container">
		<cfoutput>#contentForLayout()#</cfoutput>
	</div>	
</body>

<cfoutput>		
	#javaScriptIncludeTag("forums,bootstrap")#
</cfoutput>

</head>
