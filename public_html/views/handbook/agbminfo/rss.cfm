<cfsilent>

		<cfxml variable="rssFeed">
		  <rss version="2.0">
		     <channel>
		        <title>Association of Grace Brethren Ministers Membership List</title>
		        <link>https://charisfellowship.us/handbook</link>
		        <description>Association of Grace Brethren Ministers Membership List <cfoutput>(#ministerium.recordcount# members)</cfoutput></description>
		        <pubDate><cfoutput>#GetHttpTimeString(now())#</cfoutput></pubDate>
		        <cfoutput query="ministerium" group="personid">
				        
		           <cfset desc = "#name#, #org_city#, #org_state#, (#district#)" /> 
		           <item>
		              <title>#lname#, #fname#</title>
		              <description>   <![CDATA[#Desc#]]> </description>
		              <link>https://charisfellowship.us/handbook/people/#personid#</link>
		              <guid>https://charisfellowship.us/handbook/people/#personid#</guid>
		           </item>
		        </cfoutput>
		           <item>
		              <title>Member Count:</title>
		              <description><cfoutput>#ministerium.recordcount# members</cfoutput></description>
		              <link>https://charisfellowship.us</link>
		              <guid>https://charisfellowship.us</guid>
		           </item>
		     </channel>
		  </rss>
		</cfxml>
		
		<cfset rssFeed = toString(rssfeed)>
		<cfset rssFeed = trim(rssfeed)>

</cfsilent><cfsetting enableCFoutputOnly = "true"><cfprocessingdirective SUPPRESSWHITESPACE = "true"><cfoutput>#trim(rssFeed)#</cfoutput></cfprocessingdirective>