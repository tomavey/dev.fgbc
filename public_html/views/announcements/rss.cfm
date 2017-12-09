<cfsilent>
<cfparam name="announcements" type="query">
<cfparam name="title" default="need a title">
<cfparam name="description" default="need a description">
<cfparam name="link" default="http://www.fgbc.org">
<cfparam name="date" default="#dateformat(now())#">
<cfparam name="showIfZero" default="included">

<cfxml variable="rssFeed">
  <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
     <channel>
	 <atom:link href="http://charisfellowship.us/announcements/rss" rel="self" type="application/rss+xml" />
		<cfoutput>
        	<title>#title#</title>
        	<link>#link#</link>
        	<description><![CDATA[#description#]]></description>
        	<pubDate>#GetHttpTimeString(date)#</pubDate>
		</cfoutput>
        <cfoutput query="announcements">
           <item>
            <title>
			  <![CDATA[#title#]]>
			</title>
			<link>
			  http://charisfellowship.us/announcements/show/#id#
			</link>
      <description>
			  <![CDATA[#content#]]>
			</description>
      <pubDate>
			  #GetHttpTimeString(startAt)#
			</pubDate>
            <guid>
			  http://charisfellowship.us/announcements/show/#id#
			</guid>
           </item>
        </cfoutput>
     </channel>
  </rss>
</cfxml>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>