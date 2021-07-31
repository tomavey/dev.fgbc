<cfsilent>
<cfparam name="jobs" type="query">
<cfparam name="title" default="need a title">
<cfparam name="description" default="need a description">
<cfparam name="link" default="http://www.fgbc.org">
<cfparam name="date" default="#dateformat(now())#">

<cfxml variable="rssFeed">
  <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
     <channel>
	 <atom:link href="http://www.fgbc.org/jobs/rss" rel="self" type="application/rss+xml" />
		<cfoutput>
        	<title>#title#</title>
        	<link>#link#</link>
        	<description><![CDATA[#description#]]></description>
        	<pubDate>#GetHttpTimeString(date)#</pubDate>
		</cfoutput>
        <cfoutput query="jobs">
           <item>
            <title>
			  <![CDATA[#title#]]>
			</title>
			<link>
			  http://www.fgbc.org/jobs/show/#id#
			</link>
            <description>
			  <![CDATA[#description#]]>
			</description>
            <pubDate>
			  #GetHttpTimeString(createdAt)#
			</pubDate>
            <guid>
			  http://www.fgbc.org/jobs/show/#id#
			</guid>
           </item>
        </cfoutput>
     </channel>
  </rss>
</cfxml>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>