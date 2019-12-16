	<cfparam name="formaction" default="create">
	<cfparam name="instructions" default="instructions go here">
	<cfparam name="instructionsId" default=0>
	<cfparam name="formtype" default="formForHosts">
	<cfoutput>

	#styleSheetLinkTag("conference/conferencehomes")#

	<div id="app" class="container" style="background-color:white;padding:20px;border-radius:10px">

		#includePartial("includes/navbar")#

		<cfif gotRights("office")>
			<p class="text-right">
				#linkto(text="<i class='fa fa-pencil-square'></i>", controller="admin.contents", action="edit", key=instructionsId)#
			</p>
		</cfif>

		<p>#instructions#</p>

		#includePartial("includes/showFlash")#

					
					#errorMessagesFor("home")#
			
					#startFormTag(action=formaction)#
				
					#includePartial('includes/#formtype#')#				
																		
					<!--- #submitTag(value="Submit", class="btn btn-primary btn-lg btn-block", id="submitButton")# --->
					<div @mouseover="mouseOver" @mouseleave="mouseLeave" :class="mouseOverDiv">
						<input type="submit" id="submitButton" class="btn btn-primary btn-lg btn-block" :disabled='inValid'>
						<div v-html="validationMessage" class="text-center"></div>
					</div>
					#endFormTag()#
					
				

		#linkTo(text="Return to the listing", action="index")#
		<p>
			{{message}}
		</p>

	
	</div>

</cfoutput>

<script>
	var app = new Vue({
  el: '#app',
  data: function () {
		return {
			message: 'vue loaded',
			name: '',
			phone: '',
			email: '',
			showRequired: "",
			mouseOverDiv: "homes"
		}
	},
	methods: {
		mouseOver: function () {
			if ( this.inValid ){
				this.mouseOverDiv = "homes alert alert-danger"
			}
		},
		mouseLeave: function () {},
		submitClick: function (){
			alert("clicked")
		},
		validEmail: function (email) {
			let mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
			return mailformat.test(email)
		}
	},
	computed: {
		inValid: function () {
			if ( !this.name.length || !this.phone.length || !this.validEmail(this.email) ) {
				return true
			} else {
				return false
			}
		},
		validationMessage: function () {
			if ( this.inValid ) {
				return "Name, Phone and Email are required"
			} else {
				return ""
			}
		},
		validEmailMessage: function () {
			if ( this.validEmail(this.email) ) {
				return ""
			} else {
				return "A valid email is required"
			}
		}	
	}
})
</script>

<style>
 .required {
	 font-size: .6em;
	 font-weight: normal
 }
</style>

