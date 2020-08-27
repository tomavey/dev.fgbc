<cfoutput>
<cftry>	
<p>Params:</p>
<cfloop list="#StructKeyList(params)#" index="i">
#i# = #params[i]#<br/>
</cfloop>
<cfcatch>Could not get params<br/></cfcatch></cftry>

<cftry>	
<p>Shopping Cart:</p>
<cfloop from = "1" to="#arraylen(session.shoppingcart)#" index="i">
#i# = #session.shoppingcart[i]#<br/>
</cfloop>
<cfcatch>Could not get shopping cart<br/></cfcatch></cftry>

<cftry>	
<p>Registration Cart:</p>
<cfloop list="#StructKeyList(session.registrationcart)#" index="i">
#i# = #session.registrationcart[i]#<br/>
</cfloop>
<cfcatch>Could not get shopping cart<br/></cfcatch></cftry>

<cftry>
	<cfdump var="#session#" format="text">
<cfcatch></cfcatch>
</cftry>

</cfoutput>