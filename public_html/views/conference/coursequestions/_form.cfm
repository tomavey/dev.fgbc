<cfparam name="person" default=false>
<cfparam name="course" default=false>
<cfoutput>				
<cfset lastperson = "">
<cfset thisperson = "">

#ckeditor()#

    <cfif isObject(person)>
        #hiddenField(objectName="Coursequestion", property="personid")#
        <h2>#person.fname# #person.family.lname#</h2>
    <cfelse>
        <select name="Coursequestion.personid" class="selectname input-large">
                <option value="">---Select your name---</option>
                <cfoutput query="registrations" group="fullNameLastFirstID">
                    <cfset thisperson = '#lname#, #fname#'>
                                    <cfif thisperson NEQ lastperson>
                        <option value=#id#>#thisperson#</option>
                                    </cfif>
                    <cfset lastperson = '#lname#, #fname#'>
                </cfoutput>
        </select>

    </cfif>

    <cfif isObject(course)>
        #hiddenField(objectName="Coursequestion", property="courseid")#
        <h2>#course.title#</h2>
    <cfelse>
        <select name="Coursequestion.courseid" class="selectname">
                <option value="">---Select your Course---</option>
                <cfoutput query="courses" group="title">
                        <option value=#id#>#title#</option>
                </cfoutput>
        </select>

    </cfif>

						#textArea(objectName='Coursequestion', property='question', label='Your Question:', class="input-xxlarge ckeditor")#

                <cfif gotRights("office")>                
						#textField(objectName='Coursequestion', property='sortorder', label='Sortorder')#
                        #select(objectName="Coursequestion", property="approved", options="Yes,No")#    
                </cfif>
                					
</cfoutput>