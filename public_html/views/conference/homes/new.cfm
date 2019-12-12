	<cfparam name="formaction" default="create">
	<cfparam name="instructions" default="instructions go here">
	<cfparam name="instructionsId" default=0>
	<cfparam name="formtype" default="formForHosts">
	<cfoutput>

	#styleSheetLinkTag("conference/conferencehomes")#

	<div id="app" class="container" style="background-color:white;padding:20px;border-radius:10px">
		{{name}}
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
					<div @mouseover="mouseOver">
						<input type="submit" id="submitButton" class="btn btn-primary btn-lg btn-block" :disabled='submitDisabled' >
					</div>
						{{showRequired}}
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
			showRequired: ""
		}
	},
	methods: {
		mouseOver: function () {
			this.message="moused over"
		},
	},
	computed: {
		submitDisabled: function () {
			if ( this.name.length && this.phone.length && this.email.length ) {
				return false
			} else {
				return true
			}
		},
	}
})
</script>

