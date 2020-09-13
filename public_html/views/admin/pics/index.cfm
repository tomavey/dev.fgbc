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
  <div class="flex-container app">
    <div v-for="pic in pics">
      <a :href=pathToImage(pic.name) v-html=pathToImage(pic.name)></a>
    </div>
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

<script>
    var vm = new Vue({
      el: ".app",
      data() {
        return {
          message: "welcome",
          pics: "pics",
          picDir: "/images/",
        }
      },
      methods: {
        pathToImage: function(name) {
          return this.picsDir + name
        },
      },
      computed: {
        pathName: function(){ return window.location.pathname },
        hostName: function(){ return window.location.hostname },
        protocol: function(){ return window.location.protocol },
        picsDir: function(){ return this.protocol + "//" + this.hostName + ":" + this.port + this.picDir},
        port: function(){ return window.location.port }
      },
      created(){
        let self = this
        this.files = axios.get('http://127.0.0.1:8000/api/pics').then(function( response ) {
          self.pics = response.data
          console.log(self.pics )
        })
      }
    })
</script>

