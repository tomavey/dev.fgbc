<!--- <cfdump var="#ministerium#"><cfabort> --->
<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <h2>AGBM Membership List for #currentMembershipYear#</h2>
          <div class="nav-collapse">
          </div><!--/.nav-collapse -->
			</cfoutput>
        </div>
      </div>
    </div>
<div class="container">
<p style="margin-top:60px">&nbsp;</p>
<cfoutput query="ministerium" group="district">
<h2>#district#</h2>
<ol>
<cfoutput>
<li><em>#fname# #lname#</em> - #name#, #org_city#, #org_state#</li>
</cfoutput>
</ol>
</cfoutput>
</div>
<cfoutput>
Total Count = #ministerium.recordcount#<br/>
</cfoutput>