<div class="postbox" id="maininfo">
    <p class="well">Staff listed by birthyear, youngest first</p>
    <div id="ajaxinfo">
        <cfoutput query = "datesSorted">
            <cfset linktext = "#lname#, #fname# <i>#spouse#</i>: #city#, #state_mail_abbrev# - #birthdayyear#">
            <p>
                #linkTo(
                        text=linktext,
                        controller="handbook.people",
                        action="show",
                        key=personid,
                        id="ajaxclickable",
                        class="tooltip2",
                        title="Click to show #fname# #lname# in the center panel.",
                        onlyPath=false
                        )#
                </p>       
        </cfoutput>
    </div>
</div>