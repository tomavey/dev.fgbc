<cfcontent type="text/x-vCard">
<cfheader name="Content-Disposition" value="inline; filename=newContact.vcf">
<cfoutput>
BEGIN:VCARD
VERSION:3.0
N;charset=iso-8859-1:#handbookperson.lname#;#handbookperson.fname#
BDAY;value=date:#handbookperson.handbookprofile.birthdayasstring#
EMAIL;type=HOME:#handbookperson.email#
TITLE;charset=iso-8859-1:#handbookperson.handbookprofile[1].position#
ORG;charset=iso-8859-1:#handbookperson.name#
ADR;type=WORK;charset=iso-8859-1:;;#handbookperson.address1#;#handbookperson.address2#;#handbookperson.city#;#handbookperson.state_mail_abbrev#;#handbookperson.zip#
TEL;type=HOME:#handbookperson.phone#
END:VCARD
</cfoutput>