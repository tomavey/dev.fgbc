<div class="span11 container">
    <cfoutput query="ministries" >
        <p>
            <span style="font-size:1.2em">#name#</span>
            <cfif len(webaddress)>
                <br/>&nbsp;&nbsp;#fixWebSite(webaddress)#
            </cfif>
            <cfif len(email)>
                <br/>&nbsp;&nbsp;#lcase(email)#
            </cfif>
            <cfif len(phone)>
                <br/>&nbsp;&nbsp;#fixPhone(phone)#
            </cfif>
        </p>
    </cfoutput>
</div>
