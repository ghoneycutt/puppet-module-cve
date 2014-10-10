# puppet-module-cve
===

[![Build Status](https://travis-ci.org/ghoneycutt/puppet-module-cve.png?branch=master)](https://travis-ci.org/ghoneycutt/puppet-module-cve)

Puppet module to check for specific CVE's (Common Vulnerabilities and Exposures).

---

# Compatibility

This module is built for use with Puppet v3 with Ruby versions 1.8.7, 1.9.3, and 2.0.0.

---

# Description

This module is meant to test for specific vulnerabilities through the use of Facter. Each CVE has a corresponding fact such as `cve_2014_6271` that can return either `vulnerable` or `not_vulnerable`.

These facts can be queried directly.

```
$ facter -p cve_2014_6271
not_vulnerable
```

They are also collected in the structured fact named `cve`.

```
$ facter -p --yaml cve
---
  cve:
    vulnerable:
      - cve_666
    tested:
      - cve_777
      - cve_2014_6271
      - cve_666
    not_vulnerable:
      - cve_777
      - cve_2014_6271
```

---

# Parameters

notify_vulnerabilities
----------------------
Boolean to use the notify resource to display a list of vulnerable CVE's on the agent.

- *Default*: false

---

# Hiera
If you would like a list of vulnerable CVE's to be displayed on each puppet run. Add the following to Hiera.

```
cve::notify_vulnerabilities: true
```