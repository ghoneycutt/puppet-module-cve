facts = {}
facts = Facter.to_hash

Facter.add('cve', :type => :aggregate) do

  chunk(:tested) do
    cve_hash = {}
    cve_list = []
    facts.each do |k,v|
      if k =~ /^cve_/
        cve_list << k
      end
    end
    cve_hash["tested"] = cve_list
    cve_hash
  end

  chunk(:vulnerable) do
    cve_hash = {}
    cve_vuln = []
    facts.each do |k,v|
      if k =~ /^cve_/
        if v == 'vulnerable'
          cve_vuln << k
        end
      end
    end
    cve_hash["vulnerable"] = cve_vuln
    cve_hash
  end

  chunk(:not_vulnerable) do
    cve_hash = {}
    cve_not_vuln = []
    facts.each do |k,v|
      if k =~ /^cve_/
        if v == 'not_vulnerable'
          cve_not_vuln << k
        end
      end
    end
    cve_hash["not_vulnerable"] = cve_not_vuln
    cve_hash
  end
end
