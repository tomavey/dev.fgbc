<cfsilent>
<cfparam name="announcements" type="query">
<cfparam name="title" default="Access2017 Announcements">
<cfparam name="description" default="These are the announcements that have been sent by email to Access2017 registrants.">
<cfparam name="link" default="http://www.access2017/com">
<cfparam name="date" default="#dateformat(now())#">
<cfparam name="showIfZero" default="included">

<cfxml variable="rssFeed">
  <rss version="2.0">
     <channel>
		<cfoutput>
        	<title>#title#</title>
        	<link>#link#</link>
        	<description><![CDATA[#description#]]></description>
        	<pubDate>#date#</pubDate>
		</cfoutput>
        <cfoutput query="announcements">
           <item>
              <title><![CDATA[#subject#]]></title>
              <description><![CDATA[#content#]]></description>
              <image></image>
              <guid>#id#</guid>
           </item>
        </cfoutput>
     </channel>
  </rss>
</cfxml>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>