<cfsilent>
<cfparam name="options" type="query">
<cfparam name="title" default="need a title">
<cfparam name="description" default="need a description">
<cfparam name="link" default="http://vision2020mobile.com/blog/meals">
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
        <cfoutput query="options">
           <item>
              <title><![CDATA[#buttondescription#]]> - <cfif type is not "meal" and (cost is 0 or len(cost) is 0)>#showIfZero#<cfelse>#dollarformat(cost)#</cfif></title>
              <description><![CDATA[#description#]]>
				<![CDATA[<p id="ad">#ad#</p>]]></description>
			  <ad><![CDATA[#ad#]]></ad>
              <image><cfif len(image)><url>http://www.fgbc.org/vision2020/images/#image#</url><link>#link#</link><title>#title#</title></cfif></image>
              <guid>#id#</guid>
           </item>
        </cfoutput>
     </channel>
  </rss>
</cfxml>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>