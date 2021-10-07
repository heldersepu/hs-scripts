control 'ec2_role' do
  title 'Ensure ec2 instance type and tags.'
  impact 1.0

  describe aws_ec2_instance('i-0b54e2b5498ce00ec') do
    it { should have_roles }
    its('role') { should eq "tool_iam_role"}
  end
end

