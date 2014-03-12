Gem::Specification.new do |s|
  s.name               = "automate-it"
  s.version            = '0.9.2'
  s.default_executable = "automateit"
  s.license            = 'GNU-GPL'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Igal Koshevoy", "Pavel Novotny"]
  s.date = %q{2013-05-16}
  s.description = %q{AutomateIt is an open source tool for automating the setup and maintenance of servers, applications and their dependencies. This is updated fork.}
  s.email = %q{fandisek@gmail.com}
  s.homepage = %q{http://rubygems.org/gems/automate-it}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Fork of AutomateIt}
  s.bindir = 'bin'

  s.add_dependency 'hoe'
  s.add_dependency 'open4'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
