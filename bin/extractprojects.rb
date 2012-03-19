#!/usr/bin/env ruby


Dir.glob("*.{tgz,gz,zip}") { |fn|
  puts File.basename(fn)
  base = File.basename(fn, ".*")
  ext = File.extname(fn)
  puts
  prevwd = Dir.getwd()
  Dir.mkdir(base)
  Dir.chdir(base)
  fullfn = File.join(prevwd, fn)
  case ext
  when ".tgz" then `tar zxvf #{fullfn}`
  when".gz" then `tar zxvf #{fullfn}`
  when ".zip" then `unzip #{fullfn}`
  end
  Dir.chdir(prevwd)
}

# for fn in *{gz,zip}; do
#     echo "-- ${fn}"
#     BASEFN=$(basename $fn)
#     EXT=${BASEFN##*.}
#     FILEN=${BASEFN%.*}
#     echo ${FILEN}
#     echo ${EXT}
#     echo
# done


