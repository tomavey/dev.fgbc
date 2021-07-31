<cfoutput>
<!-- Modal -->
<div class="modal hide fade" id="modal-register">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <cfif registrationOpen()>
    <h3>Register</h3>
    <cfelse>
    <h3>Basic Registration Prices</h3>
    </cfif>
    <p>Includes celebrations, worships and access to child care, meals, and discounted lodging.</p>
  </div>
  <div class="modal-body">
    <ul class="price-table">
      <li class="price-item clearfix item">
        <div class="price-header"> <span class="title">Single</span> <span class="price">$220</span> </div>
        <!-- end price-header -->
        <div class="price-content">
          <p>Includes all Celebrations and Workshops gives you access to our discounted room rate, Grace Kids, and Sponsored meals. Couples price is $340</p>
          #registrationButton()#
        </div>
        <!-- end price-content -->
      </li>
      <!-- end price-item -->
      <li class="price-item clearfix item">
        <div class="price-header"> <span class="title">Students 16-24 years old</span> <span class="price">Free!</span> </div>
        <!-- end price-header -->
        <div class="price-content">
          <p>Bring your young leaders.  Introduce them to the Fellowship of Grace Brethren Churches at Vision Conference!</p>
          #registrationButton()#
        <!-- end price-content -->
      </li>
      <!-- end price-item -->
      <li class="price-item clearfix item">
        <div class="price-header"> <span class="title">Leaders 25-29 years old</span> <span class="price">$120</span> </div>
        <!-- end price-header -->
        <div class="price-content">
          <p>Bring your young leaders.  Introduce them to the Fellowship of Grace Brethren Churches at Vision Conference! Couple price is $140.</p>
          #registrationButton()#
        <!-- end price-content -->
      </li>
      <!-- end price-item -->
      <li class="price-item clearfix item">
        <div class="price-header"> <span class="title">Groups of 10</span> <span class="price">as low as $150 each</span> </div>
        <!-- end price-header -->
        <div class="price-content">
          <p>Your church can purchase a pack of 5 or 10 registrations at a great discount. Bring you whole staff or leadership to Vision Conference.</p>
          <a href="http://margins2016.eventbrite.com" type="button"
            class="btn" target="_blank" />Order Now</a>
        </div>
        <!-- end price-content -->
      </li>
      <!-- end price-item -->
    </ul>
  </div>
  <!-- end modal-body -->
  <div class="modal-footer"> <a data-dismiss="modal" class="btn">Close</a> </div>
</div>
</cfoutput>