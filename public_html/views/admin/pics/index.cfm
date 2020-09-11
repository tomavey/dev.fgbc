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
      writeOutput('#linkto(text=dir, controller="admin/pics", params="folder=#dir#")#&nbsp;|&nbsp;')
    }
  </cfscript>
  <div class="flex-container">
    <cfscript>
      // ddd(files)
      for (file in files) {
      fileUrl = "#getBaseUrl()#/images/#folderName#/#file.name#"
          writeOutput('
          <div>
            <p><a href="#fileurl#"><img src="#fileUrl#" width="200" /></a></p><br/>
            <p><a href="#fileurl#">#file.name#</a></p>
          </div>
       ')
     }
  </cfscript>
</div>
</div>

