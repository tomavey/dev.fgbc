<div class="span11 container">
    <cfoutput query="ministries" >
        <p>
            <span style="font-size:1.2em">#name#</span><br/>
            #fixWebSite(webaddress)#<br/>
            #lcase(email)#<br/>
            #fixPhone(phone)#
        </p>
    </cfoutput>
</div>
