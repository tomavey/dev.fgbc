<cfdump var="#churches#">
<cfoutput>
  <div class="row-fluid well contentStart contentBg">
    <div class="span3">
    #includePartial(partial="states", selected="all", qStates=churchStates)#
  </div>
  <div class="span9">
    <h3 class="addBottomBorder">Church Directory</h3>
    <div class="row-fluid" style="background-color:##555; padding:5px; margin:5px 0 0 0;">
      <div class="span12">
        <input type="text" name="searchChurch" id="searchChurch" class="input-block-level" style="margin-bottom:0;" placeholder="Search for a Church (By City, State or Zip Code)">
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
      <strong><a href="/index.cfm/churches/show/{{ ID }}">{{ NAME }}</a></strong><br/>
      {{ ADDRESS }}<br/>
      {{ LOCATION }}<br/><br/>
    </div>
  </script>
</cfoutput>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyArPp-22gMt7YX5JMwZNKnRN_mPsRcnnYA&sensor=true"></script>
    <script type="text/javascript">
    var geocoder;
    var map;

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

        
      }

      function codeAddress(longitude, latitude,id){
        var latlng = new google.maps.LatLng(latitude,longitude);
            var marker = new google.maps.Marker({
              map:map,
              position:latlng
            });
         
      }
      google.maps.event.addDomListener(window, 'load', initialize);
      $(function(){
        $.getJSON("/index.cfm?controller=main-churches&action=getAddressesForMap&format=json", {}, function(data){
          $.each(data, function(i){
              codeAddress(data[i].LONG, data[i].LAT, data[i].ID);
              var resultAddress = ich.addressLine(data[i]);
              $("#churchAddresses").append(resultAddress);
          });
        });

        $("#searchChurch").on("change", function(){
          $.getJSON("/index.cfm?controller=main-churches&action=getAddressesForMap&format=json", {searchText: $(this).val()}, function(data){
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
          $.getJSON("/index.cfm?controller=main-churches&action=getAddressesForMap&format=json", {state:$(this).text()},function(data){
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
 