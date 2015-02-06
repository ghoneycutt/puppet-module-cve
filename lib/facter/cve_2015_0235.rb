# http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-0235
# GHOST
#
# Tests for an unpatched rpm of glibc
# More https://access.redhat.com/articles/1332213

glibc_nvr = Facter::Util::Resolution.exec('rpm -q --qf "%{name}-%{version}-%{release}.%{arch}\n" glibc').scan(/^(glibc-(\d+\.\d+).*)$/)

if glibc_nvr.length
  Facter.add('cve_2015_0235') do
    require 'puppet'
    rv = false
    glibc_nvr.each do |glibc_rpm,glibc_version|
      # fixed upstream version
      if Puppet::Util::Package.versioncmp('2.18', glibc_version) > 0 then
        # all RHEL updates include CVE in rpm changelog
        if not system("rpm -q --changelog '#{glibc_rpm}' | grep -q 'CVE-2015-0235'") then
          rv = true
          break
        end
      end
    end
    setcode do
      if rv then 'vulnerable' else 'not_vulnerable' end
    end
  end
end
