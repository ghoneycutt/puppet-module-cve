# https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-3566
# POODLE
#
# Does a check against localhost port 443 using SSLv3 which is insecure.
#
system("which curl > /dev/null 2>&1")
if $? == 0
  Facter.add('cve_2014_3566') do
    setcode do
      system("curl https://localhost:443 -3 -k > /dev/null 2>&1")
      if $? == 0
        'vulnerable'
      else
        'not_vulnerable'
      end
    end
  end
end
