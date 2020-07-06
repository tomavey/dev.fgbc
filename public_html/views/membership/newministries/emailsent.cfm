<div class="row-fluid well contentStart contentBg">

    <cfoutput>
        <p>An email with a link to edit the cooperating ministry application for <span style="font-size:1.3em; font-style:italic;">#ministryname#</span> was sent to #mailto(contactemail)#.</p>
        <p>&nbsp;</p>
        <p>You can view your application here: #linkto(controller="membership.newministries", action="show", params="id=#ministryid#", onlyPath=false)#</p>
    </cfoutput>

</div>