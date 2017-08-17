<cfoutput>	

    <ul class="nav nav-tabs">
	    <cfif isFrench()>
		    <li class="active">
		    	#linkto(text="Francais", params="language=French", class="tooltip2", title="Recharger cette page en Francais")#
		    </li>	
	    <cfelse>	
		    <li>
		    	#linkto(text="Francais", params="language=French", class="tooltip2", title="Recharger cette page en Francais")#
		    </li>	
	    </cfif>
	    <cfif isSpanish()>
		    <li class='active'>
		    	#linkto(text="Espanol", params="language=Spanish", class="tooltip2", title="Actualizar esta pagina en Espanol")#
		    </li>
	    <cfelse>	
		    <li>
		    	#linkto(text="Espanol", params="language=Spanish", class="tooltip2", title="Actualizar esta pagina en Espanol")#
		    </li>
	    </cfif>	
	    <cfif isEnglish()>
		    <li class="active">
		    	#linkto(text="English", params="language=English", class="tooltip2", title="Reload this page in English")#
		    </li>
	    <cfelse>	
		    <li>
		    	#linkto(text="English", params="language=English", class="tooltip2", title="Reload this page in English")#
		    </li>
	    </cfif>
    </ul>

</cfoutput>