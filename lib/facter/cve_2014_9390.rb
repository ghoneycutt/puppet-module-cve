# http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-9390
# git
#
# More http://git-blame.blogspot.be/2014/12/git-1856-195-205-214-and-221-and.html

version_string = Facter::Util::Resolution.exec('git version')

if not version_string.nil?

  if version_string =~ /^git version ([\d\.]+)/
    version = Regexp.last_match[1]
  else
     version = '0'
  end

  Facter.add('cve_2014_9390') do
    require 'puppet'

    setcode do case
      when ( Puppet::Util::Package.versioncmp('1.8.5.6', version) > 0 )
        'vulnerable'
      when ( Puppet::Util::Package.versioncmp('1.9', version) <= 0 ) & ( Puppet::Util::Package.versioncmp('1.9.5', version) > 0 )
        'vulnerable'
      when ( Puppet::Util::Package.versioncmp('2.0', version) <= 0 ) & ( Puppet::Util::Package.versioncmp('2.0.5', version) > 0 )
        'vulnerable'
      when ( Puppet::Util::Package.versioncmp('2.1', version) <= 0 ) & ( Puppet::Util::Package.versioncmp('2.1.4', version) > 0 )
        'vulnerable'
      when ( Puppet::Util::Package.versioncmp('2.2', version) <= 0 ) & ( Puppet::Util::Package.versioncmp('2.2.1', version) > 0 )
        'vulnerable'
      else
        'not_vulnerable'
      end
    end
  end
end
