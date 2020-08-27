<cfoutput>
<section id="contact" class="white">
  <div class="container">
    <div class="row">
      <div class="span12">
        <div class="module-header contact-header">
          <h4>Contact</h4>
        </div>
      </div>
      <!-- end span12 -->
      <div class="span12 hero-unit text-center white">
        <h2>Get in touch</h2>
        <p>Use this form to send questions to the organizers of Vision Conference 2016</p>
      </div>
      <!-- end hero-unit -->
      <div class="span12 ErrorMsgs"></div>
      <!-- end ErrorMsgs -->
      <form name="contactform" id="contactform" method="post" action="contact.php">
        <div class="control-group span4">
          <label for="contact_name" class="control-label">Name:</label>
          <div class="controls">
            <input type="text" name="contact_name" id="contact_name" class="validate[required] input-block-level" required="">
          </div>
        </div>
        <div class="control-group span4">
          <label for="contact_email" class="control-label">Email:</label>
          <div class="controls">
            <input type="email" id="contact_email" name="contact_email" class="validate[required,custom[email]] input-block-level" required="">
          </div>
        </div>
        <div class="control-group span4">
          <label for="contact_subject" class="control-label">Subject:</label>
          <div class="controls">
            <input type="text" name="contact_subject" id="contact_subject" class="validate[required] input-block-level">
          </div>
        </div>
        <div class="control-group span12">
          <label for="contact_message" class="control-label">Message:</label>
          <div class="controls">
            <textarea name="contact_message" id="contact_message" cols="30" rows="6" class="validate[required] input-block-level"></textarea>
          </div>
        </div>
        <div class="control-group span12">
          <div class="controls">
            <button type="submit" id="submit" class="btn btn-primary pull-right" name="submit">Send Message</button>
          </div>
        </div>
      </form>
      <div class="span12 text-center">
        <div class="subheader">
          <h4>Contact info</h4>
        </div>
        <!-- -->
      </div>
      <div class="span12 text-center">
        <p>FGBC, Inc.<br/>
        P.O. Box 384<br/>
        Winona Lake, Indiana 46590
        </p>
      </div>
      <div class="span6 text-center">
        <p><i class="iconf-mobile"></i> Inqueries: <a href="tel:574 269 1269">574 269 1269</a></p>
      </div>
      <div class="span6 text-center">
        <p><i class="iconf-mail"></i> Email: <a href="mailto:info@visionconference.com">info@visionconference.com</a> </p>
      </div>
      <div class="span12 text-center">
        <div class="social">
          <a href="#facebookUrl()#" target="_blank" title="Facebook" class="icon-wrap small facebook"> <i class="iconf-facebook"></i> </a>
          <a href="#twitterUrl()#" target="_blank" title="Twitter" class="icon-wrap small twitter"> <i class="iconf-twitter"></i> </a>
          <a href="#vimeoUrl()#" target="_blank" title="Vimeo" class="icon-wrap small vimeo"> <i class="iconf-vimeo"></i> </a>
          <div class="fb-share-button" data-href="http://www.visionconference.us" data-layout="button_count"></div>
<!---
          <a href="##" target="_blank" title="Google+" class="icon-wrap small google"> <i class="iconf-gplus"></i>  </a>
          <a href="##" target="_blank" title="Linkedin" class="icon-wrap small linkedin"> <i class="iconf-linkedin"></i>  </a>
          <a href="##" target="_blank" title="RSS" class="icon-wrap small rss"><i class="iconf-rss"></i> </a>
          <a href="##" target="_blank" title="Flickr" class="icon-wrap small flickr"> <i class="iconf-flickr"></i> </a>
          <a href="##" target="_blank" title="Lanyrd" class="icon-wrap small lanyrd"> <i class="iconf-lanyrd"></i> </a>
          <a href="##" target="_blank" title="Eventbrite" class="icon-wrap small eventbrite"> <i class="iconf-eventbrite"></i> </a>
          <a href="##" target="_blank" title="Eventful" class="icon-wrap small eventful"> <i class="iconf-eventful"></i> </a> </div>
--->
      </div>
    </div>
    <!-- end row -->
  </div>
  <!-- end container -->
</section>
<!-- end contact -->
</cfoutput>