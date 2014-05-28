module Puppet::Parser::Functions
  newfunction(:tsm_generate_rand_string, :type => :rvalue) do |args|
    len = args[0] ? args[0].to_i : 24

    flags = File::RDONLY
    flags |= File::NONBLOCK if defined? File::NONBLOCK
    flags |= File::NOCTTY if defined? File::NOCTTY
    File.open('/dev/urandom', flags) do |urandom|
      urandom.readpartial(len).unpack("H*")[0]
    end
  end
end
