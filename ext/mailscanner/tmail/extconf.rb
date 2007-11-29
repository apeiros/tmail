require 'mkmf'
require 'rbconfig'

extension_name = 'mailscanner'

arch = Config::CONFIG['sitearch']

windows = (/djgpp|(cyg|ms|bcc)win|mingw/ =~ arch)

if (ENV['NORUBYEXT'] == 'true')
  File.open('Makefile', 'w') do |f|
    f << "all:\n"
    f << "install:\n"
  end
else
  #dir_config(extension_name)
  if windows && ENV['make'].nil?
    $LIBS += " msvcprt.lib"
  else
    $CFLAGS += " -D_FILE_OFFSET_BITS=64"  #???
  end
  create_makefile(extension_name)
end

