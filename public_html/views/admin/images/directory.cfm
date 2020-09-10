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

<ul>
  <div class="flex-container">
    <cfscript>
      for (file in files) {
      fileUrl = "https://charisfellowship.us/images/#file#"
          writeOutput('
          <div>
            <p><a href="#fileurl#"><img src="#fileUrl#" width="200" /></a></p><br/>
            <p><a href="#fileurl#">#file#</a></p>
          </div>
       ')
     }
  </cfscript>
</div>
</ul>
