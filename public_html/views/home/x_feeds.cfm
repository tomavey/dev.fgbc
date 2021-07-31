		<div class="postbox lefthalf" id="rssfeeds">
		<cfoutput>
			<h2 class="postboxtitle">News Feeds</h2>
			<p>#getcontent("newsfeeds").content#

<a class="twitter-timeline"  href="https://twitter.com/fgbc" data-widget-id="258154977585922049">Tweets by @fgbc</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

		#linkTo(text="More News", href="http://www.twitter.com/fgbc")#
		</cfoutput>
		</div>
	
