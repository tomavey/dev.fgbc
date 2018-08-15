<cfsilent>
<cfparam name="announcements" type="query">
<cfparam name="title" default="need a title">
<cfparam name="description" default="need a description">
<cfparam name="link" default="http://www.charisfellowship.us">
<cfparam name="date" default="#dateformat(now())#">
<cfparam name="showIfZero" default="included">
<cfparam name="imageUrl" default="https://charisfellowship.us/assets/img/logo/charis-logo-main.png">
<cfparam name="imageLink" default="http://www.charisfellowship.us">
<cfparam name="imageTitle" default="Charis Fellowship">

<cfxml variable="rssFeed">
  <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
     <channel>
	 <atom:link href="https://charisfellowship.us/announcements/rss" rel="self" type="application/rss+xml" />
		<cfoutput>
        	<title>#title#</title>
        	<link>#link#</link>
					<image>
						<url>#imageUrl#</url>
						<title>#imageTitle#</title>
						<link>#imageLink#</link>
					</image>
        	<description><![CDATA[#description#]]></description>
        	<pubDate>#GetHttpTimeString(date)#</pubDate>
		</cfoutput>
        <cfoutput query="announcements">
          <item>
            <title>
			  			<![CDATA[#title#]]>
						</title>
						<link>
			  			https://charisfellowship.us/announcements/show/#id#
						</link>
      			<description>
			  			<![CDATA[#content#]]>
						</description>
     				<pubDate>
			  				#GetHttpTimeString(startAt)#
						</pubDate>
            <guid>
			  			https://charisfellowship.us/announcements/show/#id#
						</guid>
          </item>
        </cfoutput>
     </channel>
  </rss>
</cfxml>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>