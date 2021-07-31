<cfscript>

public function displayNumber(number){
	if (val(number)){
		return numberFormat(round(arguments.number));
	}
	else {
		return "NA";
	}
}

</cfscript>

<cfoutput>		
			<td>
				#displayNumber(sumAtt)#
			</td>
			<td>
				#displayNumber(avgAtt)#
			</td>
			<td>
				#displayNumber(sumMembers)#
			</td>
			<td>
				#displayNumber(avgMembers)#
			</td>
			<td>
				#displayNumber(sumBaptisms)#
			</td>
			<td>
				#displayNumber(avgBaptisms)#
			</td>
			<td>
				#displayNumber(sumConversions)#
			</td>
			<td>
				#displayNumber(avgConversions)#
			</td>
			<td>
				#displayNumber(sumSs)#
			</td>
			<td>
				#displayNumber(avgSS)#
			</td>
</cfoutput>