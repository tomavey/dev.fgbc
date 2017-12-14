<div class="spann11">
    <h1>Charis Fellowship Districts and Churches</h1>
    <div class="offset1">
        <cfoutput query="districts" group="district">
            <h2>#district#</h2>
            <cfoutput>
                #selectname#<br/>
            </cfoutput>
        </cfoutput>
    </div>
</div>