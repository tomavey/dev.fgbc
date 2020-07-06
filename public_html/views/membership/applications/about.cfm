<cfoutput>

<cfif !isDefined("params.old")>
    <p>#linkto(text="Use old version", action="about", params="old")#</p>
</cfif>

<cfif isDefined("params.old")>
    #getContent("Joining the FGBC Family").content#
<cfelse>
    <div class="well">
    #getContent("Joining the Charis Fellowship").content#
    </div>
</cfif>

</cfoutput>