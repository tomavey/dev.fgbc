<cfoutput>
<section id="newsletter">
  <div class="container">
    <div class="row">
      <div class="span12 hero-unit text-center">
        <h2>Subscribe to Our Newsletter</h2>
      </div>
      <div class="span12 ErrorMsgs"></div>
      <form name="contactform" id="contactform" method="post" action="contact.php">
            <input type="hidden" name="contact_name" id="contact_name" value="Vision Conference Guest">
            <input type="hidden" name="contact_subject" id="contact_subject" value="Subscription Request">
            <input type="hidden" name="contact_message" id="contact_message" value="Subscribe Me!">
        <div class="control-group span8 offset2">
          <div class="controls">
            <input type="email" id="contact_email" name="contact_email" class="validate[required,custom[email]] input-block-level" required="" placeholder="Enter Your Email Address here...">
          </div>
        </div>
        <div class="control-group span12 text-center">
            <button type="submit" id="submit" class="btn btn-primary" name="submit">Subscribe Me!</button>
        </div>
      </form>
    </div>
    <!-- end row -->
  </div>
  <!-- end container -->
</section>
<!-- end newsletter -->
</cfoutput>