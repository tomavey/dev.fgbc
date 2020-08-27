<style>
span.info {margin-left:10px}
</style>
<div class="span11 container">
    <cfoutput query="ministries" >
        <p>
            <span style="font-size:1.2em">#name#</span>
            <cfif len(webaddress)>
                <br/><span class="info">#fixWebSite(webaddress)#</span>
            </cfif>
            <cfif len(email)>
                <br/><span class="info">#lcase(email)#</span>
            </cfif>
            <cfif len(phone)>
                <br/><span class="info">#fixPhone(phone)#</span>
            </cfif>
        </p>
    </cfoutput>
</div>
