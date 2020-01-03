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
    #includePartial("includes/contactinfo")#

    #includePartial("includes/availabilityinfo")#
  
    #includePartial("includes/detailsinfo")#
  
    #includePartial("includes/office")#

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <table border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td 
                bgcolor="##EB7035" 
                style="padding: 12px 18px 12px 18px; border-radius:3px" align="center">
                #linkto(text="View this home", controller="conference.homes", action="show", key=home.id, onlyPath=false, target="_blank", style="font-size: 16px; font-family: Helvetica, Arial, sans-serif; font-weight: normal; color: ##ffffff; text-decoration: none; display: inline-block;")#
              <td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    #emailButton(text="View Home", action="show", key=home.id)#
    <p>
      #linkto(text="View this home", controller="conference.homes", action="show", key=home.id, onlyPath=false)#
    </p>
    <p>
      #linkto(text="List all of the homes", controller="conference.homes", action="index", onlyPath=false)#
    </p>
    <p style="font-size:.8em">Note: You need to be logged in to access the list</p>
    
  </cfoutput>
</div>

</body>
