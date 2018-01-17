      <!-- Login modal window -->
      <div id="login" class="text-left g-max-width-600 g-bg-white g-overflow-y-auto g-pa-20" style="display: none;">
        <button type="button" class="close" onclick="Custombox.modal.close();">
          <i class="hs-icon hs-icon-close"></i>
        </button>
        <h4 class="g-mb-20">Login</h4>
        <cfoutput>
            #startFormTag(route="authCheckLogin")#
            #textField(objectName='user', property='username', label='Username:&nbsp;', class="input-block-level")#
            #passwordField(objectName='user', property='password', label='Password:&nbsp;&nbsp;', class="input-block-level")#
            #submitTag(value="Login", class="btn btn-primary")#
            <p>#linkTo(text="Create a new FGBC account", controller="auth.users", action="new")#</p>
            #endFormTag()#
        </cfoutput>
      </div>
      <!-- End Demo modal window -->

