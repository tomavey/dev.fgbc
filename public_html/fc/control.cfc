<cfcomponent>

<cfset dsn = "fgbc_main_3">

	<cffunction name="myFunction" access="public" returntype="string">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>

<cffunction name="put_content_fc">
<cfargument name="NAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="PARAGRAPH" type="string">
<cfargument name="AUTHOR" type="string">
<cfargument name="SORTORDER" type="numeric">
<cfargument name="DATETIME" default='#now()#'>

	<cfquery datasource="#dsn#">
	      INSERT INTO content_fc
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
		FROM content_fc
	</cfquery>

<cfreturn data.id>
</cffunction>

<cfscript>
  private function hasParagraphChanged(required string oldPara, required string newPara){
      if (arguments.oldPara == arguments.newPara) { return false } 
      else { return true }       
  }    
</cfscript>


<cffunction name="update_content_fc">
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
		FROM content_fc
		WHERE id = #arguments.id#
      </cfquery>

   <cfif hasParagraphChanged(oldData.paragraph,arguments.PARAGRAPH)>

	<cfquery datasource="#dsn#">
	      INSERT INTO content_fc
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
            UPDATE content_fc
            SET
                  NAME = <cfqueryparam value='#arguments.NAME#' CFSQLType="CF_SQL_CHAR">,
                  DESCRIPTION = <cfqueryparam value='#arguments.DESCRIPTION#' CFSQLType="CF_SQL_CHAR">,
                  PARAGRAPH = <cfqueryparam value='#arguments.PARAGRAPH#' CFSQLType="CF_SQL_CHAR">,
                  AUTHOR = <cfqueryparam value='#arguments.AUTHOR#' CFSQLType="CF_SQL_CHAR">,
                  SORTORDER = <cfqueryparam value='#arguments.SORTORDER#' CFSQLType="CF_SQL_INTEGER">,
                  DATETIME = <cfqueryparam value='#arguments.DATETIME#' CFSQLType="CF_SQL_DATE">
            WHERE id = <cfqueryparam value='#form.id#' CFSQLType="CF_SQL_INTEGER">
      </cfquery>
   
   </cfif>

</cffunction>

<cffunction name="getAllContentFc">
      <cfquery datasource="#dsn#" name="data">
            SELECT *
            FROM content_fc 
      </cfquery>
      <cfreturn data>
</cffunction>

<cffunction name="get_content_fc">
<cfargument name="ID" type="numeric">
<cfargument name="originalID" type="numeric">
<cfargument name="NAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="PARAGRAPH" type="string">
<cfargument name="AUTHOR" type="string">
<cfargument name="SORTORDER" default="sortorder">
<cfargument name="DATETIME" default="#now()#">
<cfargument name="desc" default="no">
<cfargument name="selectString" default="*">
<cfargument name="asJson" default="no">
      <cfquery datasource="#dsn#" name="data">
            SELECT #selectString#
            FROM content_fc
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
			ORDER BY #arguments.sortorder# <cfif arguments.desc>desc</cfif>
      </cfquery>
      <cfif arguments.asJson>
            <cfset data = queryToJson(data)>
      </cfif>
<cfreturn data>
</cffunction>

<cffunction name="get_max_sortorder">
	<cfquery datasource="#dsn#" name="data">
		SELECT max(sortorder) as maxsortorder
		FROM content_fc
	</cfquery>
<cfreturn data.maxsortorder>
</cffunction>

<cffunction name="delete_content_fc">
<cfargument name="id" required="yes" type="numeric">
      <cfquery datasource="#dsn#">
            DELETE FROM content_fc
            WHERE id = <cfqueryparam value='#arguments.id#' CFSQLType='CF_SQL_INTEGER'>
            LIMIT 1
      </cfquery>
</cffunction>

<cffunction name="getstaffinfo">
<cfargument name="tag" required="Yes">
<cfargument name="asJson" default="false">
<cfargument name="selectString" default='s.id, fname, lname, concat(fname," ",lname) as selectname, email, phone, itemid'>
	<cfquery datasource="#dsn#" name="data">
		SELECT #selectString#
		FROM handbooktags t, handbookpeople s
		WHERE (tag = "#arguments.tag#") and (type = "person") and (t.itemid = s.id)
		AND t.deletedAt IS NULL
		ORDER BY lname
	</cfquery>
      <cfif arguments.asJson>
            <cfset data = queryToJson(data)>
      </cfif>
<cfreturn data>
</cffunction>

<cffunction name="put_content_documents">
<cfargument name="FILENAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="DATETIME" default="#now()#">
<cfargument name="RIGHTS" type="string">
<cfargument name="AUTHOR" default="#session.auth.email#">
<cfargument name="tag" default="fellowshipcouncil">
<cfargument name="documentsLocation" default="">

<!---get highest sortorder number--->
<cfquery datasource="#dsn#" name="sortorder">
	SELECT max(sortorder) as sortorder
	FROM content_documents
</cfquery>

<!---Set sortorder to one higher--->
<cfset arguments.sortorder = val(sortorder.sortorder) +1>

<cfset arguments.documentsLocation = replace(cgi.cf_template_path,"index.cfm","")>
<cfset arguments.documentsLocation = arguments.documentsLocation & "documents">

<!---upload file--->
<cffile action = "upload"
          fileField = 'filename'
          destination="#arguments.documentsLocation#"
          accept = "text/html, application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf, application/vnd.msword, application/vnd.ms-excel, application/msexcel, application/unknown, application/x-octet-stream,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          nameconflict="overwrite">

<center><h2>This type of file cannot be uploaded. Use your browser's back-button to try again or contact <a href="mailto:tomavey@fgbc.org">tomavey@fgbc.org</a> if you need assistance.</h2></center>

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
<cfreturn arguments.docid>
</cffunction>

<cffunction name="get_content_documents">
<cfargument name="ID" type="numeric">
<cfargument name="FILENAME" type="string">
<cfargument name="DESCRIPTION" type="string">
<cfargument name="DATETIME" type="date">
<cfargument name="RIGHTS" type="string">
<cfargument name="SORTORDER" default="content_documents.datetime ASC">
<cfargument name="tag" default="fellowshipcouncil">
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
          destination="/home/fgbcalur/public_html/fc/documents/"
          accept = "text/html, application/msword,  application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/pdf, application/vnd.msword, application/vnd.ms-excel, application/msexcel, application/unknown"
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

<cffunction name="get_staff_email">
<cfargument name="STAFFID" type="numeric">
<cfset var loc=structNew()>
      <cfquery datasource="#dsn#" name="loc.data">
            SELECT email
            FROM handbookpeople
            WHERE id = #arguments.STAFFID#
      </cfquery>
      <cfreturn loc.data>
</cffunction>

<cffunction name="get_staff">
<cfargument name="STAFFID" type="numeric">
<cfargument name="searchby" type="string">
<cfargument name="LNAME" type="string">

      <cfquery datasource="#dsn#" name="data">
            SELECT s.lname, s.fname, s.address1, s.address2, s.city, st.state, s.zip, s.email, s.phone, c.name as cname, c.address1 as caddress1, c.address2 as caddress2, c.city as ccity, st.state as cstate, c.zip as czip, c.email as cemail, c.phone as cphone
            FROM staff s, church c, state st
            WHERE s.churchid = c.churchid and s.stateid = st.stateid and c.stateid=st.stateid
            <cfif isdefined("arguments.STAFFID")>
                  AND STAFFID = <cfqueryparam value='#arguments.STAFFID#' CFSQLType='CF_SQL_INTEGER'>
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

<cffunction name="getcommission">
<cfargument name="tag" required="Yes">
	<cfquery datasource="#dsn#" name="tag_staff">
		SELECT t.itemid, t.id, s.lname, s.fname, s.email, s.phone, s.phone2, s.id as personid
		FROM handbooktags t, handbookpeople s
		WHERE (tag = "#arguments.tag#") and (type = "person") and (t.itemid = s.id)
		<cfif isdefined('url.username')>and username = '#url.username#'</cfif>
		and t.deletedAt IS NULL
		GROUP BY itemid
		ORDER BY lname
	</cfquery>
<cfreturn tag_staff>
</cffunction>

<cffunction name="queryToJson">
<cfargument name="Data" type="query" required="yes" />
<cfset var loc = structNew()>
<cfset loc.columnnames = data.columnList>
<cfset loc.jsonObject = "[">
      <cftry>
      <cfoutput query="data">
            <cfset loc.thisitem = "{">
            <cfloop list="#loc.columnNames#" index="loc.i">
                  <cfset loc.thisdata = '"#escapeString(data[loc.i])#"'>
                  <cfset loc.thisitem = loc.thisitem & '"' & lcase(loc.i) & '"' & ":" & loc.thisdata & ",">
            </cfloop>
            <cfset loc.thisitem = left(loc.thisitem,len(loc.thisitem)-1) & "},">
            <cfset loc.jsonObject = loc.jsonObject & loc.thisitem>
      </cfoutput>
      <cfset loc.jsonObject = left(loc.jsonObject,Len(loc.jsonObject)-1)>
      <cfcatch></cfcatch></cftry>
      <cfset loc.jsonObject = loc.jsonObject & "]">
      <cfreturn loc.jsonObject>
</cffunction>

<cffunction name="escapeString">
<cfargument name="string" required="true">
<cfset var loc = structNew()>
      <cfset loc.return =  arguments.string>
      <cfset loc.return = replace(loc.return,"&quot;", "'", "ALL")>
      <cfset loc.return = REReplace(loc.return,chr(34),"'","ALL")>
      <cfset loc.return = REReplace(loc.return, "\r\n|\n\r|\n|\r", "<br/>", "all")>
      <cfreturn loc.return>
</cffunction>

<cffunction name="isFCMember">
<cfargument name="email" required="true">
<cfset var loc = arguments>
      <cfset staff = getstaffinfo(tag="fc")>
      <cfloop query="staff">
            <cfif staff.email is loc.email>
                  <cfreturn true>
            </cfif>      
      </cfloop>
      <cfreturn false>
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
            first 6 characters as our CAPTCHA text string.
      --->
      <cfset strCaptcha = (
            arrValidChars[ 1 ] &
            arrValidChars[ 2 ] &
            arrValidChars[ 3 ]
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
                  <cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="high" fonts="verdana,arial,times new roman,courier" fontsize="28" /><br />
                              Enter text from this image.&nbsp;<cfinput type="text" name="captcha" value="" id="captcha">
 <!---
                  <p>Last name of current executive director of the FGBC: <cfinput type="text" name="execdir"></p>
 --->
                  <cfinput type="submit" value="#arguments.text#" name="submit">
            </cfform>
      </cfsavecontent>

      <cfreturn captchaForm>

</cffunction>


</cfcomponent>
