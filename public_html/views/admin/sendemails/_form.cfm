<div ng-app="sendEmailApp">
<cfoutput>

#ckeditor()#

<div ng-controller="indexController">


                        #textField(objectName='sendemails', property='subject', label='Subject: ')#



                        #textArea(objectName='sendemails', property='message', label='Message: ', class="ckeditor")#



                        #textField(objectName='sendemails', property='fromemail', label='From email: ')#



                        #textField(objectName='sendemails', property='fromname', label='From name: ')#



                        #textField(objectName='sendemails', property='tags', label='Tags (separate muliple tags with a comma): ')#


                        #textField(objectName='sendemails', property='tagsusername', label='Tags Username: ')#


                        #textField(objectName='sendemails', property='sentTo', label='Sent to: ')#

                        #checkbox(objectName='sendemails', property='sendplaintext', label='Send as plain text: ', checkedValue="Yes", "ng-model"='sendplaintext')#


                        <div ng-hide=sendplaintext>
                            #textField(objectName='sendemails', property='backgroundcolor', label='Background Color: ', class="jscolor")#
                        </div>

                        #textArea(objectName='sendemails', property='comment', label='Comment: ')#


</div>

</cfoutput>

</div>

<script src="/javascripts/angular.min.js"></script>
<script src="/javascripts/sendemailsapp.js"></script>
<script src="/javascripts/sendemailscontrollers.js"></script>
<script src="/javascripts/sendemailsservices.js"></script>

<script src="/javascripts/jscolor.min.js"></script>

