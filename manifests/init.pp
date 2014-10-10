# == Class: cve
#
# Module to manage cve
#
class cve (
  $notify_vulnerabilities = false,
) {

  if type($notify_vulnerabilities) == 'String' {
    $notify_vulnerabilities_bool = str2bool($notify_vulnerabilities)
  } else {
    $notify_vulnerabilities_bool = $notify_vulnerabilities
  }
  validate_bool($notify_vulnerabilities_bool)


  if $notify_vulnerabilities_bool == true {
    $vulnerable_cves = template('cve/vulnerable.erb')
    if $vulnerable_cves != undef {
      notify { 'cve_vulnerabilities':
        message => "vulnerable to ${vulnerable_cves}"
      }
    }
  }
}
