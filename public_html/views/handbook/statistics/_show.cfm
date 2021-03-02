<cfoutput>
  <div class="span10">
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
        Donation: #statistic.donate#
      </li>
      <li>
        Relief: #statistic.relief#
      </li>
      <li>
        Memfee: #statistic.membershipfee#
      </li>
    </ul>
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
