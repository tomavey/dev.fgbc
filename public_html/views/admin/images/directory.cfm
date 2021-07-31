<cfparam name="files" required="true">
<cfparam name="dirs" required="true">

<style>
.flex-container {
  display: flex;
  flex-wrap: wrap;
}

.flex-container > div {
  background-color: #f1f1f1;
  margin: 10px;
  text-align: center;
}
</style>
<div class="container">
<!--- <cfoutput>
#GetBaseTemplatePath()#<br/>

#GetCurrentTemplatePath()#<br/>

#GetDirectoryFromPath(GetCurrentTemplatePath())#<br/>

#ExpandPath("2019Council.jpg")#<br/>

#FileExists(GetCurrentTemplatePath())#

#getBaseUrl()#

</cfoutput> --->
  <cfscript>
    writeOutput('<a href="/?controller=admin.images&action=directory">root</a>&nbsp;|&nbsp;')
    for (dir in dirs ) {
      writeOutput('<a href="/?controller=admin.images&action=directory&folder=#dir#">#dir#</a>&nbsp;|&nbsp;')
    }
  </cfscript>
  <div class="flex-container">
    <cfscript>
      for (file in files) {
      fileUrl = "#getBaseUrl()#/images/#folderName#/#file#"
          writeOutput('
          <div>
            <p><a href="#fileurl#"><img src="#fileUrl#" width="200" /></a></p><br/>
            <p><a href="#fileurl#">#file#</a></p>
          </div>
       ')
     }
  </cfscript>
</div>
</div>