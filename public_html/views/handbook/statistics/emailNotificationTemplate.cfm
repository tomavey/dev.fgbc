<cfparam name="covidAlternateMessage" default=false>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="viewport" content="width=device-width" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Email Template</title>
<style>
*,.collapse{padding:0}.btn,.social .soc-btn{text-align:center;font-weight:700}.btn,ul.sidebar li a{text-decoration:none;cursor:pointer}.container,table.footer-wrap{clear:both!important}*{margin:0;font-family:"Helvetica Neue",Helvetica,Helvetica,Arial,sans-serif}img{max-width:100%}body{-webkit-font-smoothing:antialiased;-webkit-text-size-adjust:none;width:100%!important;height:100%}.content table,table.body-wrap,table.footer-wrap,table.head-wrap{width:100%}a{color:#2BA6CB}.btn{color:#FFF;background-color:#666;padding:10px 16px;margin-right:10px;display:inline-block}p.callout{padding:15px;background-color:#ECF8FF;margin-bottom:15px}.callout a{font-weight:700;color:#2BA6CB}table.social{background-color:#ebebeb}.social .soc-btn{padding:3px 7px;font-size:12px;margin-bottom:10px;text-decoration:none;color:#FFF;display:block}a.fb{background-color:#3B5998!important}a.tw{background-color:#1daced!important}a.gp{background-color:#DB4A39!important}a.ms{background-color:#000!important}.sidebar .soc-btn{display:block;width:100%}.header.container table td.logo{padding:15px}.header.container table td.label{padding:15px 15px 15px 0}.footer-wrap .container td.content p{border-top:1px solid #d7d7d7;padding-top:15px;font-size:10px;font-weight:700}h1,h2{font-weight:200}h1,h2,h3,h4,h5,h6{font-family:HelveticaNeue-Light,"Helvetica Neue Light","Helvetica Neue",Helvetica,Arial,"Lucida Grande",sans-serif;line-height:1.1;margin-bottom:15px;color:#000}h1 small,h2 small,h3 small,h4 small,h5 small,h6 small{font-size:60%;color:#6f6f6f;line-height:0;text-transform:none}h1{font-size:44px}h2{font-size:37px}h3,h4{font-weight:500}h3{font-size:27px}h4{font-size:23px}h5,h6{font-weight:900}h5{font-size:17px}h6,p,ul{font-size:14px}h6{text-transform:uppercase;color:#444}.collapse{margin:0!important}p,ul{margin-bottom:10px;font-weight:400;line-height:1.6}p.lead{font-size:17px;font-weight:bold}p.last{margin-bottom:0}ul li{margin-left:5px;list-style-position:inside}ul.sidebar li,ul.sidebar li a{display:block;margin:0}ul.sidebar{background:#ebebeb;display:block;list-style-type:none}ul.sidebar li a{color:#666;padding:10px 16px;border-bottom:1px solid #777;border-top:1px solid #FFF}.column tr td,.content{padding:15px}ul.sidebar li a.last{border-bottom-width:0}ul.sidebar li a h1,ul.sidebar li a h2,ul.sidebar li a h3,ul.sidebar li a h4,ul.sidebar li a h5,ul.sidebar li a h6,ul.sidebar li a p{margin-bottom:0!important}.soc-btn{color:#000!important}.container{display:block!important;max-width:600px!important;margin:0 auto!important}.content{max-width:600px;margin:0 auto;display:block}.column{width:300px;float:left}.column-wrap{padding:0!important;margin:0 auto;max-width:600px!important}.column table{width:100%}.social .column{width:280px;min-width:279px;float:left}.clear{display:block;clear:both}@media only screen and (max-width:600px){a[class=btn]{display:block!important;margin-bottom:10px!important;background-image:none!important;margin-right:0!important}div[class=column]{width:auto!important;float:none!important}table.social div[class=column]{width:auto!important}}
</style>
</head>

<body bgcolor="#FFFFFF">
<cfif !isDefined("params.go")>
  <cfoutput>
    <p>This email was only sent to tomavey@fgbc.org. Click #linkto(text="this link", action="emailAllCurrentNotPaid", params="go=1")# when you are ready to send to the complete unpaid list.</p>
  </cfoutput>
</cfif>
<table class="head-wrap" bgcolor="#ffffff">
<tr>
  <td></td>
  <td class="header container">
    <div class="content">
      <table bgcolor="#ffffff">
        <tr>
          <td colspan="2">
            <cfoutput>
            <a href="https://charisfellowship.us/sendstats/#args.id#">
                <img src="https://charisfellowship.us/assets/img/logo/charis-logo-main.png" />
            </a>
            </cfoutput>
          </td>
        </tr>
      </table>
    </div>
  </td>
  <td></td>
</tr>
</table>

<table class="body-wrap">
  <tr>
  <td></td>
  <td class="container" bgcolor="#FFFFFF">
  <div class="content">

<table>
  <tr>
    <td>

    <cfoutput>

      <cfif !isBefore(getSetting("memFeeDeadline"))> 

        <h3>Subject: #args.name# (#args.city#) statistics for #year(now())-1# and fellowship fees for #year(now())#. </h3>
        <p>
            GREETINGS! It is a privilege to serve Jesus together in the Charis Fellowship. Out of our deep commitment to biblical truth, relationships and mission we are planting churches, training leaders and doing good for the sake of the gospel!
        </p>
        <p>
            Each year, Charis Fellowship churches agree to send a simple statistical report for the previous year and a fellowship fee for the current year. Stats for #year(now())-1# and the fellowship fee for #year(now())# was May 15 however it is not too late to count!</p>
        <p>
            We are working on a statistical report for the Charis Fellowship and would like to include your church's information. 
        </p>
        <p class="lead">
            Due to the COVID-19 crisis fellowship fees for 2021 will be based on 2019 attendance. If your church needs additional help, email Tim Hodge at <a href="mailto:tim@charisfellowship.us">tim@charisfellowship.us</a> or call the national office at 574-269-1269. 
        </p>      
        </p>
        <p class="callout">
            You can submit this information and pay online at: #linkto(href='https://charisfellowship.us/sendstats/#args.id#', onlyPath="false")# 
        </p>


      <cfelseif !covidAlternateMessage>

        <h3>Subject: #args.name# (#args.city#) statistics for #year(now())-1# and fellowship fee for #year(now())# are due May 15. </h3>
        <p class="lead">
            GREETINGS! It is a privilege to serve Jesus together in the Charis Fellowship. Out of our deep commitment to biblical truth, relationships and mission we are planting churches, training leaders and doing good for the sake of the gospel!
        </p>
        <p>
            Each year, Charis Fellowship churches agree to send a simple statistical report for the previous year and a fellowship fee for the current year. This is a friendly reminder that stats for #year(now())-1# and the fellowship fee for #year(now())# are due May 15.  After that date, the fee increases. Your office should receive #linkto(text="this brochure", href='http://charisfellowship.us/files/#getSetting("StatForm")#')# by regular post requesting your statistics and fellowship fee.
        </p>
        <p class="callout">
            If you would prefer to submit this information and pay online you can use this link: #linkto(href='https://charisfellowship.us/sendstats/#args.id#', onlyPath="false")# 
        </p>

      </cfif>    

    </cfoutput>

            <table class="social" width="100%">
                <tr>
                    <td>

                        <table align="left" class="column">
                            <tr>
                                <td>
                                    <h5 class="">Connect with Us:</h5>
                                    <p class="">
                                        <a href="https://www.facebook.com/charischurches/" class="soc-btn fb">Facebook</a> 
                                        <a href="https://twitter.com/charischurches" class="soc-btn tw">Twitter</a> 
                                        <a href="https://charisfellowship.us" class="soc-btn gp">CharisFellowship.us</a>
                                    </p>
                                </td>
                            </tr>
                        </table>

                        <table align="left" class="column">
                            <tr>
                                <td>
                                    <h5 class="">Contact Info:</h5>
                                    <p>Phone: <strong>574.269.1269</strong><br />
                                    Email: <strong><a href="emailto:tim@charisfellowship.us">tim@charisfellowship.us</a></strong></p>
                                </td>
                            </tr>
                        </table>

                    <span class="clear"></span>
                    </td>
                </tr>
            </table>
                  <p style="text-align:center;font-size:.9em;color:grey">Charis Fellowship is an assumed business name (D.B.A.) of the Fellowship of Grace Brethren Churches inc.</p>


              </td>
          </tr>
      </table>
  </div>
  </td>
  <td></td>
  </tr>
</table>

<table class="footer-wrap">
    <tr>
        <td></td>
        <td class="container">
            <div class="content">
            <table>
                <tr>
                    <cfoutput>
                    <td align="center">
                        Sent to #args.emails#
                    </td>
                    </cfoutput>
                </tr>
            </table>
            </div>
        </td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2">
        <cfif isDefined("params.test") || isDefined("showResults")>
            <cfoutput>
                <p>Emails were NOT sent to:</p>
                <cfloop from="1" to='#arrayLen(statsEmail.Failed)#' index="i">
                   #i#- #statsEmail.Failed[i].emails# for #statsEmail.Failed[i].name# #statsEmail.Failed[i].city#</br>
                </cfloop>
                <br/>

                <p>Emails were sent to:</p>
                <cfloop from="1" to='#arrayLen(statsEmail.Sent)#' index="org">
                    #org#- #statsEmail.Sent[org].emails# for #statsEmail.Sent[org].name# #statsEmail.Sent[org].city#</br>
                </cfloop>
                            

            </cfoutput>
        </cfif>    
        </td>
    </tr>    
</table>

</body>
</html>