#!/usr/bin/env ruby

#Create the combined.pem file for developer and production by processing two of
#the three important files

source_p12_file_name = "pub_and_priv_certificates.p12"
dest =                 "compiled_from_two_of_the_three_important_files"

basedir = Dir.pwd

%w{developer production}.each do |type|

  Dir.chdir basedir + "/" + type

  tmp_ident_pem = "#{dest}/tmp_aps_#{type}_identity.pem"
  tmp_pem_from_p12 = "#{dest}/tmp_pem_from_p12.pem"

  #Using two of the three *important files* create two temporary intermediate files
  `../helper_scripts/cer-to-pem.sh type_specific_important_file_used_to_compile_combined_pem/aps_#{type}_identity.cer #{tmp_ident_pem}`
  `../helper_scripts/p12-to-pem.sh ../shared_important_files/used_to_compile_combined_pem/#{source_p12_file_name} #{tmp_pem_from_p12}`

  #Combine the two intermediate files into a "combined.pem", which is used to
  #connect to the apple server
  `cat #{tmp_ident_pem} #{tmp_pem_from_p12} > #{dest}/combined.pem`

  #Now that you've created the combined.pem file, you can remove the temporary
  #intermediate files
  `rm #{tmp_ident_pem} #{tmp_pem_from_p12}`
end
