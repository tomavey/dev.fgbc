<cfoutput>

<div class="row-fluid contentStart">
	<div class="span9 well contentBg">
		<div class="row-fluid">
			<div class="span4">
				#includePartial(partial="whoweare", selected="contact")#
			</div>
			<div class="span8" style="margin-top:50px;">
				<h3 class="addBottomBorder">Contact Us</h3>
				<div class="row-fluid">
					<form name="contactUs" id="contactUs" method="post">
					<div class="span12">
						<div>
						Name:<br/>
						<input type="text" name="requestName" id="requestName" class="input-block-level">
						</div>
						<div>
						Email:<br/>
						<input type="text" name="requestEmail" id="requestEmail" class="input-block-level">
						</div>
						<div>
						Message:<br/>
						<textarea name="requestMessage" id="requestMessage" class="input-block-level" style="height:200px;"></textarea>
						</div>
						<div class="pull-right">
							<input type="submit" name="submit" value="Send Message" class="btn"/>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="span3">
		#includePartial(partial="spotlight")#
	</div>
</div>

</cfoutput>