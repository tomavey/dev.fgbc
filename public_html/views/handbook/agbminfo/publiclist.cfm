    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          #linkTo(class="brand", text="Agbm Membership List #currentmembershipyear#", controller="handbook.agbm-info", action="list")#
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