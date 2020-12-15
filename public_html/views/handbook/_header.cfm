<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="description" content="Charis Fellowship is a voluntary association of more than 260 churches in the United States and Canada. Charis Fellowship is committed to Biblical Truth, Relationship and Mission. They plant churches, training leaders and do good for the sake of the gospel.">
	<meta http-equiv="Content-language" content="en-US">
	<meta name="copyright" content="2005 Charis Fellowship.us. All rights reserved.">
	<meta name="distribution" content="global">
	<meta name="classification" content="Church, Non Profit Organizations, Non for Profit, Missions, Community Service">
	<meta name="rating" content="General">
	<meta name="resource-type" content="document">
	<meta name="revisit-after" content="15 days">
	<meta name="organization" content="Charis Fellowship">
	<meta name="ROBOTS" content="ALL">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">	
  
	<!-- Favicon -->
	<link rel="shortcut icon" href="/assets/img/favicon2.ico">

	<title>Charis Fellowship Handbook</title>
	
	
	<cfoutput>
		#styleSheetLinkTag("
			bootstrap,
			bootstrap-responsive.min,
			handbook,
			../javascripts/jquery-ui/jquery-ui.min,
			../javascripts/jquery-ui/jquery-ui.structure.min,
			../javascripts/jquery-ui/jquery-ui.theme.min,
			/assets/vendor/icon-awesome/css/font-awesome.min
			")#    
	  <!---Load Vue Early--->
		<cfset folder = "/assets/js">
			#javaScriptIncludeTag("
				#folder#/vue,
				#folder#/axios.min
				")#
	</cfoutput>

</head>

<body>    
