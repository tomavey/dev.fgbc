<cfoutput>
  <div class="span10" style="border: 2px solid grey; padding:10px; margin:5px; border-radius:5px">
    <h3>
      #getChurchName(statistic.organizationid)#
    </h3>
    <ul>
      <li>
        Attendance: #statistic.att#
      </li>
      <li>
        Conversions: #statistic.conversions#
      </li>
      <li>
        Baptisms: #statistic.baptisms#
      </li>
      <li>
        Membership: #statistic.members#
      </li>
      <li>
        Total Amount paid: #statistic.memfee#
      </li>
      <li>
        Donation: #dollarFormat(statistic.donate)#
      </li>
      <li>
        Relief: #dollarformat(statistic.relief)#
      </li>
      <li>
        Memfee: #dollarformat(statistic.netMemFee)#
      </li>
    </ul>
    <h4>Special Requests:</h4>
    <p>What can we pray for?
      #statistic.pray#
    </p>
    <p>Celebrations?
      #statistic.celebrate#
    </p>
    <p>Can we assist you?
      #statistic.assist#
    </p>
  </div>
</cfoutput>
