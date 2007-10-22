# == AddressManager::OpenBSD
#
# A OpenBSD-specific driver for the AddressManager provides complete support for
# querying, adding and removing addresses.
class AutomateIt::AddressManager::OpenBSD < AutomateIt::AddressManager::BaseDriver
  def self.token
    :openbsd
  end

  depends_on :programs => %w(ifconfig uname),
    :callbacks => lambda{`uname -s`.match(/openbsd/i)}

  def suitability(method, *args) # :nodoc:
    # Must be higher than ::BSD
    available? ? 3 : 0
  end

  # See AddressManager#add
  def add(opts)
    _add_helper(opts) do |opts|
      interpreter.sh(_openbsd_ifconfig_helper(:add, opts))
    end
  end

  # See AddressManager#remove
  def remove(opts)
    _remove_helper(opts) do |opts|
      interpreter.sh(_openbsd_ifconfig_helper(:remove, opts))
      true
    end
  end
  
  # See AddressManager#addresses
  def addresses()
    _raise_unless_available
    # OpenBSD requires an "-A" to display aliases, not the usual "-a"
    return `ifconfig -A`.scan(/\s+inet\s+([^\s]+)\s+/).flatten
  end
  
  # See AddressManager#has?
  def has?(opts)
    opts2 = opts.clone
    is_alias = opts2.delete(:label)
    return super(opts2)
  end
  
protected

  def _openbsd_ifconfig_helper(action, opts)
    # ifconfig dc0 inet alias 192.168.0.3 netmask 255.255.255.255
    opts2 = opts.clone
    is_alias = opts2.delete(:label)
    
    cmd = _ifconfig_helper(action, opts2)
    replacement = "inet"
    if is_alias
      cmd.gsub!(/ (up|down)$/, '')

      case action
      when :add
        replacement << " alias" 
      when :remove
        replacement << " delete"
      else
        raise ArgumentError.new("Unknown action: #{action}")
      end
    end
    cmd.gsub!(/(ifconfig\s+[^\s]+\s+)/, '\1'+replacement+' ')
    
    return cmd
  end
end
