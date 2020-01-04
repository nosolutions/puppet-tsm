# This is an autogenerated function, ported from the original legacy version.
# It /should work/ as is, but will not have all the benefits of the modern
# function API. You should see the function docs to learn how to add function
# signatures for type safety and to document this function using puppet-strings.
#
# https://puppet.com/docs/puppet/latest/custom_functions_ruby.html
#
# ---- original file header ----

# ---- original file header ----
#
# @summary
#   Summarise what the function does here
#
Puppet::Functions.create_function(:'tsm::tsm_generate_rand_string') do
  # @param args
  #   The original array of arguments. Port this to individually managed params
  #   to get the full benefit of the modern function API.
  #
  # @return [Data type]
  #   Describe what the function returns here
  #
  dispatch :default_impl do
    # Call the method named 'default_impl' when this is matched
    # Port this to match individual params for better type safety
    repeated_param 'Any', :args
  end


  def default_impl(*args)
    
    len = args[0] ? args[0].to_i : 24

    flags = File::RDONLY
    flags |= File::NONBLOCK if defined? File::NONBLOCK
    flags |= File::NOCTTY if defined? File::NOCTTY
    File.open('/dev/urandom', flags) do |urandom|
      urandom.readpartial(len).unpack("H*")[0]
    end
  
  end
end
