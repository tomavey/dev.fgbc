<cfoutput>
<div style="width:100%; background-color:gray">
    <div style="width:80%;margin: 0 auto;background-color:white">
        <h2 style="text-align:center">Thank you for sharing a cohort resource.</h2>
        <p style="text-align:center">
            #linkto(text="Use this link to edit your resource listing", 
            controller="conference.courseresources", 
            action="edit", 
            key=uuid, onlyPath=false)#
        </p>
    </div>
</div>
</cfoutput>