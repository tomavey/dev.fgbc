<cfparam name="formAction" default="create">
<cfparam name="user" required="true" type="struct">

<div class="container card card-charis text-center" id="app">

	<cfif getSetting("AllowUserAccountCreation")>

		<h1>Create a new Charis user account: </h1>

		<cfoutput>

			<cfif flashKeyExists("usedEmail")>
				<p class="errorMessage">
						#flash("usedEmail")#
				</p>
			</cfif>
	
			<cfif flashKeyExists("usedUsername")>
				<p class="errorMessage">
						#flash("usedUsername")#
				</p>
			</cfif>

			#errorMessagesFor("user")#

			#startFormTag(action=formAction)#

			#includePartial("form")#	
			
			<cfif !bypassCaptcha>
				#includePartial("/captcha")#	
			</cfif>

			<p>What does the greek word "charis" mean?
			<input type=text v-model="charis">
			</p>

			<div @mouseover="mouseover"  class="mouseover">
				<input type="submit" value="Create Your New Account" :disabled=captchaPass()>
				<p v-if=showMessage>
					Enter the correct 5 letter word for "charis" inorder to submit this form.<br/>
					<span>Why? To discourage webbots!</span>

				</p>
			</div>
				
			#endFormTag()#
					
			<cfif gotRights("superadmin")>
				#linkTo(text="Return to the listing", action="index")#
			</cfif>

		</cfoutput>
	<cfelse>
		<h1>New user account creation is temporarily closed! </h1>
	</cfif>	

</div>

<script>

var app = new Vue({
  el: '#app',
  data: {
		charis: "",
		showMessage: false
	},
	methods: {
		captchaPass: function(){
			if ( this.charis.toLowerCase() === "grace" ) {
				return false
			} else {
				return true
			}
		},
		mouseover: function(){
			if ( this.captchaPass() ) {
				this.showMessage = true
			}
		}
	}
})

</script>

<style>
	.mouseover {
		padding: 5px
	}

	.mouseover span {
		font-size: .8em
	}
</style>