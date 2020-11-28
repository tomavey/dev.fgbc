<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>ACCESS HOST HOME SUBMITTAL</title>
</html>
<style>
  .homes {
    border: 1px solid grey;
    padding:20px;
    margin: 20px;
    border-radius:10px;
    font-size:20px
  }
  .homes-section {
    border: 1px solid black;
    width: 300px;
    padding: 5px;
    margin-top: -30px;
    background-color: white;
    font-size: 110%;
    font-weight: bold;
    border-radius: 5px
  }
  .homes-question {
    margin-bottom:40px
  }
  .homes-multi {
    margin-left: 30px
  }
  .homes label {
    font-size:105%
  }
  .homes-multi label input {
    margin-left:10px
  }
  .homes-input-wide {
    width: 90%
  }
  .homes-input-half {
    width: 50%
  }
  .homes-input-short {
    width: 100px
  }
</style>
</head>
<body>
  
<div class="container">
  <h1 class="text-center">THE FOLLOWING HOST HOME INFO HAS BEEN SUBMITTED</h1>
  <cfoutput>
    #includePartial(partial="includes/contactinfo")#

    #includePartial(partial="includes/availabilityinfo")#
  
    #includePartial(partial="includes/detailsinfo")#
  
    #includePartial(partial="includes/office")#

    <p>
      #buttonForEmail(text="View Home", action="show", key=home.id)#
    </p>

    <p>&nbsp;</p>
  
    <p>
      #buttonForEmail(text="List Homes", action="index")#
    </p>

    <p style="font-size:.8em">Note: You need to be logged in to access the list</p>
    
  </cfoutput>
</div>

</body>
