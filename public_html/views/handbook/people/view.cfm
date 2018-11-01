<cfparam name="handbookperson" required="true" type="struct">
<cfif handbookperson.hideFromPublic>

    <p>You do not have access to this page</p>

<cfelse>    

    <div id="personview" class="span11 text-center">



    <cfoutput>

    #includePartial("pictures")#

        <h3>#handbookperson.fullName#</h3>
        <cfif len(handbookperson.phone)>
            Home: #handbookperson.phone#<br/>
        </cfif>
        <cfif len(handbookperson.phone2)>
            Cell: #handbookperson.phone2#<br/>
        </cfif>
        <cfif len(handbookperson.phone3)>
            Work: #handbookperson.phone3#<br/>
        </cfif>
        <cfif len(handbookperson.email)>
            Primary Email: #mailto(handbookperson.email)#<br/>
        </cfif>
        <cfif len(handbookperson.email2)>
            Secondary Email: #mailto(handbookperson.email2)#<br/>
        </cfif>

    #includePartial("positions")#

    </cfoutput>
    </div>
    
</cfif>
