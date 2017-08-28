<!--- fbx_utils.cfm --->

<!--- check for conditions and then set session.auth.fellowshipcouncil to allow access--->

	<!---Check for authorized login--->
	<cfif gotrights("natminproj,superadmin,fellowshipcouncil")>
		<cfset session.auth.fellowshipcouncil = "yes">
		<cfset session.auth.forum = 1>

	<cfelseif isdefined("url.code")
			and (url.code is "fellowshipcouncil")
			and isdefined("url.email")
			>
			<cfset session.auth.email = url.email>
			<cfset session.auth.rightslist = "fellowshipcouncil">
			<cfcookie name="fellowshipcouncil" value="#url.email#" expires="NEVER">
			<cfset session.auth.fellowshipcouncil = "yes">
			<cfset session.auth.forum = 1>

		<!---Check for cookie.natminprojemail--->
	<cfelseif isdefined("cookie.fellowshipcouncil") and cookie.fellowshipcouncil is not "">
			<cfset session.auth.email = cookie.fellowshipcouncil>
			<cfset session.auth.rightslist = "fellowshipcouncil">
			<cfset session.auth.fellowshipcouncil = "yes">
			<cfset session.auth.forum = 1>

	<cfelseif isdefined("url.fuseaction") and isdefined("url.id") and url.id is 1>
			<cfset session.auth.fellowshipcouncil = "yes">
			<cfset session.auth.forum = 1>

	<cfelse>
			<cflocation url="/fc/checkin.cfm">
		<cfabort>
	</cfif>

	<cfif isdefined("url.lock")>
		<cfset structDelete(session,"auth")>
	</cfif>

	<cfif not isdefined("session.auth.fellowshipcouncil") OR not session.auth.fellowshipcouncil>
			<cflocation url="checkin.cfm">
	</cfif>

	<!---Fail if one of the conditions above are not met--->



<!---end of permissions check--->

 <cffunction name="fbxUrl" output="No">
   <cfargument name="p_fuseaction" default="">
   <cfset var result=''>
   <cfset result = 'index.cfm?fuseaction=' & trim(p_fuseaction)>
   <cfreturn result>
 </cffunction>

 <cffunction name="fbx" output="No">
   <cfargument name="p_fuseaction" default="">
   <cfset var result=''>
   <cfset result = '/fc/index.cfm?fuseaction=' & trim(p_fuseaction)>
   <cfreturn result>
 </cffunction>

<cffunction name="GotRights">
<cfargument name="rightRequired" required="yes">
	<cfset permission = "no">
        <cfloop list="#rightrequired#" index="i">
            <cfif isdefined("session.auth.rightslist") and listfind(session.auth.rightslist,"#i#")>
                <cfset permission = "yes">
            </cfif>

            <cfif i is "handbook">
                <cftry>
                    <cfinvoke component="_model.handbook.staff.cfc_handbook_staff" method="get" email="#session.auth.email#" maxSortOrder="900" returnvariable="handbook" />

                    <cfif handbook.recordcount>
                        <cfset permission = "yes">
                    </cfif>
                <cfcatch></cfcatch></cftry>
            </cfif>
        </cfloop>
<cfreturn permission>
</cffunction>


<!---function to scramble email address--->
<cffunction name="scramble" access="public" output="false" hint="Scrambles passed email address" returntype="string">
        <cfargument name="email" type="string" default="" hint="Email passed in" required="yes">
        <cfset email = replace(email, "@", "&###asc('@')#;", "all") />
        <cfset email = replace(email, ".", "&###asc('.')#;", "all") />
        <cfset email = replace(email, "_", "&###asc('_')#;", "all") />
        <cfset email = replace(email, "-", "&###asc('-')#;", "all") />
        <cfset email = replace(email, "?", "&###asc('?')#;", "all") />
        <cfset email = replace(email, "!", "&###asc('!')#;", "all") />
        <cfset email = replace(email, "=", "&###asc('=')#;", "all") />
        <cfset email = replace(email, "/", "&###asc('/')#;", "all") />
        <cfset email = replace(email, ":", "&###asc(':')#;", "all") />
        <cfset email = replace(email, ",", "&###asc(',')#;", "all") />
        <cfset email = replace(email, "+", "&###asc('+')#;", "all") />
        <cfset email = replace(email, "*", "&###asc('*')#;", "all") />
        <cfset email = replace(email, "(", "&###asc('(')#;", "all") />
        <cfset email = replace(email, ")", "&###asc(')')#;", "all") />
        <cfset email = replace(email, "<", "&###asc('<')#;", "all") />
        <cfset email = replace(email, ">", "&###asc('>')#;", "all") />
        <cfset email = replace(email, "a", "&###asc('a')#;", "all") />
        <cfset email = replace(email, "b", "&###asc('b')#;", "all") />
        <cfset email = replace(email, "c", "&###asc('c')#;", "all") />
        <cfset email = replace(email, "d", "&###asc('d')#;", "all") />
        <cfset email = replace(email, "e", "&###asc('e')#;", "all") />
        <cfset email = replace(email, "f", "&###asc('f')#;", "all") />
        <cfset email = replace(email, "g", "&###asc('g')#;", "all") />
        <cfset email = replace(email, "h", "&###asc('h')#;", "all") />
        <cfset email = replace(email, "i", "&###asc('i')#;", "all") />
        <cfset email = replace(email, "j", "&###asc('j')#;", "all") />
        <cfset email = replace(email, "k", "&###asc('k')#;", "all") />
        <cfset email = replace(email, "l", "&###asc('l')#;", "all") />
        <cfset email = replace(email, "m", "&###asc('m')#;", "all") />
        <cfset email = replace(email, "n", "&###asc('n')#;", "all") />
        <cfset email = replace(email, "o", "&###asc('o')#;", "all") />
        <cfset email = replace(email, "p", "&###asc('p')#;", "all") />
        <cfset email = replace(email, "q", "&###asc('q')#;", "all") />
        <cfset email = replace(email, "r", "&###asc('r')#;", "all") />
        <cfset email = replace(email, "s", "&###asc('s')#;", "all") />
        <cfset email = replace(email, "t", "&###asc('t')#;", "all") />
        <cfset email = replace(email, "u", "&###asc('u')#;", "all") />
        <cfset email = replace(email, "v", "&###asc('v')#;", "all") />
        <cfset email = replace(email, "w", "&###asc('w')#;", "all") />
        <cfset email = replace(email, "x", "&###asc('x')#;", "all") />
        <cfset email = replace(email, "y", "&###asc('y')#;", "all") />
        <cfset email = replace(email, "z", "&###asc('z')#;", "all") />
        <cfset email = replace(email, "A", "&###asc('A')#;", "all") />
        <cfset email = replace(email, "B", "&###asc('B')#;", "all") />
        <cfset email = replace(email, "C", "&###asc('C')#;", "all") />
        <cfset email = replace(email, "D", "&###asc('D')#;", "all") />
        <cfset email = replace(email, "E", "&###asc('E')#;", "all") />
        <cfset email = replace(email, "F", "&###asc('F')#;", "all") />
        <cfset email = replace(email, "G", "&###asc('G')#;", "all") />
        <cfset email = replace(email, "H", "&###asc('H')#;", "all") />
        <cfset email = replace(email, "I", "&###asc('I')#;", "all") />
        <cfset email = replace(email, "J", "&###asc('J')#;", "all") />
        <cfset email = replace(email, "K", "&###asc('K')#;", "all") />
        <cfset email = replace(email, "L", "&###asc('L')#;", "all") />
        <cfset email = replace(email, "M", "&###asc('m')#;", "all") />
        <cfset email = replace(email, "N", "&###asc('N')#;", "all") />
        <cfset email = replace(email, "O", "&###asc('O')#;", "all") />
        <cfset email = replace(email, "P", "&###asc('P')#;", "all") />
        <cfset email = replace(email, "Q", "&###asc('Q')#;", "all") />
        <cfset email = replace(email, "R", "&###asc('R')#;", "all") />
        <cfset email = replace(email, "S", "&###asc('S')#;", "all") />
        <cfset email = replace(email, "T", "&###asc('T')#;", "all") />
        <cfset email = replace(email, "U", "&###asc('U')#;", "all") />
        <cfset email = replace(email, "V", "&###asc('V')#;", "all") />
        <cfset email = replace(email, "W", "&###asc('W')#;", "all") />
        <cfset email = replace(email, "X", "&###asc('X')#;", "all") />
        <cfset email = replace(email, "Y", "&###asc('Y')#;", "all") />
        <cfset email = replace(email, "Z", "&###asc('Z')#;", "all") />
        <cfreturn email />
    </cffunction>
<!---
<cfif not gotrights("superadmin")>
<cferror type="EXCEPTION" template="errorpage.cfm">
</cfif>
--->