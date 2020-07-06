<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Igo Survey Results</title>
<style type="text/css">

body {
		font-family:Georgia, "Times New Roman", Times, serif;
	}
#survey {
	width:800px;
	margin-right:auto;
	margin-left:auto;
	border:1px solid gray;
	}
	
textarea {
	width:500px;
	height:100px;
	}	

tr {
	height:40px;
	}

td {
	padding:10px;
	}	
	
#agebrackets {
	background-color:#ffffcc;
	margin-bottom:20px;
	}	

td.ageoption {
	text-align:right;
	}	
	
#whopaid {
	background-color:#e6ffe6;
	}
	
#ratings {
	background-color:#fff2e6;
	}	
	
#howmany {
	background-color:#d8f2fa;
	}	

#comments {
	border:1px solid gray;
	margin:10px;
	}
	
#effect {
	background-color:#fddfef;
	}
tr.other {
	background-color:#f3f3f1;
	}	

#thankyou {
	text-align:center;
	margin:20px;
	}	
#question {
	text-transform:uppercase;
	}
	
h1 {
	text-align:center;
	}	
</style>	

</head>

<body>
<cfoutput>

<div id="survey">
<div id="header">
<cfinvoke component="survey" method="getsurveycount" returnvariable="count">
Response:
<ul>
<li>Number of surveys returned: #count#</li>
</ul>
</div>
<div id="agebrackets">
Age Brackets
<ul>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age0" returnvariable="summarydata">
Age 0-9: #summarydata.age0#
</li>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age10" returnvariable="summarydata">
Age 10-19: #summarydata.age10#
</li>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age20" returnvariable="summarydata">
Age 20-29: #summarydata.age20#
</li>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age30" returnvariable="summarydata">
Age 30-39: #summarydata.age30#
</li>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age40" returnvariable="summarydata">
Age 40-49: #summarydata.age40#
</li>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age50" returnvariable="summarydata">
Age 50-59: #summarydata.age50#
</li>
<li>
<cfinvoke component="survey" method="getthissummary" operator="sum" field="age60" returnvariable="summarydata">
Age 60 +: #summarydata.age60#
</li>
</ul>
</div>

<div id="whopaid">
Who paid your way and how much?
<ul>
<li>
<cfinvoke component="survey" method="getthisanswer" question="paid" answer="My employer paid all of my cost" returnvariable="thisanswercount">
Employer paid my way: #thisanswercount.answercount#
</li>
<li>
<cfinvoke component="survey" method="getthisanswer" question="paid" answer="My employer paid all of my and my spouse's cost" returnvariable="thisanswercount">
Employer paid me and my spouse: #thisanswercount.answercount#
</li>
<li>
<cfinvoke component="survey" method="getthisanswer" question="paid" answer="My employer paid all my family's cost" returnvariable="thisanswercount">
Employer paid me and my family: #thisanswercount.answercount#
</li>
<li>
<cfinvoke component="survey" method="getthisanswer" question="paid" answer="We paid the total cost ourselves" returnvariable="thisanswercount">
Self pay: #thisanswercount.answercount#
</li>
<li>
<cfinvoke component="survey" method="getcost"returnvariable="cost">
Cost: <cfloop query="cost">#cost#, </cfloop>
</li>
</ul>
</div>

<div id="howmany">
Attendance:
<ul>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="celebrations" returnvariable="summarydata">
How many celebrations did you attend (avg): #decimalformat(summarydata.celebrations)#
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="sponsoredluncheons" returnvariable="summarydata">
How many sponsored meals did you attend (avg): #decimalformat(summarydata.sponsoredluncheons)#
</li>
</ul>
</div>
<div id="ratings">
Ratings:
<ul>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="theme" returnvariable="summarydata">
Conference Theme (avg): #decimalformat(summarydata.theme)# [<a href="?question=theme##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="location" returnvariable="summarydata">
Location (avg): #decimalformat(summarydata.location)# [<a href="?question=location##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="speakers" returnvariable="summarydata">
Speakers (avg): #decimalformat(summarydata.speakers)# [<a href="?question=speakers##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="music" returnvariable="summarydata">
Music (avg): #decimalformat(summarydata.music)# [<a href="?question=music##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="schedule" returnvariable="summarydata">
Schedule (avg): #decimalformat(summarydata.schedule)# [<a href="?question=schedule##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="luncheons" returnvariable="summarydata">
Meals (avg): #decimalformat(summarydata.luncheons)# [<a href="?question=luncheons##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="buddhist" returnvariable="summarydata">
Buddhist Temple Trip (avg): #decimalformat(summarydata.buddhist)# [<a href="?question=buddhist##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="hindu" returnvariable="summarydata">
Hindu Temple Trip (avg): #decimalformat(summarydata.hindu)# [<a href="?question=hindu##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="baseball" returnvariable="summarydata">
Baseball Trip (avg): #decimalformat(summarydata.baseball)# [<a href="?question=baseball##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="childcare" returnvariable="summarydata">
Childcare (avg): #decimalformat(summarydata.childcare)#  [<a href="?question=childcare##comments">view comments</a>]
</li>
<li><cfinvoke component="survey" method="getthissummary" operator="avg" field="kidskonf" returnvariable="summarydata">
Kids Konference (avg): #decimalformat(summarydata.kidskonf)# [<a href="?question=kidskonf##comments">view comments</a>]
</li>
</ul>
</div>
</cfoutput>
<div id="effect">
<cfoutput>
Effect of Igo
<ul>
	<li>
	Where you able to share the gospel? <ul>
		<cfinvoke component="survey" method="getthisanswer" question="gospel" answer="Yes" returnvariable="thisanswercount">
		<li>Yes: #thisanswercount.answercount#</li>
		<cfinvoke component="survey" method="getthisanswer" question="gospel" answer="No" returnvariable="thisanswercount">
		<li>No: #thisanswercount.answercount#</li>
		</ul>
	</li>
	<li>
	Where you able to have a spiritual conversation? <ul>
		<cfinvoke component="survey" method="getthisanswer" question="spiritual" answer="Yes" returnvariable="thisanswercount">
		<li>Yes: #thisanswercount.answercount#</li>
		<cfinvoke component="survey" method="getthisanswer" question="spiritual" answer="No" returnvariable="thisanswercount">
		<li>No: #thisanswercount.answercount#</li>
		</ul>
	<li>
	Where you able to apply principles? [<a href="?question=apply##comments">view comments</a>]<ul>
		<cfinvoke component="survey" method="getthisanswer" question="apply" answer="Yes" returnvariable="thisanswercount">
		<li>Yes: #thisanswercount.answercount#</li>
		<cfinvoke component="survey" method="getthisanswer" question="apply" answer="No" returnvariable="thisanswercount">
		<li>No: #thisanswercount.answercount#</li>
		</ul>
	</li>
	<li>General Suggestions: [<a href="?question=suggestions##comments">view suggestions</a>]</li>
</ul>
</cfoutput>
</div>
<cfif isdefined("url.question")>
<div id="comments">
<cfoutput>Comments about <span id="question">#url.question#</span>:</cfoutput>
<cfinvoke component="survey" method="getthiscomments" question="#url.question#" returnvariable="thiscomments">
<ul>
<cfoutput query="thiscomments">
<cfif thiscomments.comments is not "">
<li>#thiscomments.comments#</li>
</cfif>
</cfoutput>
</ul>
</div>
</cfif>
</div>
</body>
</html>
