<cfloop list="cfcatch,params,session" index="i">

    <cftry>
    <cfdump var="#evaluate(i)#" label="#i#">
    <cfcatch>
    </cfcatch>
    </cftry>

</cfloop>

<h2>Should duplicate below</h2>

<cftry>
<cfdump var="#cfcatch#" label="cfCatch">
<cfcatch>
</cfcatch>
</cftry>

<cftry>
<cfdump var="#params#" label="Params">
<cfcatch>
</cfcatch>
</cftry>

<cftry>
<cfdump var="#session#" label="Session">
<cfcatch>
</cfcatch>
</cftry>