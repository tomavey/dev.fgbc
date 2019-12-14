<!DOCTYPE html>
<html lang="en-US" ng-app="access">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="Aviators - byaviators.com">

    <link rel="stylesheet" href="/stylesheets/conference/bootstrap.css" type="text/css">

    <link rel="stylesheet" href="/stylesheets/conference/regstyle.css" type="text/css">

    <!--- <link rel="stylesheet" href="/stylesheets/conference/custom2017.css" type="text/css"> --->

    <!---Favicons--->
    <meta name="theme-color" content="#ffffff">

    <!--- <script src="https://cdn.jsdelivr.net/npm/vue"></script> --->
    <script src="/assets/js/vue.js"></script>

    <style>
        @media only screen and (max-width: 500px) {
            body {
                width: 300px;
            }
        }
    </style>


    <title>Access2018 Conference...</title>
    <cfparam name="headerSubTitle" default="">
</head>

<body style="background-image: linear-gradient(240deg,#289CEF 0%,#5B2AEF 100%)!important;">

<div class="main">

<div id="nav-header" class="header-wrapper">
    <div class="header">
    
                            <div class="header-item registration-center">
                            <cfoutput>
                                <div>
                                    <h1>#getEventAsText()#</h1>
                                    <h4>#headerSubTitle#</h4>
                                </div><!-- /.title -->

                            </cfoutput>        
                            </div><!-- /.header-item -->


    </div><!-- /.header -->
</div><!-- /.header-wrapper -->

<div class="container">
    <cfoutput>#includeContent()#</cfoutput>
</div>

</div>

<div ng-controller="contactMessageController">

<div id="nav-contact" class="footer-wrapper">

        <div class="footer container">

        <div class="footer-inner">
            <div class="row">
                <div class="item col-md-4">
                    <h2>Contact us</h2>

                    <address>
                        <div class="xicon xicon-normal-pointer"></div>
                        <div class="address-content">
                            <span class="title"><strong>Charis Fellowship</strong></span>
                            <p>PO Box 384, Winona Lake</p>
                            <p>IN 46590, United States</p>
                        </div>
                    </address>

                    <address>
                        <div class="xicon xicon-normal-mail"></div>
                        <div class="address-content">

                                <a href="mailto:tomavey@fgbc.org" class="e-mail">tomavey@charisfellowship.us</a>

                        </div>
                        <br>

                        <div class="xicon xicon-normal-phone"></div>
                        <div class="address-content">
                            <span class="title">(574) 269 1269 *</span>
                        </div>
                    </address>


                </div><!-- /.item -->

<!---
                <div class="item col-md-8">
                    <h2 ng-cloak>{{contactFormMessage}}</h2>

                    <form name="contactForm" class="contact-form footer-form" method="post">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="control-group">
                                    <div class="controls">
                                        <input type="text" name="name" placeholder="Your name" required="required" ng-model="contact.name">
                                        <span class="icon icon-normal-profile-male"></span>
                                    </div><!-- /.controls -->
                                </div><!-- /.control-group -->
                            </div><!-- /.span4 -->

                            <div class="col-sm-6">
                                <div class="control-group">
                                    <div class="controls">
                                        <input type="email" name="email" placeholder="Your e-mail" required="required" ng-model="contact.email">
                                        <span class="icon icon-normal-mail"></span>
                                    </div><!-- /.controls -->
                                </div><!-- /.control-group -->
                            </div><!-- /.span4 -->
                        </div><!-- /.row -->

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="control-group">
                                    <div class="controls">
                                        <textarea name="message" placeholder="Your message" required="required" ng-model="contact.message"></textarea>
                                        <span class="icon icon-normal-pencil"></span>
                                    </div><!-- /.controls -->
                                </div><!-- /.control-group -->
                            </div><!-- /.span8 -->
                        </div><!-- /.row -->

                        <div class="form-actions">
                            <input type="submit" class="btn btn-send col-md-3" value="Send" ng-click="addContactMessage()">
                        </div><!-- /.form-actions -->
                    </form><!-- /.footer-form -->
                </div><!-- /.item -->
--->
            </div><!-- /.row -->
            </div><!-- /.row -->
        </div><!-- /.footer-inner -->
    </div><!-- /.footer -->
    </div><!-- /.footer -->



        <div class="footer-bottom">
        <div class="container">
            <div class="row footer-bottom-wrapper">
                <div class="copyright left">
                    &nbsp;
                </div><!-- /.copyright -->

                <div class="icons right">
                    <a href="#" class="social-icon"><img src="https://www.access2018.com/assets/icons/icon-twitter.png" alt=""></a>
                    <a href="#" class="social-icon"><img src="https://www.access2018.com/assets/icons/icon-facebook.png" alt=""></a>
                    <a href="#" class="social-icon"><img src="https://www.access2018.com/assets/icons/icon-youtube.png" alt=""></a>
                </div><!-- /.icons -->
            </div><!-- /.row -->
        </div><!-- /.container -->
    </div><!-- /.footer bottom -->



</div><!-- /.footer-wrapper -->

<cfif application.wheels.environment is "development">
<cftry>
<cfdump var="#session.shoppingcart#"  label="Shopping cart in session">
<cfcatch></cfcatch></cftry>
<cftry>
<cfdump var="#session.registrationcart#" label="Registration cart in session">
<cfcatch></cfcatch></cftry>
<cftry>
<cfdump var="#cart#" label="Query used in this shopping cart">
<cfcatch></cfcatch></cftry>
<cftry>
<cfdump var="#debug#" label="Variables to debug">
<cfcatch></cfcatch></cftry>
<cfdump var="#params#" label="Params">
<cfdump var="#session#" label="The Full Session">
</cfif>


</body>
</html>
