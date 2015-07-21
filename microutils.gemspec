Gem::Specification.new do |s|
  s.name        = 'microutils'
  s.version     = '0.0.1'
  s.date        = '2015-07-16'
  s.summary     = "Small utilities to create well structured ruby apps"
  s.description = "Includes: enhancements to Time:class"
  s.authors     = ["David Pelaez"]
  s.email       = 'david@vlipco.com'
  s.files       = [ 
    "lib/microutils.rb", 
    "lib/microutils/time.rb", 
    "lib/microutils/environment.rb",
    "lib/microutils/metrics.rb"
    ]
  s.homepage    = 'https://github.com/vlipco/microutils'
  s.license       = 'MIT'
  
  s.add_development_dependency 'rspec', '~> 3.3.0'
  s.add_development_dependency 'byebug'
  
  s.add_runtime_dependency 'keen', '~> 0.9.0'
  s.add_runtime_dependency 'em-http-request', '~> 1.0'

end