# Ruby 1.9 introduces BasicObject, until then use this approximation from here:
# http://onestepback.org/index.cgi/Tech/Ruby/BlankSlate.rdoc
if ActiveSupport.version.to_s[0].to_i < 4
  class BasicObject < ActiveSupport::BasicObject
  end
else
  class BasicObject < ActiveSupport::ProxyObject
  end
end
