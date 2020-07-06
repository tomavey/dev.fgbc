<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html><!-- InstanceBegin template="/Templates/body-page.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="(2)	The Fellowship of Grace Brethren Churches is a voluntary association of more than 260 churches in the United States and Canada. (3)	Churches in the FGBC are autonomous in structure, relevant in style, and Biblical in substance.  The Bible is our authority, loving relationships our glue, and hope in Jesus Christ is our passion.">
<meta http-equiv="Content-language" content="en-US">
<meta name="copyright" content="©2005 FGBC.org. All rights reserved.">
<meta name="distribution" content="global">
<meta name="classification" content="Church, Non Profit Organizations, Non for Profit, Missions, Community Service">
<meta name="rating" content="General">
<meta name="author" content="eye9design.com">
<meta name="resource-type" content="document">
<meta name="revisit-after" content="15 days">
<meta name="organization" content="FGBC">
<meta name="ROBOTS" content="ALL">
<!-- InstanceBeginEditable name="doctitle" -->
<title>FellowshipCouncil</title>
<!-- InstanceEndEditable -->

<!-- InstanceBeginEditable name="head" -->





<style type="text/css">
<!--
.style1 {font-weight: bold}
-->
</style>
<!-- InstanceEndEditable -->
<style type="text/css">
<!--
body {
	background-image: url(../images/bkg.jpg);
}
-->
</style>
<link href="../fgbc.css" rel="stylesheet" type="text/css">
</head>

<body>

<div align="center">
  <table width="743" height="167" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <th height="22" scope="col"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="743" height="40">
        <param name="movie" value="../header-nav.swf">
        <param name="quality" value="high">
        <embed src="../header-nav.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="743" height="40"></embed>
      </object></th>
    </tr>
    <tr>
      <td height="37">
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="2" background="../images/bkg-body-top.gif"><!-- InstanceBeginEditable name="headerbody" --><br>
              <div align="left" class="text style1">
                <div align="left">Fellowship Council Forum </div>
              </div>
            <!-- InstanceEndEditable --></td>
          </tr>
          <tr>
            <td valign="top" background="../images/bkg-body-middle.gif"><!-- InstanceBeginEditable name="bodyareas" -->
              <table align="center">
			  <form name="form1" method="post" action="forum_file1.cfm">
			  <tr>
			  <td>First Name:</td><td><input name="fname" type="text" size="30" maxlength="30"></td>
			  </tr>
			  <tr>
			  <td>Last Name:</td><td><input name="lname" type="text" size="30" maxlength="30"></td>
			  </tr>
			  <tr>
			  <td>Comment:</td><td><textarea name="post" cols="75" rows="10"></textarea></td>
			  </tr>
			  <tr>
			  <td>Attach File:</td><td><input name="file_forum" type="file" size="30" maxlength="30"></td>
			  </tr>
			  <tr>
			  <td></td><td class="smalltext"><input name="Submit" type="submit" value="Submit">(Comments will be sent to the Fellowship Council by email)</td>
			  </tr>
			  
              </form>
			  </table>
			  
			  <cfquery datasource="#dsn#" name="comments">
			  select f.fname, f.lname, s.email, f.post, f.time
			  from fc_forum f, staff s
			  where f.staffid = s.staffid
			  order by time desc
			  </cfquery>
			  <table border="0" bgcolor="#FFFFCC" align="center" class="smalltext">
			  <tr>
			  <td class="smalltext">Give us guidance regarding the plan you have for our Fellowship. What is your vision for our Fellowship in the years to come? Are we seeing our future as you have planned it clearly? Do we have a sufficient process by which we determine God’s plans for our Fellowship? Are we structured for the vision You have for us?  Is the Moderator’s present one-year tenure sufficient to establish a continuity of vision for our Fellowship?  Point out those visionaries within our Fellowship who can help our leaders establish a plan.  What individuals demonstrate visionary leadership in our Fellowship?  How do we include the heads of our cooperating ministries in guiding our Fellowship?  Should the heads of our cooperating ministries have a consulting role to our Moderators for 2009 and beyond?  Help me determine the type of leader we need to guide us into Your future. What are three characteristics of our Moderator for 2009?  Can you give us one name for a Moderator for 2009 who would serve a three-year term?</td></tr></table>
			  <table align="center" width="100%">
			  <tr>
			  <td><strong>Name and Email</strong></td><td><strong>Comment and Date (most recent comments are at the top)</strong></td>
			  </tr>
			  <tr>
			  <td><hr></td><td><hr></td>
			  </tr>
			  <cfoutput query="comments">
			  <tr>
			  <td width="20%">#fname# #lname# (<a href="mailto:#email#">#email#</a>)</td><td>#ParagraphFormat(post)# <font size="-3" color="grey">[posted: #dateformat(time)#]</font></td>
			  </tr>
			  <td><hr></td><td><hr></td>
			  </tr>
			  </cfoutput>
			  </table>
            <!-- InstanceEndEditable --></td>
          </tr>
          <tr>
            <td height="2" valign="top"><img src="../images/bkg-body-bottom.gif" width="743" height="10"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td height="2">&nbsp;</td>
    </tr>
    <tr>
      <td height="62"><table width="100%" height="58"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="3" background="../images/bkg-body-top.gif">&nbsp;</td>
        </tr>
        <tr>
          <td height="30" background="../images/bkg-body-middle.gif"><div align="center" class="text">
            <div align="left">
              <p align="center"> <span class="textSmall"><a href="../index.htm" class="textbottom">Home</a> | <a href="../who-are-we.htm" class="textbottom">Who are We?</a> | <a href="http://www.fgbc.org/church_listings.php" class="textbottom">Find a Church</a> | <a href="../e-newsletter.htm" class="textbottom">E-Newsletter</a> | <a href="../calendar.htm" class="textbottom">Calendar</a> | <a href="../blogs.htm" class="textbottom">Blogs</a> | <a href="../links.htm" class="textbottom">Links</a> | <a href="../jobs.htm" class="textbottom">Jobs</a> | <a href="../contact-us.htm" class="textbottom">Contact Us</a></span></p>
              <p align="center" class="textSmall" style="margin-bottom: 0;"><a href="http://www.eye9design.com" class="textbottom">Web Design by eye9 Design</a></p>
            </div>
          </div></td>
        </tr>
        <tr>
          <td height="10" valign="top"><img src="../images/bkg-body-bottom.gif" width="743" height="10"></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>
</body>
<!-- InstanceEnd --></html>
