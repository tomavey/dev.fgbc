<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>Untitled</title>
<link href="/survey/style.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/Scripts/jquery.js"></script>
<script type="text/javascript" src="/Scripts/jquery.wysiwyg.js"></script>
<script type="text/javascript">
$(document).ready(function(){
$('a#otherconferences2').click(function(){
$('#otherconferenceinfo').load('survey_results_otherconferenceinfo.cfm');
return false;
});
$('a#showcomments').click(function(){
$('#commentinfo').load('survey_results_comments.cfm');
return false;
});
});
</script>


	<cfif isdefined("url.searchvalue") and url.searchvalue is "400">
		<cfset url.searchvalue = "400+">
	</cfif>	
	<cfif isdefined("url.searchvalue") and url.searchvalue is "65">
		<cfset url.searchvalue = "65+">
	</cfif>	

<cffunction name="getpercent">
	<cfargument name="field" required="yes">
	<cfargument name="answer" required="yes">
	<cfset var results="">
	<cfset var totalcount="">
	<cfset var percent="">
	
	<cfquery datasource="#dsn#" name="totalcount">
		SELECT count(#field#) as totalcount
		FROM cel_survey_10
		WHERE 0=0
		<cfif isdefined("url.searchfield") and isdefined("url.searchvalue")>
			<cfif url.searchfield is "attender">
		AND (palmsprings06 = "on" or innisbrook08 = "on")
			<cfelse>
		AND #url.searchfield# = '#url.searchvalue#'
			</cfif>
		</cfif>
	</cfquery>	

	<cfquery datasource="#dsn#" name="results" result="x">
		SELECT count(#field#) as total
		FROM cel_survey_10
		WHERE #field# = '#answer#' 
		<cfif isdefined("url.searchfield")>
			<cfif url.searchfield is "attender">
		AND (palmsprings06 = "on" or innisbrook08 = "on")
			<cfelse>
		AND #url.searchfield# = '#url.searchvalue#'
			</cfif>
		</cfif>
	</cfquery>	
	<cfif results.total is 0>
	<cfset percent = 0>
	<cfelse>	
	<cfset percent = results.total/totalcount.totalcount*100>
	</cfif>
	<cfset percenttext = numberformat(percent,'99.9')>
	<cfreturn percenttext>

</cffunction>

<cffunction name="getcount">
	<cfquery datasource="#dsn#" name="totalcount">
		SELECT count(*) as totalcount
		FROM cel_survey_10
		WHERE 0 = 0 
		<cfif isdefined("url.searchfield")>
			<cfif url.searchfield is "attender">
		AND (palmsprings06 = "on" or innisbrook08 = "on")
			<cfelse>
		AND #url.searchfield# = '#url.searchvalue#'
			</cfif>
		</cfif>
	</cfquery>	
<cfreturn totalcount.totalcount>
</cffunction>

<cffunction name="getlist">
<cfargument name="field" required="yes"> 
<cfset var responses = "">
<cfset var list="">
	<cfquery datasource="#dsn#" name="list">
		select #field# as conference
		from cel_survey_10
	</cfquery>
	<cfset responses = "">
	<cfloop query="list">
	<cfif conference is not "">
	<cfset responses = responses & "," & conference>
	</cfif>
	</cfloop>
	<cfset responses = replace(responses,",","","1")>
<cfreturn responses>
</cffunction>

<cffunction name="getpeople">
	<cfquery datasource="#dsn#" name="people">
		SELECT s.fname, s.lname, s.email, t.stateabbrev
		FROM staff s, cel_survey_10 c, state t
		WHERE c.userid = s.staffid
		AND s.stateid = t.stateid
		AND c.westcoast = 'lessLikely'
		order by t.stateabbrev, s.lname, s.fname		
	</cfquery>
<cfreturn people>
</cffunction>	

<cffunction name="graph">
<cfargument name="fieldname" required="yes">
<div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</cffunction>				

</head>

<body>
<div id="survey_div">
<table>
<cfoutput>
<tbody id="personaldata2">
<tr>
<td colspan="2" style="font-size:1.3em;text-align:center;font-weight:bold">
<cfif isdefined("url.searchfield")>
<cfswitch expression="#url.searchfield#">
<cfcase value="churchsize">
Results for Church Size = #url.searchvalue#<br>
<span style="font-size:.7em;font-weight:normal">Number of surveys = #getcount()#</span>
<p style="text-align:right;font-size:.7em;font-weight:normal"><a href="survey_results_cel10.cfm">Show All</a></p>
</cfcase>
<cfcase value="age">
Results for age range = #url.searchvalue#<br>
<span style="font-size:.7em;font-weight:normal">Number of surveys = #getcount()#</span>
<p style="text-align:right;font-size:.7em;font-weight:normal"><a href="survey_results_cel10.cfm">Show All</a></p>
</cfcase>
<cfcase value="Position">
Results for position = #url.searchvalue#<br>
<span style="font-size:.7em;font-weight:normal">Number of surveys = #getcount()#</span>
<p style="text-align:right;font-size:.7em;font-weight:normal"><a href="survey_results_cel10.cfm">Show All</a></p>
</cfcase>
<cfcase value="westcoast">
Results for West Coast Answer = #url.searchvalue#<br>
<span style="font-size:.7em;font-weight:normal">Number of surveys = #getcount()#</span>
<p style="text-align:right;font-size:.7em;font-weight:normal"><a href="survey_results_cel10.cfm">Show All</a></p>
</cfcase>
<cfcase value="attender">
Results for People who came to either Innisbrook08 or Palmspings06<br>
<span style="font-size:.7em;font-weight:normal">Number of surveys = #getcount()#</span>
<p style="text-align:right;font-size:.7em;font-weight:normal"><a href="survey_results_cel10.cfm">Show All</a></p>
</cfcase>

</cfswitch>
<cfelse>
Results for ALL categories.<br>
<p style="font-size:.7em;font-weight:normal">Count = #getcount()#</p>
</cfif>
</td>
</tr>
<tr>
<td colspan="2" style="background-color:white"><center>Use the links in the yellow section of this report to view only results for each catagory.<br>For example, to see how 19-34 year-olds responded, click the "19-34" link in the "Age Group" row.</center>
</td>
</tr>
<tr class="personaldata">
	<td class="label">
	Position:
	</td>
	<td id="personaldatachoices">
	<cfset options = "Solo Pastor,Lead Pastor,Staff Pastor,Church Staff,Missionary,Other">
	<table>
	<tr>
		<cfloop list="#options#" index="i">
			<td class="choice"><a href="?searchfield=position&searchvalue=#replace(i,' ','')#">#i#</a></td>
		</cfloop>
	</tr>
	</table>	
	</td>
</tr>
<tr class="personaldata">
	<td class="label">
	Age Group:
	</td>
	<td id="personaldatachoices">
	<cfset options = "19-34,35-50,51-64,65+">
	<table>
	<tr>
		<cfloop list="#options#" index="i">
			<td class="choice"><a href="?searchfield=age&searchvalue=#replace(i,' ','')#">#i#</a></td>
		</cfloop>
	</tr>
	</table>	
	</td>
</tr>
<tr class="personaldata">
	<td class="label">
	What is the approximate size of your church?:
	</td>
	<td id="personaldatachoices">
	<cfset options = "0-200,200-400,400+">
	<table style="width:100%">
	<tr>
		<cfloop list="#options#" index="i">
			<td class="choice"><a href="?searchfield=churchsize&searchvalue=#replace(i,' ','')#">#i# </td>
		</cfloop>
		<td style="text-align:right"><span class="note">Based on attendance.</span></td>
	</tr>
	</table>	
	</td>
</tr>
</tbody>
<tbody id="otherconferences">
<tr class="conferences">
<td colspan="2" class="label">
		Which annual conferences do you almost always attend?	
</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
	#getpercent(field="willow",answer="on")#% - Willow Creek (any one of them)
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
	#getpercent(field="shepherds",answer="on")#% - Shepherds Conference
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
	#getpercent(field="moody",answer="on")#% - Moody Pastors Conference
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="catalyst",answer="on")#% - Catalyst
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="exponential",answer="on")#% - Exponential	
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td>
		Other: <cfif isdefined("url.other")>#getlist(field="OTHERCONFERENCE")#<cfelse>
<a href="?other=yes" id="otherconferences2">Show Details for Other Conferences</a></cfif>	
<p id="otherconferenceinfo" style="font-size:1em;font-weight:normal;text-align:left;width=100%"></p>
	</td>
</tr>
<tr class="conferences">
<td colspan="2" class="label">
		Why do you go to your first-choice conference?
</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="relationships",answer="on")#% - Relationships	
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="speakers",answer="on")#% - Speakers who inspire	
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="training",answer="on")#% - Training/interaction with new ideas
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="exposure",answer="on")#% - Exposure to successful ministry models
	</td>
</tr>
</tbody>
<tbody id="fgbcconferences">
<tr>
<td colspan="2" class="label">
		Did you go to the following FGBC celebrations? (check to answer "yes") [<a href="?searchfield=attender&searchvalue=attender">view answers for attenders in 06 or 08</a>]
</td>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="innisbrook08",answer="on")#% - 2008 at Innisbrook (Tampa)
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="palmsprings06",answer="on")#% - 2006 at Palm Springs
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="tennessee04",answer="on")#% - 2004 at Tennessee
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="innisbrook03",answer="on")#% - 2003 at Innisbrook (Tampa)
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="philadelphia02",answer="on")#% - 2002 at Philadelphia
	</td>
</tr>
<tr class="conferences">
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="anaheim01",answer="on")#% - 2001 at Anaheim
	</td>
</tr>
<tr>
<td colspan="2" class="label">
		Who underwrites your FGBC conference expense?
</td>
<tr>
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="whopays",answer="self")#% - Self
	</td>
</tr>
<tr>
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="whopays",answer="church")#% - My Church
	</td>
</tr>
<tr>
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="whopays",answer="organization")#% - My Organization
	</td>
</tr>
<tr>
	<td>&nbsp;
	</td>
	<td>
		Other: #getlist(field="whopaysother")#	
	</td>
</tr>
<td colspan="2" class="label">
<div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="economy",answer="better")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="economy",answer="worse")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="economy",answer="same")#px;background-color:white;height:13px;float:right"></div>
				</div>
		What is your best-guess concerning the economy during the summer of 2010? 
						

</td>
<tr>
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="economy",answer="same")#% - It will be about the same as it is now. 
	</td>
</tr>
<tr>
	<td>&nbsp;
	</td>
	<td class="choice">
		#getpercent(field="economy",answer="worse")#% - It will be worse than it is now.
	</td>
</tr>
<tr>
	<td>&nbsp;
	</td>
	<td class="choice">
		 #getpercent(field="economy",answer="better")#% - It will be better than it is now.
	</td>
</tr>
</tbody>
<tr>
<td colspan="2">
<center><h3>Below are some general features for 2010 under consideration.<br> Please let us know how they would impact your decision to attend conference in 2010.<h3></center>
</td>
</tr>
<tbody id="morelikely">
	<tr class="moreless">
		<td colspan="2" class="label">
		<cfset fieldname="shorterconference">
		A shorter, 3-night conference would...
		</td>
	</tr>
	<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer">
					<div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="FIVESTARHOTEL">
		A $120/night 5-star hotel with "meeting, eating, and housing under one roof" would . . .
		</td>
	</tr>
	<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="VACATIONOPTIONS">
		A location that provides many vacation options for me and my family would...
		</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="WESTCOAST">
		A west-coast location would...
		</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.<a href="?searchfield=#fieldname#&searchvalue=morelikely"><img src="/images/view.png"></a></td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.<a href="?searchfield=#fieldname#&searchvalue=noimpact"><img src="/images/view.png"></a></td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. <a href="?searchfield=#fieldname#&searchvalue=lesslikely"><img src="/images/view.png"></a></td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="OUTSIDESPEAKERS">
		Well-known speakers from OUTSIDE the FGBC would...
		</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="INSIDESPEAKERS">
		Quality speakers from INSIDE the FGBC would...
		</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="MOREINTERACTION">
		It is our intention to plan fewer plenary sessions and more smaller group interaction and relationship time.<br> This format would...
		</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>
	<tr class="moreless">
		<td colspan="2" class="label">
				<cfset fieldname="MORETRAINING">
		More ministry training tracks would...
		</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
				<tr>
					<td class="tdspacer"><div style="width:100px;height:13px;position:relative;border:1px solid gray;float:right">
					<div style="width:#getpercent(field="#fieldname#",answer="morelikely")#px;background-color:green;height:13px;position:absolute"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="lesslikely")#px;background-color:red;height:13px;float:right"></div>
					<div style="width:#getpercent(field="#fieldname#",answer="noimpact")#px;background-color:white;height:13px;float:right"></div>
				</div>
</td>
					<td class="choice morelikely">#getpercent(field="#fieldname#",answer="morelikely")#% - Make me more likely to attend.</td>
					<td class="choice noimpact">#getpercent(field="#fieldname#",answer="noimpact")#% - Have no impact on my decision.</td>
					<td class="choice lesslikely">#getpercent(field="#fieldname#",answer="lesslikely")#% - Make me less likely to attend. </td>
				</tr>
				</table>
			</td>
	</tr>

</tbody>
<tbody id="comment">
<tr>
<td colspan="2">
<center>The National Ministries are committed to working together to redesign conference to better assist <br>believers and churches in their 24/7 mission to multiply believers, leaders, churches, and mercy ministries.  <br>How do YOU think they could best accomplish that?"</center>
<center><a href="?showcomments=yes" id="showcomments">Show Comments</a></center>
</td>
</tr>
<tr>
<td colspan="2" id="commentinfo">
<cfif isdefined("url.showcomments")>
<cfquery datasource="#dsn#" name="comments">
	SELECT comment, name
	FROM cel_survey_10
	WHERE comment <> ""
	ORDER BY datetime DESC
</cfquery>	
<p>There are #comments.recordcount# comments...</p>
<hr/>
<cfloop query="comments">
<p style="text-align:left;font-size:1em;font-weight:normal;padding:10px">#comment#</p>
<p style="text-align:right;font-size:.7em;color:gray">#name#</p>
<hr>
</cfloop>
</cfif>
</td>
</tr>
</tbody>
</cfoutput>
</table>
</div>
<cfif isdefined("url.searchfield") and url.searchfield is "WESTCOAST" and url.searchvalue is "lessLikely">
<div id="people" style="text-align:left">
<h2>Folks Who indicated a West Coast location would make them less likely to attend.</h2>
<cfset getpeople()>
<cfset emailall = "">
<ul>
<cfoutput query="people">
<li>#stateabbrev#: #lname#, #fname# - <a href="mailto:#email#">#email#</a></li>
<cfif email is not "">
<cfset emailall = emailall & " ;" & email>
</cfif>
</cfoutput>
</ul>
<cfset emailall = replace(emailall," ;","","one")>
<cfoutput>#emailall#</cfoutput>
</div>
</cfif>
</body>
</html>
