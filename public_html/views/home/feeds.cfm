		<div class="postbox" id="rssfeeds">
		<cfoutput>
			<h2 class="postboxtitle">News Feeds</h2>
			<p>#getcontent("newsfeeds").content#

			<cfif gotrights("superadmin,office")>
			    <div id="addnew">
				    #editTag(getcontent("newsfeeds").id,"contents")#
			    </div>
			</cfif>    
            <div id="twitter_div">
	            <ul id="twitter_update_list"></ul>
            </div>
		</cfoutput>
		</div>
