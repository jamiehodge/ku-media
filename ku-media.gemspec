# -*- encoding: utf-8 -*-

require File.expand_path('../lib/ku/media/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors         = ['jamiehodge']
  gem.email           = ['jamiehodge@me.com']
  gem.description     = 'KU media service'
  gem.summary         = 'KU media service'
  gem.homepage        = ''
    
  gem.files           = `git ls-files`.split($\)
  gem.executables     = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files      = gem.files.grep(%r{^(test|spec|features)/})
  gem.name            = 'ku-media'
  gem.require_paths   = ['lib']
  gem.version         = KU::Media::VERSION
  
  gem.add_dependency  'sequel'
  gem.add_dependency  'sequel_pg'
  gem.add_dependency  'ku-ldap'
  gem.add_dependency  'addressable'
  gem.add_dependency  'nokogiri'
end

