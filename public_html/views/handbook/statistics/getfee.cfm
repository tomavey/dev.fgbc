<cfoutput>

			#startFormTag(action="getFeeTotal")#

			#textFieldTag(name="rate", label="Rate")#

			#textFieldTag(name="max", label="Max Fee")#

			#textFieldTag(name="year", label="Year", value=year(now())-1)#

			#submitTag()#

			#endFormTag()#

</cfoutput>


