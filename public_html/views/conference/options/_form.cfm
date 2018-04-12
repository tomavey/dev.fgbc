<cfoutput>
						#textField(objectName='option', label="Option Name", property='name', append="<br/>", placeholder="Option Name")#

						#textField(objectName='option', label="Cost", property='cost', class="input-small", Placeholder='Amount', append="<br/>")#

						#textField(objectName='option', label="Button Description", property='buttondescription', placeholder='Short Description (used in list of options and invoice):', append="<br/>", class="input input-xxlarge")#

						#textField(objectName='option', label="SortOrder", property='sortorder', placeholder='Sort Order', append="<br/><br/>", class="input input-small")#

						#textField(objectName='option', label="Event (most of the time, don't change this)", property='event', placeholder='Event: ', append="<br/>")#

						#select(objectName='option', property='type', Placeholder='Type', options="#application.wheels.typeOfOptions#", append="<br/>")#

						#select(objectName='option', property='buttontype', Placeholder='Type of button to select', options="radio,checkbox,count", append="<br/>")#

						<div id="discountOptions" class="well">

						#select(objectName='option', property='discountType', Label='How to apply this discount', options="#getDiscountTypes()#", append="<br/>")#

						<div id="discountDependency">
						#textField(objectName='option', label="", property='discountDependsOn', placeholder='Discount Depends on', append="<br/>")#
						<p id="discountinstructions">(Comma delimited list of option names that this discount depends on. (ie: If this discount can only be used with a full registration enter 'V2020RegCouple,V2020RegSingle'.) If this discount does not depend on a specific option, leave blank.</p>
						</div><br/><br/>
						</div>

						#select(objectName='option', property='qualifiesforfamilydiscount', label='Qualifies for Family Discount', options="No,Yes", append="<br/>", class="input input-small")#

						#textField(objectName='option', property='maxtosell', label='Maximum tickets available for sale: ', append="<br/>", class="input-small")#

<!--- was never implemented, fields not in table
						#select(objectName='option', property='buttontype', label='Select type', options="Blank Field,Select quantity from list,Radio Button,Check Box", append="<br/>")#

						<div id="selectquantitymax">
						#textField(objectName='option', property='selectquantitymax', Label='Number of tickets in dropdown available for each item: ', append="<br/>", class="input-small")#
						</div>
--->
						#textArea(objectName='option', property='description', label='Longer Description (used in popup:)', style="width:600px", append="<br/>")#

						#textArea(objectName='option', property='ad', label='Ad:', style="width:600px", append="<br/>")#

						#textField(objectName='option', label="", property='comment', placeholder='Comment (internal use only):', style="width:600px", append="<br/>")#

						#textField(objectName='option', label="", property='image', placeholder='Image:', append="<br/>")#

						#textField(objectName='option', label="", property='link', placeholder='Link:', append="<br/>")#
</cfoutput>