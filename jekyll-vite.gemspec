# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('./lib', __dir__)
require 'jekyll/vite/version'

Gem::Specification.new do |s|
  s.name     = 'jekyll-vite'
  s.version  = Jekyll::Vite::VERSION
  s.authors  = ['Máximo Mussini']
  s.email    = ['maximomussini@gmail.com']
  s.summary  = 'Use Vite.js in Jekyll and enjoy a modern assets pipeline'
  s.homepage = 'https://github.com/ElMassimo/jekyll-vite'
  s.license  = 'MIT'
  s.metadata = {
    'source_code_uri' => "https://github.com/ElMassimo/jekyll-vite/tree/v#{ Jekyll::Vite::VERSION }",
    'changelog_uri' => "https://github.com/ElMassimo/jekyll-vite/blob/v#{ Jekyll::Vite::VERSION }/CHANGELOG.md",
  }

  s.required_ruby_version = Gem::Requirement.new('>= 2.4')

  s.add_dependency 'jekyll', '>= 3', '< 5'
  s.add_dependency 'vite_ruby', '>= 1.2.14', '< 2'
  s.add_development_dependency 'webrick'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov', '< 0.18'

  s.files = Dir.glob('{lib,templates}/**/*') + %w[README.md CHANGELOG.md LICENSE.txt]
  s.test_files = `git ls-files -- test/*`.split("\n")
end
