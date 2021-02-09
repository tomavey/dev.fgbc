<cfparam name="formController" default="admin.pics">
<cfparam name="formAction" default="uploadPic">

<div class="container">
  <h2>
    <cfoutput>
      #formController#
      #startFormTag(controller=formController, action=formAction, multipart=true)#
      #fileFieldTag(name="fileContents", label="file to upload")#
      #submitTag()#
      #endFormTag()#
    </cfoutput>
    <!--- Upload coming ... under development! --->
  </h2>
</div>
