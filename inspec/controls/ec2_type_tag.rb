control 'ec2_type_tag' do
  title 'Ensure ec2 instance type and tags.'
  impact 1.0

  aws_ec2_instances.instance_ids.each do |instance_id|
    describe aws_ec2_instance(instance_id) do
      its('instance_type') { should eq 't2.micro' }
      its('tags') { should include(key: 'terraformed', value: 'n') }
      its('tags') { should include(key: 'test', value: /.*/) }
    end
  end
end