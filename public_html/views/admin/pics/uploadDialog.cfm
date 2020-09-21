<div class="container">
  <h2>
    <cfoutput>
      #startFormTag(controller="admin.pics", action="uploadPic", multipart=true)#
      #putFormTag()#
      #fileFieldTag(name="fileContents", label="file to upload")#
      #submitTag()#
      #endFormTag()#
    </cfoutput>
    Upload coming ... under development!
  </h2>
</div>
