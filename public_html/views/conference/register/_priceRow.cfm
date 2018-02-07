<cfoutput>
	<cfif isBefore(#rate.increaseDate#)>
		<tr>
			<td>Before #dateFormat(rate.increaseDate, "mmm d")#</td>
			<td class="center">$#getDollarType()##rate.cost + (rate.increaseAmount * rate.multiplier)#</td>
			<td class="center">FREE</td>
			<td class="center">FREE</td>
		</tr>
	</cfif>
</cfoutput>