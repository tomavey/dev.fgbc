<cfparam name="title" default="Churches and Campuses in the Charis Fellowship">

      <!-- Promo Block -->
    <section class="g-pos-rel">
      <div class="dzsparallaxer auto-init height-is-based-on-content use-loading mode-scroll" data-options='{direction: "reverse", settings_mode_oneelement_max_offset: "150"}'>
        <div class="divimage dzsparallaxer--target w-100 g-bg-cover g-bg-pos-top-center g-bg-img-hero g-bg-bluegray-opacity-0_2--after" style="height: 130%; background-image: url(../assets/img/extra-hero-image.jpg);"></div>

         <div class="container text-center g-py-130">
        <p class="g-color-white g-font-weight-600 g-font-size-35 text-uppercase"><cfoutput>#title#</cfoutput></p>
      </div>
      </div>
    </section>
    <!-- End Promo Block --> 
    
<p class="container card text-center"><a href="/handbook/" target="_new">Access the online handbook</a></p>
<div class="container card card-charis card-charis-square text-center">
<cfoutput query="churches" group="state">
    <h2>#state#</h2>
    <cfoutput>
    <p class="card">
      <h4>#name#</h4>
      <cfif len(address1)>
        #address1#<br/>
      </cfif>  
      <cfif len(address2)>
        #address2#<br/>
      </cfif>  
      #org_city# #state# #zip#<br/>
      <cfif len(email)>
        #mailto(email)#<br/>
      </cfif>  
      <cfif len(phone)>
        #phone#
      </cfif>  
    </p>  
    </cfoutput>
</cfoutput>
</div>


<!---
<cfoutput>
  <div class="row-fluid well contentStart contentBg">
    <div class="span3">
    #includePartial(partial="states", selected="all", qStates=churchStates)#
  </div>
  <div class="span9">
    <h3 class="addBottomBorder">Church Directory</h3>
    <div class="row-fluid" style="background-color:##555; padding:5px; margin:5px 0 0 0;">
      <div class="span12">
        <input type="text" name="searchChurch" id="searchChurch" class="input-block-level" style="margin-bottom:0;" placeholder="Search for a Church (By State or Zip Code)">
      </div>
    </div>
    <div class="row-fluid" style="margin-top:25px;">
        <div class="span12">
          <div style="width:100%; height:400px;" id="map-canvas"></div>
        </div>
    </div>
    <h3 style="border-bottom:2px solid ##dcdcdc;" id="churchHeader">All Churches</h3>
    <div class="row-fluid" style="margin-top:25px;">
      <div class="span12" id="churchAddresses">
      </div>
    </div>
  </div>
  </div>
  <!--- address template --->
  <script type="text/html" id="addressLine">
    <div style="border-bottom:1px solid ##dcdcdc; margin-bottom:15px;">
      <strong>{{ NAME }}</strong><br/>
      {{ ADDRESS }}<br/>
      {{ LOCATION }}<br/>
      <span class="churchwebsite">{{ PHONE }}<br/></span>
      <span class="churchwebsite"><a href="http://{{ WEBSITE }}">{{WEBSITE}}</a><br/></span>
      <span class="churchwebsite">{{ MEETING }}<br/><br/>
    </div>
  </script>
</cfoutput>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA2mNVfNLXhFDFf5Falvw8re9RZbxVqKUA&sensor=true"></script>
    <script type="text/javascript">
    var geocoder;
    var map;
    var infowindow;

      function initialize() {
        geocoder = new google.maps.Geocoder();
        var myLatLng = new google.maps.LatLng(38.50, -96.50);
        var mapOptions = {
          center: myLatLng,
          zoom: 4,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map-canvas"),
            mapOptions);
        infowindow = new google.maps.InfoWindow();

      }

      function codeAddress(longitude, latitude,id, address, churchName, site, phone, location){
        var contentString = "<strong>"+churchName+"</strong><br/>"+
            address+"<br/>"+
            location+"<br/>"+
            phone+"<br/>";
        if(site != ""){
          contentString += "<a href='http://"+site+"'>"+site+"</a>"
        }

        var latlng = new google.maps.LatLng(latitude,longitude);
            var marker = new google.maps.Marker({
              map:map,
              position:latlng,
              content:contentString
            });
            google.maps.event.addListener(marker, 'click', function() {
              map.setZoom(8);
              map.setCenter(marker.getPosition());
              infowindow.setPosition(latlng);
              infowindow.setContent(marker.content);
              infowindow.open(map, marker);
            });

      }


      $(function(){
        initialize();
        $.getJSON("/churches/getAddressesForMap?format=json", {}, function(data){
          $.each(data, function(i){
              codeAddress(data[i].LONG, data[i].LAT, data[i].ID, data[i].ADDRESS, data[i].NAME, data[i].WEBSITE, data[i].PHONE, data[i].LOCATION);
              if(data[i].FAX != ""){
                data[i].FAX = "Fax: "+data[i].FAX;
              }
              if(data[i].MEETING != ""){
                data[i].MEETING = "Meeting at: "+data[i].MEETING;
              }
              var resultAddress = ich.addressLine(data[i]);
              $("#churchAddresses").append(resultAddress);
          });
        });

        $("#searchChurch").on("change", function(){
          $.getJSON("/churches/getAddressesForMap?format=json", {searchText: $(this).val()}, function(data){
            $("#churchAddresses").html("");
            $.each(data, function(i){
              var resultAddress = ich.addressLine(data[i]);
              $("#churchHeader").text("Church Found");
              $("#churchAddresses").append(resultAddress);
            });
            if(data.length === 1){
              var zoom = 8;
            }else{
              var zoom = 6;
            }
            var theGeo = new google.maps.Geocoder();
            theGeo.geocode({'address':data[0].LOCATION}, function(results, status){
              if (status == google.maps.GeocoderStatus.OK) {
                 map.setCenter(results[0].geometry.location);
                 map.setZoom(zoom);
               } else {
                 alert("Geocode was not successful for the following reason: " + status);
               }
            });
          });
        });

        $(".state").on("click", function(){
          $(".nav-list li").removeClass("active");
          $(this).parent().addClass("active");
          var st = $(this).text();
          if(st === "Washington"){
            st = "Washington State";
          }
            geocoder.geocode({'address':st+", USA"}, function(results, status){
            if (status == google.maps.GeocoderStatus.OK) {
              map.setCenter(results[0].geometry.location);
              map.setZoom(6);
            } else {
              alert("Geocode was not successful for the following reason: " + status);
            }
          });
          $.getJSON("/churches/getAddressesForMap?format=json", {state:$(this).text()},function(data){
            $("#churchAddresses").html('');
            $.each(data, function(i){
              var resultAddress = ich.addressLine(data[i]);
              $("#churchHeader").text(st+" Churches");
              $("#churchAddresses").append(resultAddress);
            });
          });

          return false;
        });
        // $(".state").on("click", function(){
        //   var st = $(this).text();
        //   if($(this).text() === "Washington"){
        //     st = "Washington State";
        //   }
        //   geocoder.geocode({'address':st+", USA"}, function(results, status){
        //     if (status == google.maps.GeocoderStatus.OK) {
        //       map.setCenter(results[0].geometry.location);
        //       map.setZoom(6);
        //     } else {
        //       alert("Geocode was not successful for the following reason: " + status);
        //     }
        //   });
        //   $.getJSON("/index.cfm?controller=main-churches&action=getAddressesForMap&format=json", {state:$(this).text()},function(data){
        //     $("#churchAddresses").html('');
        //     $.each(data, function(i){
        //       var resultAddress = ich.addressLine(data[i]);
        //       $("#churchHeader").text(st+" Churches");
        //       $("#churchAddresses").append(resultAddress);
        //     });
        //   });
        // });
      });
    </script>
    --->