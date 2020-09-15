<cfparam name="files" required="true">
<cfparam name="dirs" required="true">
<cfparam name="params.folder" default="">

<style>
.flex-container {
  display: flex;
  flex-wrap: wrap;
}

.flex-container > div {
  background-color: #f1f1f1;
  margin: 10px;
  text-align: center;
  width:30%
}
.pointer {
  cursor: pointer
}
</style>


<div class="container">

  <cfscript>
    ddd(files)
    writeOutput('#linkto(text="Upload a pic", controller="admin.pics", action="upload", class="btn")#<br/>')
    writeOutput('<a href="/admin/pics/">root</a>&nbsp;|&nbsp;')
    for (dir in dirs ) {
      if ( isDefined("params.folder") ) { dir = "#params.folder#/#dir#/" }
      writeOutput('#linkto(text=dir, controller="admin.pics", action="index", params="folder=#dir#")#&nbsp;|&nbsp;')
    }
  </cfscript>

<div class="app">

  <div class="flex-container">
    <div>
      <input name="searchString" v-model="searchString" placeholder="Search"/>
    </div>
    <div>
      <p>Sorted by {{sortBy}}</p>
    </div>
    <div>
      <p v-for="sortOption in sortOptions">
        <span @click="setSortBy(sortOption)"  class="pointer">{{sortOption}}&nbsp;|&nbsp;</span>
      </p>
    </div>
  </div>  
  <div class="flex-container">
    <div v-for="pic in sortedFilteredPics" :key=pic.name>
    <p v-html=pic.name></p>
    <p><a :href=pathToImage(pic.name)><img :src=pathToImage(pic.name) :width=imgWidth /></a></p>
  </div>
</div>

</div>


<script>
  <cfoutput>
    var pics = #queryToJson(files)#
    var folder = "#params.folder#"
  </cfoutput>  
    var vm = new Vue({
      el: ".app",
      data() {
        return {
          message: "welcome",
          pics: pics,
          picDir: "/images/",
          searchString:"",
          sortBy: "name",
          sortOptions: ["name","dateLastModified","size"],
          sortOrder: "asc",
          imgWidth: 200,
          folder: folder,
        }
      },
      methods: {
        pathToImage: function(name) {
          return (
            (!this.folder.length) ? (this.picsDir + name) : (this.picsDir + folder + '/' + name)
            )
        },
        setSortBy: function(sortOption){
          this.sortBy = sortOption
        },  
        compareValues: function(key, order=this.sortOrder) {
          return function(a, b) {
            if(!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
            // property doesn't exist on either object
                return 0; 
            }

            const varA = (typeof a[key] === 'string') ? 
            a[key].toUpperCase() : a[key];
            const varB = (typeof b[key] === 'string') ? 
            b[key].toUpperCase() : b[key];

            let comparison = 0;
            if (varA > varB) {
            comparison = 1;
            } else if (varA < varB) {
            comparison = -1;
            }
            return (
            (order == 'desc') ? (comparison * -1) : comparison
            );
          };
        },
      },
      computed: {
        hostName: () => window.location.hostname,
        protocol: () => window.location.protocol,
        port: () => window.location.port,
        picsDir: function(){ return this.protocol + "//" + this.hostName + ":" + this.port + this.picDir},
        filteredPics: function() {
          let self = this
          if ( !self.searchString.length ) { return this.pics }
          let filteredPics = self.pics.filter( function(el) { 
            if (el.name.toLowerCase().includes(self.searchString.toLowerCase())){
              return true
            }
            return false
           })
           return filteredPics
        },
        sortedFilteredPics: function(){ return this.filteredPics.sort(this.compareValues(this.sortBy))
        },
      },
      created(){
      }
    })
</script>
