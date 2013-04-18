# Ruby 1.9 introduces BasicObject, until then use this approximation from here:
# http://onestepback.org/index.cgi/Tech/Ruby/BlankSlate.rdoc
unless defined? BasicObject
  class BasicObject < ActiveSupport::BasicObject
  end
end
