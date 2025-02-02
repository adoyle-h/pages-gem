# frozen_string_literal: true

require File.expand_path("lib/github-pages/dependencies", __dir__)
require File.expand_path("lib/github-pages/plugins", __dir__)
require File.expand_path("lib/github-pages/version", __dir__)

Gem::Specification.new do |s|
  s.required_ruby_version = ">= 2.3.0"

  s.name                  = "ad-github-pages"
  s.version               = GitHubPages::VERSION
  s.summary               = "Track GitHub Pages dependencies."
  s.description           = "Bootstrap the GitHub Pages Jekyll environment locally."
  s.authors               = "GitHub, Inc. & ADoyle"
  s.email                 = "adoyle.h@gmail.com"
  s.homepage              = "https://github.com/adoyle-h/pages-gem"
  s.license               = "MIT"
  s.metadata = {
    "homepage_uri" => "https://github.com/adoyle-h/pages-gem",
    "source_code_uri" => "https://github.com/adoyle-h/pages-gem"
  }

  all_files               = `git ls-files -z`.split("\x0")
  s.files                 = all_files.grep(%r{^(bin|lib)/|^.rubocop.yml$})
  s.executables           = all_files.grep(%r{^bin/}) { |f| File.basename(f) }

  GitHubPages::Dependencies.gems.each do |gem, version|
    s.add_dependency(gem, "= #{version}")
  end

  s.add_dependency("mercenary", "~> 0.3")
  s.add_dependency("nokogiri", ">= 1.13.6", "< 2.0")
  s.add_dependency("terminal-table", "~> 1.4")
  s.add_development_dependency("jekyll_test_plugin_malicious", "~> 0.2")
  s.add_development_dependency("pry", "~> 0.10")
  s.add_development_dependency("rspec", "~> 3.3")
  s.add_development_dependency("rubocop-github", "0.20.0")
end
