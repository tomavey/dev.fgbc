<div class="span11 container">
    <cfoutput query="ministries" >
        <p>
            <span style="font-size:1.2em">#name#</span>
            <cfif len(webaddress)>
                <br/>#fixWebSite(webaddress)#
            </cfif>
            <cfif len(email)>
                <br/>#lcase(email)#
            </cfif>
            <cfif len(phone)>
                <br/>#fixPhone(phone)#
            </cfif>
        </p>
    </cfoutput>
</div>
