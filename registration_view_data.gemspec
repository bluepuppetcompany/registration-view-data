# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name = 'registration_view_data'
  spec.version = '0.0.0'
  spec.summary = 'Registration View Data'
  spec.description = ' '

  spec.authors = ['Joseph Choe']
  spec.email = ['joseph@josephchoe.com']
  spec.homepage = 'https://github.com/bluepuppetcompany/registration-view-data'

  spec.require_paths = ['lib']
  spec.files = Dir.glob('{lib}/**/*')
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6'

  spec.add_runtime_dependency 'eventide-postgres'
  spec.add_runtime_dependency 'view_data-postgres'

  spec.add_runtime_dependency 'registration-client'

  spec.add_development_dependency 'test_bench'
end
