<div id="newMinistriesApp">
{{message}}

<cfoutput>

<div class="row-fluid well contentStart contentBg">
  <h3 v-if="!showForm(ministry)">LOADING...</h3>  
  <form name="ministryForm" @submit="addMinistry()" novalidate v-if="showForm(ministry)">
    <p>
        The email address of the person filling out this form...<br/>
        <input v-model="ministry.contactemail" name="contactemail" type="email" class="form-control" v-bind:placeholder="questions.contactemail" required >
    </p>

    <input v-model="ministry.name" name="name" type="text" v-bind:placeholder="questions.name" required>
        <br/>
    <input v-model="ministry.address1" type="text" v-bind:placeholder="questions.address1">
    <input v-model="ministry.address2" type="text" v-bind:placeholder="questions.address2">
    <input v-model="ministry.city" type="text" v-bind:placeholder="questions.city">
    <input v-model="ministry.state" type="text" v-bind:placeholder="questions.state">
    <input v-model="ministry.zip" type="text" v-bind:placeholder="questions.zip">
    <input v-model="ministry.phone" type="text" v-bind:placeholder="questions.phone">
    <input v-model="ministry.email" type="text" v-bind:placeholder="questions.email">
    <input v-model="ministry.website" name="website" type="text" v-bind:placeholder="questions.website" ng-minlength="3">

    <div class="well">
        <p v-html="questions.officers"></p>
        <textarea class="ckeditor" name="officers" v-model="ministry.officers" required></textarea>
    </div>

    <div class="well">
        <p v-html="questions.priorities"></p>
        <textarea class="ckeditor" name="priorities" v-model="ministry.priorities" required></textarea>
    </div>

    <div class="well">
        <p v-html="questions.harmony"></p>
        <p><input type="radio" name="harmony" v-model="ministry.harmony" value="Yes"> Yes</p>
        <p><input type="radio" name="harmony" v-model="ministry.harmony" value="No"> No</p>
        <p><input type="radio" name="harmony" v-model="ministry.harmony" value="Call me"> Call Me</p>
    </div>

    <div class="well">
        <p v-html="questions.sponsored"></p>
        <textarea class="ckeditor" name="sponsored" v-model="ministry.sponsored" required></textarea>
    </div>

    <div class="well">
        <p v-html="questions.association"></p>
        <textarea class="ckeditor" name="association" v-model="ministry.association" required ></textarea>
    </div>

    <div class="well">
        <p v-html="questions.scope"></p>
        <textarea class="ckeditor" name="scope" v-model="ministry.scope" required ></textarea>
    </div>

     <div class="well">
      <p v-html="questions.greatcommission"></p>
      <textarea class="ckeditor" name="greatcommission" v-model="ministry.greatcommission" required ></textarea>
    </div>

     <div class="well">
      <p v-html="questions.unity"></p>
        <textarea class="ckeditor" name="unity" v-model="ministry.unity" required ng-minlength="3"></textarea>
    </div>

    <div class="well">
        <p v-html="questions.obligation"></p>
        <input v-model="ministry.obligation" type="text" >
    </div>

    <div class="well">
      <p v-html="questions.review"></p>
      <p v-html="questions.MOP"></p>

        <p><span v-html="questions.creation"></span>
            <input type="text" name="creation" v-model="ministry.creation" >
        </p>

        <p><span v-html="questions.integral"></span>
            <input type="text" name="integral" v-model="ministry.integral" >
         </p>

        <p><span v-html="questions.controlled"></span>
            <input type="text" name="controlled" v-model="ministry.controlled" >
        </p>

        <p><span v-html="questions.report"></span>
            <input type="text" name="report" v-model="ministry.report" >
        </p>

    </div>

   <div class="well">
      <p v-html="questions.history"></p>
      <textarea class="ckeditor" name="history" v-model="ministry.history" required ng-minlength="defaultRequiredLength"></textarea>
      {{ministryForm.why}}
    </div>

    <input :value="questions.submit" type="submit" class="btn btn-block">
  </form>

</div>

</cfoutput>

</div>

<cfoutput>

#includePartial("scripts")#

</cfoutput>
