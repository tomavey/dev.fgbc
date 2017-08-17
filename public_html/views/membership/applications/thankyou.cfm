<cfoutput>
<h1>Thank you!</h1>
<div class="well">
<p>Your application is saved in our database and wll be processed by the membership commission of the Fellowship Council.</p>

<p>You should be contacted by the national office of the FGBC or my a member of the membership team soon.</p>

<p>You will receive a copy of your answers by email along with a link to edit your answers. Or you can use the links below to edit or view your answers...</p>
<ul>
<li>#linkTo(text="Edit your answers", action="edit", key=session.membershipapplication.uuid)#</li>
<li>#linkTo(text="View your answers", action="show", key=session.membershipapplication.uuid)#</li>
</ul>
</div>
</cfoutput>