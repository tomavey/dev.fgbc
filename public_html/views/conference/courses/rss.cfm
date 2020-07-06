<cfsilent>
<cfparam name="courses" type="query">
<cfparam name="title" default="need a title">
<cfparam name="description" default="need a description">
<cfparam name="link" default="http://vision2020mobile.com/blog/meals">
<cfparam name="date" default="#dateformat(now())#">
<cfparam name="showIfZero" default="included">
<cfparam name="instructors" default="">

<cfxml variable="rssFeed">
  <rss version="2.0">
     <channel>
		<cfoutput>
        	<title>#title#</title>
        	<link>#link#</link>
        	<description><![CDATA[#description#]]></description>
        	<pubDate>#date#</pubDate>
		</cfoutput>
        <cfoutput query="courses" group="title">
        <cfset instructors = "">
           <item>
              <title><![CDATA[#title#]]></title>
              <description>
                <![CDATA[<p>#descriptionlong#</p>]]>
                <![CDATA[<p>#dayOfWeekasString(dayOfWeek(date))# (#dateFormat(date,"mm/dd")#) #timeFormat(timebegin,"H:mm tt")#</p>]]>
                <cfoutput>
                  <cfset instructors = instructors & fullname & ": " & bioweb & "<br/>">
                </cfoutput>
                <cfset instructors = replace(instructors,", ","","one")>

                Facilitator(s): <![CDATA[#instructors#]]>  
              </description>
              <guid>#id#</guid>
           </item>
        </cfoutput>
     </channel>
  </rss>
</cfxml>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>