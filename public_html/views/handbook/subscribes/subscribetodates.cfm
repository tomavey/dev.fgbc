<div class="span10">
    <cfoutput>
        <div class="well">Please provide your email address below. You will recieve daily email notices of birthdays and anniversaries.</div>

        #startFormTag(route="handbook-subscribes", method="get")#
        #textFieldTag(name='key', label='Your Email Address:')#
        #submitTag()#
        #endFormTag()#

    </cfoutput>
</div>