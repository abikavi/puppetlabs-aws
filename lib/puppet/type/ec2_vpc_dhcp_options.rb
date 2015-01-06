Puppet::Type.newtype(:ec2_vpc_dhcp_options) do
  @doc = 'type representing a DHCP option set for AWS VPC'

  ensurable

  newparam(:name, namevar: true) do
    desc 'the name of the DHCP options set'
    validate do |value|
      fail 'DHCP option sets must have a name' if value == ''
    end
  end

  newproperty(:tags) do # TODO
    desc 'tags for the DHCP option set'
  end

  newproperty(:region) do
    desc 'the region in which to assign the DHCP option set'
    validate do |value|
      fail 'region should not contain spaces' if value =~ /\s/
    end
  end

  newproperty(:domain_name) do
    desc 'the domain name for the DHCP options'
    validate do |value|
      unless value =~ /^[\w\.-]+$/
        raise ArgumentError , "'%s' is not a valid domain_name" % value
      end
    end
  end

  newproperty(:domain_name_servers, :array_matching => :all) do
    desc 'a list of domain name servers to use for the DHCP options set'
  end

  newproperty(:ntp_servers, :array_matching => :all) do
    desc 'a list of NTP servers to use for the DHCP options set'
  end

  newproperty(:netbios_name_servers, :array_matching => :all) do
    desc 'a list of netbios name servers to use for the DHCP options set'
  end

  newproperty(:netbios_node_type) do
    desc 'the netbios node type, defaults to 2'
    defaultto '2'
    validate do |value|
      unless value =~ /^[1248]$/
        raise ArgumentError , "'%s' is not a valid netbios_node_type, can be [1248]" % value
      end
    end
  end
end
