 <!--- 
 Module:         fbx_Switch.cfm
 --->


 <CFSWITCH EXPRESSION = "#fusebox.fuseaction#">


 <CFCASE value="intro">   <!--- example entry --->
 	<cfset attribute.sectionheader = "Introduction">
   <cfinclude template="dsp_std_header.cfm">
   <cfinclude template="dsp_intro.cfm">
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="content">   <!--- example entry --->
 	<cfif not isdefined("url.id")>
		<cfset url.id = "20">
	</cfif>
   <cfinvoke component="control" method="get_content_natmin" returnvariable="content" id="#url.id#">
		<cfif isdefined("url.originalid")>
			<cfinvokeargument name="originalid" value="#url.originalid#">
		</cfif>
	</cfinvoke>	
	<cfinvoke component="control" method="get_content_natmin" returnvariable="history">
		<cfinvokeargument name="originalid" value="#url.id#">
		<cfinvokeargument name="SORTORDER" value="datetime"> 
		<cfinvokeargument name="direction" value="desc"> 
	</cfinvoke>
	<cfset attribute.sectionheader = content.name>
   <cfinclude template="dsp_std_header.cfm">
   <div id="content">
   <cfinclude template="dsp_contentpage.cfm">
   </div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>

 <CFCASE value="addnewcontent">
   <cfinclude template="dsp_std_header.cfm">
   <cfloop list="NAME,DESCRIPTION,PARAGRAPH,AUTHOR,SORTORDER,DATETIME" index="i">
		<cfparam name="form.#i#" default="">
	</cfloop>    
	<cfset xfa.formaction = "postnewcontent">
	<cfinvoke component="control" method="get_max_sortorder" returnvariable="maxsortorder" />
	<cfset form.sortorder = maxsortorder + 1>
	<div id="content">
   <cfinclude template="frm_content.cfm">
   	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>

 <CFCASE value="postnewcontent">
 	<cfinvoke component="control" method="put_content_natmin" argumentcollection="#form#" />
 	<cflocation url="#fbx('contenttable')#">
 </CFCASE>

 <CFCASE value="addnewpage">
 	<cfset attribute.sectionheader = "Add a new page">
   <cfinclude template="dsp_std_header.cfm">
   <cfloop list="NAME,DESCRIPTION,PARAGRAPH,AUTHOR,SORTORDER,DATETIME" index="i">
		<cfparam name="form.#i#" default="">
	</cfloop>    
	<cfset xfa.formaction = "postnewpage">
	<cfinvoke component="control" method="get_max_sortorder" returnvariable="maxsortorder" />
	<cfset form.sortorder = maxsortorder + 1>
	<div id="content">
   <cfinclude template="frm_content.cfm">
   	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>

 <CFCASE value="postnewpage">
 	<cfset form.name = form.description>
 	<cfinvoke component="control" method="put_content_natmin" argumentcollection="#form#" returnvariable="lastid" />
 	<cflocation url="#fbx('content')#&id=#lastid#">
 </CFCASE>
 
 <CFCASE value="deletecontent">
 	<cfinvoke component="control" method="delete_content_natmin" id="#url.id#" />
	<cflocation url="#fbx('contenttable')#"> 
 </CFCASE>

 <CFCASE value="contenttable">   <!--- example entry --->
  	<cfset attribute.sectionheader = "Content Table">
   <cfinclude template="dsp_std_header.cfm">
	<cfinvoke component="control" method="get_content_natmin" returnvariable="content" />
	<div id="content">
	<cfinclude template="dsp_content.cfm">
   	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="editcontent">
  	<cfset attribute.sectionheader = "Edit Content">
   <cfinclude template="dsp_std_header.cfm">
   <cfinvoke component="control" method="get_content_natmin" id='#url.id#' returnvariable="data" />
	<cfloop list="#data.columnlist#" index="i">
		<cfset form[i] = data[i]>
	</cfloop>
	<cfset xfa.formaction = "updatecontent">
	<div id="editcontent">
   <cfinclude template="frm_content.cfm">
   	</div>
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="updatecontent">
 	<cfset form.name = form.description>
 	<cfinvoke component="control" method="update_content_natmin" argumentcollection="#form#" id='#form.id#' />
 	<cflocation url="#fbx('content')#&id=#form.id#">
 </CFCASE>
 
 <CFCASE value="abstracts">
  	<cfset attribute.sectionheader = "Documents and Downloads">
   <cfinclude template="dsp_std_header.cfm">
   <cfloop list="FILENAME,DESCRIPTION,DATETIME,RIGHTS,AUTHOR,SORTORDER" index="i">
		<cfparam name="form.#i#" default="">
	</cfloop> 
	<cfset xfa.formaction = "postdocumentupload">
   <cfinclude template="frm_documentupload.cfm">
   <cfinvoke component="control" method="get_content_documents" returnvariable="documents"/>
   	<div id="content">
   		<cfinclude template="dsp_documents.cfm">
	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>

 <CFCASE value="video">
  	<cfset attribute.sectionheader = "Video Chat">
   <cfinclude template="dsp_std_header.cfm">
   	<div id="content" class="video">
<object type="application/x-shockwave-flash" data="http://www.tokbox.com/vc/i1am8xme4idrve2a" width="300" height="300" pid="494a7dae75f718d6"> <param name="movie" value="http://www.tokbox.com/vc/i1am8xme4idrve2a"/> <param name="allowFullScreen" value="true"/> <param name="flashvars" value="guestList=true&textChat=true"/></object>
	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="teams">
  	<cfset attribute.sectionheader = "Teams">
   <cfinclude template="dsp_std_header.cfm">
   <div id="content">
   <cfinclude template="dsp_teams.cfm">
   </div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="editdocument">
   <cfinclude template="dsp_std_header.cfm">
   <cfinvoke component="control" method="get_content_documents" id='#url.id#' returnvariable="data" />
   	<cfloop list="#data.columnlist#" index = "i">
		<cfset form[i] = data[i]>
	</cfloop>	
	<cfset xfa.formaction = "postdocumentupdate">
	<div id="content">
   <cfinclude template="frm_documentupload.cfm">
   	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>

 <CFCASE value="postdocumentupload">
 	<cfinvoke component="control" method="put_content_documents" argumentcollection="#form#"/>
	<cflocation url="#fbx('abstracts')#">
 </CFCASE>
 
 <CFCASE value="postdocumentupdate">
 	<cfinvoke component="control" method="update_content_documents" argumentcollection="#form#"/>
	<cflocation url="#fbx('abstracts')#">
 </CFCASE>
 
 <CFCASE value="deletedocument">
 	<cfinvoke component="control" method="delete_content_documents" id="#url.id#">
	<cflocation url="#fbx('abstracts')#">
 </CFCASE>
 
 <CFCASE value="whiteboard">
  	<cfset attribute.sectionheader = "White Board">
   <cfinclude template="dsp_std_header.cfm">
   <cfinvoke component="control" method="get_content_natmin" id='5' returnvariable="data" />
   <cfset form = data>
	<cfset xfa.formaction = "postcontentupdate">
	<div id="content"><cfoutput>
	<cfform action="#fbx('editwhiteboard')#" id="editbutton"><cfinput type="submit" name="submit" value="Edit This Page"></cfform>
	#data.paragraph#</cfoutput>
   	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="editwhiteboard">
  	<cfset attribute.sectionheader = "Edit White Board">
   <cfinclude template="dsp_std_header.cfm">
   <cfinvoke component="control" method="get_content_natmin" id='5' returnvariable="data" />
   <cfset xfa.formaction = "updatewhiteboard">
   <div id="content">
   <table>
   <tr>
   <td class="aligncenter">
   <cfform action="#fbx(xfa.formaction)#" method="post">
   <cfinput type="hidden" name="author" value="#session.auth.email#">
   <cfinput type="hidden" name="description" value="#data.description#">
   <cfinput type="hidden" name="id" value="#data.id#">
   <cfinput type="hidden" name="name" value="#data.name#">
   <cfinput type="hidden" name="sortorder" value="#data.sortorder#">
   <textarea name="paragraph" rows="5" cols="80" id="wysiwyg"><cfoutput>#data.paragraph#</cfoutput></textarea>
   <cfinput type="submit" name="submit" value="Submit">
   </cfform>
   </td>
   </tr>
   </table>
   </div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>
 
 <CFCASE value="updatewhiteboard">
 	<cfinvoke component="control" method="update_content_natmin" argumentcollection='#form#' />
	<cflocation url="#fbx('whiteboard')#"> 
 </CFCASE>
 
 <CFCASE value="getstaff">
  	<cfset attribute.sectionheader = "Staff Information for #form.searchby#">
   <cfinclude template="dsp_std_header.cfm">
 	<cfinvoke component="control" method="get_staff" argumentcollection="#form#" returnvariable="staffdata" />
	<div id="content">
		<cfinclude template="dsp_staffinfo.cfm">
	</div>
   <cfinclude template="dsp_std_navigation.cfm">
   <cfinclude template="dsp_std_extra.cfm">
   <cfinclude template="dsp_std_footer.cfm">
 </CFCASE>


 
 <CFDEFAULTCASE>
   <!---This will just display an error message and is 
   useful in catching typos of fuseaction names while 
   developing--->
   <CFOUTPUT> 
      <li>Received UNDEFINED fuse-action called 
      "#fusebox.fuseaction#"  &nbsp; Please notify information services.
	  <!--- custom stuff --->
	  <hr>
	  <a href="#fbxUrl('intro')#">Launch Main Page</a>
	  <!--- end custom stuff --->
   </CFOUTPUT>
 </CFDEFAULTCASE>


 </CFSWITCH>


