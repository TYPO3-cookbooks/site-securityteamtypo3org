control 'securityotrs-1' do
  title 'OTRS Security Team'

  describe port(80) do
    it { should be_listening }
    its('protocols') { should include 'tcp'}
  end

  describe command('curl -I http://otrs.vagrant') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include 'HTTP/1.1 401' }
    its('stdout') { should include 'WWW-Authenticate: Digest realm="t3secteam"' }
  end

  describe command('curl -I http://otrs.vagrant/otrs/index.pl') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include 'HTTP/1.1 401' }
    its('stdout') { should include 'WWW-Authenticate: Digest realm="t3secteam"' }
  end

  describe command('curl -i http://otrs.vagrant --digest --user test:test') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include 'HTTP/1.1 200' }
    its('stdout') { should include '<meta http-equiv="refresh" content="0; URL=/otrs/index.pl" />' }
  end

  describe command('curl -I http://otrs.vagrant/otrs/index.pl --digest --user test:test') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include 'HTTP/1.1 200' }
  end

end
