<!--- fbx_utils.cfm --->

<cfif isdefined("url.lock")>
	<cfset structDelete(session,"auth")>
	<cfset structDelete(cookie,"fgbcimagine")>
</cfif>

<cfif isdefined("cookie.fgbcimagine")>
    <cfset session.auth.natminproj = "yes">
	<cfset session.auth.email = cookie.fgbcimagine>
<cfelse>
	<cfif not isdefined("session.auth.natminproj") or not session.auth.natminproj>
    
        <cfif isdefined("url.key")>
            <cfset thisemail = getemailfromkey(url.key)>
            <cfquery datasource="#dsn#" name="data">
                SELECT s.staffid
                FROM staff_tags t
                JOIN staff s
                ON t.item_id = s.staffid
                WHERE s.email = "#thisemail#"
            </cfquery>
            
            <cfif data.recordcount>    
                <cfset session.auth.natminproj = "yes">
                <cfset session.auth.email = thisemail>
                <cfcookie name="fgbcimagine" value="#thisemail#" expires="never">	    
            <cfelse>
                <cflocation url="checkin.cfm">
            </cfif>
    
        <cfelse>    
            <cflocation url="checkin.cfm">
        </cfif>	
    
    </cfif>

</cfif>


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
   <cfset result = 'index.cfm?fuseaction=' & trim(p_fuseaction)>
   <cfreturn result>
 </cffunction>
 
 <cffunction name="getEmailFromKey" output="no">
	<cfargument name="key" required="yes" type="string">
	<cfset var email="">
	<cfset email = decrypt(arguments.key,Session.PasswordKey,"CFMX_COMPAT","Hex")>
    <cfreturn email>
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

<cffunction name="getkey" output="no">
<cfargument name="email" required="yes" type="string">
<cfset var key="">
	<cfset key = encrypt(arguments.email,Session.PasswordKey,"CFMX_COMPAT","Hex")>
    <cfreturn key>
</cffunction>

<!---cfif not gotrights("superadmin")>	
<cferror type="EXCEPTION" template="errorpage.cfm">
</cfif--->
