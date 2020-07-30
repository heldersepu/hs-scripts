control 'ec2_type_tag' do
  title 'Ensure ec2 instance type and tags.'
  impact 1.0

  for i in 0..2
    describe aws_ec2_instance(name: "server#{i}") do
      its('instance_type') { should eq 't2.micro' }
      its('tags') { should include(key: 'terraformed', value: 'n') }
      its('tags') { should include(key: 'test', value: /.*/) }
    end
  end
end