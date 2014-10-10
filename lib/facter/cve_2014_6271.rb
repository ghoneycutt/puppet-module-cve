# From https://github.com/renanvicente/puppet-shellshock
Facter.add('cve_2014_6271') do
  setcode do
    Facter::Util::Resolution.exec("env x='() { :;}; :; echo vulnerable' bash -c : 2>&1 | grep 'vulnerable' || echo 'not_vulnerable'")
  end
end
