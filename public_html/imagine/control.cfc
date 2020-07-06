<cfcomponent>

<cfset dsn = "fgbc_main_3">
	
	<cffunction name="myFunction" access="public" returntype="string">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>
	
<cffunction name="put_content_natmin">
<cfargument name="NAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="PARAGRAPH" type="string">
<cfargument name="AUTHOR" type="string">
<cfargument name="SORTORDER" type="numeric">
<cfargument name="DATETIME" default='#now()#'>

	<cfquery datasource="#dsn#">
	      INSERT INTO content_natmin
	            ( NAME,DESCRIPTION,PARAGRAPH,AUTHOR,SORTORDER,DATETIME )
	      VALUES (
	            <cfqueryparam value='#arguments.NAME#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#arguments.PARAGRAPH#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#arguments.AUTHOR#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#arguments.SORTORDER#' CFSQLType="CF_SQL_INTEGER">,
	            <cfqueryparam value='#arguments.DATETIME#' CFSQLType="CF_SQL_DATE">
	            )
	</cfquery>
	
	<cfquery datasource="#dsn#" name="data">
		SELECT max(id) as id
		FROM content_natmin
	</cfquery>
	
<cfreturn data.id>	
</cffunction>

<cffunction name="update_content_natmin">
<cfargument name="NAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="PARAGRAPH" type="string">
<cfargument name="AUTHOR" type="string">
<cfargument name="SORTORDER" type="numeric">
<cfargument name="DATETIME" default="#now()#">
<cfargument name="id" type="numeric">

<!---Create a history by copying current record---> 
	<cfquery datasource="#dsn#" name="olddata">	
		SELECT *
		FROM content_natmin		
		WHERE id = #arguments.id#
	</cfquery>
	<cfquery datasource="#dsn#">
	      INSERT INTO content_natmin
	            ( ORIGINALID, NAME,DESCRIPTION,PARAGRAPH,AUTHOR,SORTORDER,DATETIME )
	      VALUES (
	            <cfqueryparam value='#arguments.id#' CFSQLType="CF_SQL_INTEGER">,
	            <cfqueryparam value='#olddata.NAME#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#olddata.DESCRIPTION#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#olddata.PARAGRAPH#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#olddata.AUTHOR#' CFSQLType="CF_SQL_CHAR">,
	            <cfqueryparam value='#olddata.SORTORDER#' CFSQLType="CF_SQL_INTEGER">,
	            <cfqueryparam value='#olddata.DATETIME#' CFSQLType="CF_SQL_DATE">
	            )
	</cfquery>

      <cfquery datasource="#dsn#">
            UPDATE content_natmin
            SET
                  NAME = <cfqueryparam value='#arguments.NAME#' CFSQLType="CF_SQL_CHAR">,
                  DESCRIPTION = <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType="CF_SQL_CHAR">,
                  PARAGRAPH = <cfqueryparam value='#arguments.PARAGRAPH#' CFSQLType="CF_SQL_CHAR">,
                  AUTHOR = <cfqueryparam value='#arguments.AUTHOR#' CFSQLType="CF_SQL_CHAR">,
                  SORTORDER = <cfqueryparam value='#arguments.SORTORDER#' CFSQLType="CF_SQL_INTEGER">,
                  DATETIME = <cfqueryparam value='#arguments.DATETIME#' CFSQLType="CF_SQL_DATE">
            WHERE id = <cfqueryparam value='#form.id#' CFSQLType="CF_SQL_INTEGER">
      </cfquery>
</cffunction>

<cffunction name="get_content_natmin">
<cfargument name="ID" type="numeric">
<cfargument name="originalID" type="numeric">
<cfargument name="NAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="PARAGRAPH" type="string">
<cfargument name="AUTHOR" type="string">
<cfargument name="SORTORDER" default="sortorder">
      <cfquery datasource="#dsn#" name="data">
            SELECT *
            FROM content_natmin
            WHERE 0=0
			<cfif isdefined("arguments.originalid")>
				AND originalid = <cfqueryparam value='#arguments.originalID#' CFSQLType='CF_SQL_INTEGER'>
			<cfelse>
				AND originalId = ""
			</cfif>	
            <cfif isdefined("arguments.ID")>
                  AND ID = <cfqueryparam value='#arguments.ID#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.NAME")>
                  AND NAME = <cfqueryparam value='#arguments.NAME#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.DESCRIPTION")>
                  AND DESCRIPTION = <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.PARAGRAPH")>
                  AND PARAGRAPH = <cfqueryparam value='#arguments.PARAGRAPH#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.AUTHOR")>
                  AND AUTHOR = <cfqueryparam value='#arguments.AUTHOR#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
			ORDER BY '#arguments.sortorder#'
      </cfquery>
<cfreturn data>
</cffunction>

<cffunction name="get_max_sortorder">
	<cfquery datasource="#dsn#" name="data">
		SELECT max(sortorder) as maxsortorder
		FROM content_natmin
	</cfquery>
<cfreturn data.maxsortorder>
</cffunction>
	
<cffunction name="delete_content_natmin">
<cfargument name="id" required="yes" type="numeric">
      <cfquery datasource="#dsn#">
            DELETE FROM content_natmin
            WHERE id = <cfqueryparam value='#arguments.id#' CFSQLType='CF_SQL_INTEGER'>
            LIMIT 1
      </cfquery>
</cffunction> 

<cffunction name="getstaffinfo">
<cfargument name="tag" required="Yes">
<cfargument name="sortby" default="lname">
	<cfquery datasource="#dsn#" name="tags">
		SELECT *
		FROM handbooktags t, handbookpeople s
		WHERE (tag = "#arguments.tag#") and (type = "person") and (t.itemid = s.id) and (t.deletedAt IS NULL) 
		ORDER BY '#arguments.sortby#'
	</cfquery>
<cfreturn tags>	
</cffunction>

<cffunction name="put_content_documents">
<cfargument name="FILENAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="DATETIME" default="#now()#">
<cfargument name="RIGHTS" type="string">
<cfargument name="AUTHOR" default="#session.auth.email#">
<cfargument name="tag" default="natminproj">

<!---get highest sortorder number--->
<cfquery datasource="#dsn#" name="sortorder">
	SELECT max(sortorder) as sortorder
	FROM content_documents
</cfquery>

<!---Set sortorder to one higher--->
<cfset arguments.sortorder = val(sortorder.sortorder) +1>	

<!---upload file--->
<cftry>
<cffile action = "upload" 
          fileField = 'filename' 
          destination="/home/fgbcalur/public_html/docs/"
          accept = "text/html, application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf, application/vnd.msword, application/vnd.ms-excel, application/msexcel, application/unknown"
          nameconflict="overwrite">
<cfcatch type="Any">
<center><h2>This type of file cannot be uploaded. Use your browser's back-button to try again or contact <a href="mailto:tomavey@fgbc.org">tomavey@fgbc.org</a> if you need assistance.</h2></center>		  
<cfabort>
</cfcatch>
</cftry>
		  
<!---Put data into table--->
<cfquery datasource="#dsn#">
      INSERT INTO content_documents
            ( FILENAME,DESCRIPTION,DATETIME,RIGHTS,AUTHOR,SORTORDER )
      VALUES (
            <cfqueryparam value='#cffile.CLIENTFILE#' CFSQLType="CF_SQL_CHAR">,
            <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType="CF_SQL_CHAR">,
            <cfqueryparam value='#arguments.DATETIME#' CFSQLType="CF_SQL_DATE">,
            <cfqueryparam value='#arguments.RIGHTS#' CFSQLType="CF_SQL_CHAR">,
            <cfqueryparam value='#arguments.AUTHOR#' CFSQLType="CF_SQL_CHAR">,
            <cfqueryparam value='#arguments.SORTORDER#' CFSQLType="CF_SQL_INTEGER">
            )
</cfquery>

<!---get this document id--->
<cfquery datasource="#dsn#" name="data">
	SELECT max(id) as id
	FROM content_documents
</cfquery>
<cfset arguments.docid = data.id>	

<!---Create tag--->
<cfquery datasource="#dsn#">
      INSERT INTO content_documents_tags
            ( NAME,DOCID,DATETIME )
      VALUES (
            <cfqueryparam value='#arguments.tag#' CFSQLType="CF_SQL_CHAR">,
            <cfqueryparam value='#arguments.DOCID#' CFSQLType="CF_SQL_INTEGER">,
            <cfqueryparam value='#arguments.DATETIME#' CFSQLType="CF_SQL_DATE">
            )
</cfquery>
</cffunction> 

<cffunction name="get_content_documents">
<cfargument name="ID" type="numeric">
<cfargument name="FILENAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="DATETIME" type="date">
<cfargument name="RIGHTS" type="string">
<cfargument name="SORTORDER" default="sortorder DESC">
<cfargument name="tag" default="natminproj">

      <cfquery datasource="#dsn#" name="data">
            SELECT *
            FROM content_documents, content_documents_tags
            WHERE 0=0
				AND content_documents.id = content_documents_tags.docid
				AND content_documents_tags.name = '#arguments.tag#'
            <cfif isdefined("arguments.ID")>
                  AND content_documents.ID = <cfqueryparam value='#arguments.ID#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
            <cfif isdefined("arguments.FILENAME")>
                  AND FILENAME = <cfqueryparam value='#arguments.FILENAME#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.DESCRIPTION")>
                  AND DESCRIPTION = <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.RIGHTS")>
                  AND RIGHTS = <cfqueryparam value='#arguments.RIGHTS#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
            <cfif isdefined("arguments.AUTHOR")>
                  AND AUTHOR = <cfqueryparam value='#arguments.AUTHOR#' CFSQLType='CF_SQL_CHAR'>
            </cfif>
			ORDER BY #arguments.sortorder#
      </cfquery>
<cfreturn data>
</cffunction> 

<cffunction name="update_content_documents">
<cfargument name="FILENAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="DATETIME" default="#now()#">
<cfargument name="RIGHTS" type="string">
<cfargument name="AUTHOR" default="#session.auth.email#">
<cfargument name="SORTORDER" type="numeric">

<!---upload file--->
<cffile action = "upload" 
          fileField = 'filename' 
          destination="/var/chroot/home/content/t/o/m/tomavey/html/docs/"
          accept = "text/html, application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf, application/vnd.msword, application/vnd.ms-excel, application/msexcel"
          nameconflict="overwrite">

      <cfquery datasource="#dsn#">
            UPDATE content_documents
            SET
                  FILENAME = <cfqueryparam value='#cffile.CLIENTFILE#' CFSQLType="CF_SQL_CHAR">,
                  DESCRIPTION = <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType="CF_SQL_CHAR">,
                  DATETIME = <cfqueryparam value='#arguments.DATETIME#' CFSQLType="CF_SQL_DATE">,
                  RIGHTS = <cfqueryparam value='#arguments.RIGHTS#' CFSQLType="CF_SQL_CHAR">,
                  AUTHOR = <cfqueryparam value='#arguments.AUTHOR#' CFSQLType="CF_SQL_CHAR">,
                  SORTORDER = <cfqueryparam value='#arguments.SORTORDER#' CFSQLType="CF_SQL_INTEGER">
            WHERE id = <cfqueryparam value='#form.id#' CFSQLType="CF_SQL_INTEGER">
      </cfquery>
</cffunction> 

<cffunction name="delete_content_documents">
<cfargument name="id" required="yes" type="numeric">
      <cfquery datasource="#dsn#">
            DELETE FROM content_documents
            WHERE id = <cfqueryparam value='#arguments.id#' CFSQLType='CF_SQL_INTEGER'>
            LIMIT 1
      </cfquery>
</cffunction> 

<cffunction name="get_staff">
<cfargument name="STAFFID" type="numeric">
<cfargument name="searchby" type="string">
<cfargument name="LNAME" type="string">

      <cfquery datasource="#dsn#" name="data">
            SELECT s.lname, s.fname, s.address1, s.address2, s.city, st.state, s.zip, s.email, s.phone, c.name as cname, c.address1 as caddress1, c.address2 as caddress2, c.org_city as ccity, st.state as cstate, c.zip as czip, c.email as cemail, c.phone as cphone 
            FROM handbookpeople s, handbookorganizations c, handbookstates st
            WHERE s.churchid = c.id and s.stateid = st.id and c.stateid=st.id
            <cfif isdefined("arguments.STAFFID")>
                  AND s.ID = <cfqueryparam value='#arguments.STAFFID#' CFSQLType='CF_SQL_INTEGER'>
            </cfif>
			<cfif isdefined("arguments.searchby")>
					AND
					(lname = <cfqueryparam value='#arguments.searchby#' CFSQLType='CF_SQL_CHAR'>
					OR
					fname = <cfqueryparam value='#arguments.searchby#' CFSQLType='CF_SQL_CHAR'>)
			</cfif>		
			ORDER BY lname		
      </cfquery>
<cfreturn data>
</cffunction> 		

<cffunction name="getteam">
<cfargument name="tag" required="Yes">
	<cfquery datasource="#dsn#" name="tag_staff">
		SELECT t.itemid, t.id, s.lname, s.fname, s.email, s.phone, s.phone2
		FROM handbooktags t, handbookpeople s
		WHERE (tag = "#arguments.tag#") and (type = "person") and (t.itemid = s.id)
		<cfif isdefined('url.username')>and username = '#url.username#'</cfif>
		GROUP BY itemid
		ORDER BY lname
	</cfquery>
<cfreturn tag_staff>
</cffunction>

<cffunction name="getCaptcha" output="no">
<cfargument name="text" default="Submit"> 
<cfargument name="action" required="true">
<cfset var arrValidChars = "">
<cfset var strCaptcha = arraynew(1)>
<cfset var captchaForm = "">
      <!---
            Create the array of valid characters. Leave out the
            numbers 0 (zero) and 1 (one) as they can be easily
            confused with the characters o and l (respectively).
      --->
      <cfset arrValidChars = ListToArray(
            "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
            "2,3,4,5,6,7,8,9"
            ) />
 
      <!--- Now, shuffle the array. --->
      <cfset CreateObject(
            "java",
            "java.util.Collections"
            ).Shuffle(
                  arrValidChars
                  )
            />
 
      <!---
            Now that we have a shuffled array, let's grab the
            first 4 characters as our CAPTCHA text string.
      --->
      <cfset strCaptcha = (
            arrValidChars[ 1 ] &
            arrValidChars[ 2 ] &
            arrValidChars[ 3 ] &
            arrValidChars[ 4 ] &
            arrValidChars[ 5 ] 
            ) />
 
      <cfsavecontent variable="captchaForm">
            <!---
            <cfif flashKeyExists("error")>
                  <div class="errorMessage">
                        <cfoutput>#flash("error")#</cfoutput>(<a href="##" onclick="alert('Automatic web crawlers are accessing these forms without our permission and causing errors for legitimate users and extra work for the FGBC office. By asking for the text from this image we can stop 95% of these troublesome queries.')">Why?</a>)
                  </div>
            </cfif>
            --->
            <cfform action="captcha.cfm">
                  <cfinput type="hidden" name="captcha_check" value="#encrypt(strCaptcha,'fellowshipcouncil','CFMX_COMPAT','Hex')#">
                  <cfinput type="hidden" name="id" value="#url.id#">
                  <cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="medium" fonts="verdana,arial,times new roman,courier" fontsize="28" /><br />
                              Enter text from this image.&nbsp;<cfinput type="text" name="captcha" value="" id="captcha">
                  <cfinput type="submit" value="#arguments.text#" name="submit">                
            </cfform>               
      </cfsavecontent>
      
      <cfreturn captchaForm>              

</cffunction>

	
</cfcomponent>
