<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<!-- Place HTML here that should be used as the default layout of your application -->
<html>
	<head>
		<cfoutput>
			<cfsetting requestTimeout="60">
			#javaScriptIncludeTag("jquery.min.js,ajaxdelete,bootstrap,jquery_ujs,tooltips,conference/admin/scripts")#
			#styleSheetLinkTag("/conference/regreset,/conference/jquery.ui.theme,conference/jquery-ui-timepicker,conference/jquery.ui.core,conference/jquery-ui.custom,conference/data_table,conference/regstyle,bootstrap,bootstrap-responsive.min,/assets/vendor/icon-awesome/css/font-awesome.min,conference/conferencehomes")#
	
    </cfoutput>
  </head>
	<body style="padding-top:40px">
</div>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
<cfoutput>
			<div id="contentForLayout">
			#contentForLayout()#
			</div>

		<cfif gotRights("superadmin")>
			#application.wheels.sendemailonerror#<br/>
			#application.wheels.erroremailsubject#<br/>
			<cfif isDefined("session.originalUrl")>
				Original URL:#session.originalUrl#<br/>
			</cfif>
			<cfif isDefined("session.previousUrl")>
				Previous URL#session.previousUrl#<br/>
			</cfif>
		</cfif>

		<cfif isDefined("session.auth.rightslist")>
			<p>#session.auth.rightslist#</p>
		</cfif>

#forcecfcatch()#
	</body>
		</cfoutput>
</html>