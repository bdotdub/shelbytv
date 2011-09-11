# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shelbytv}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Benny Wong"]
  s.date = %q{2011-09-10}
  s.email = %q{benny@bwong.net}
  s.files = [
    "examples/simple_app.rb",
    "lib/shelbytv",
    "lib/shelbytv/base.rb",
    "lib/shelbytv/broadcast.rb",
    "lib/shelbytv/channel.rb",
    "lib/shelbytv/channel_proxy.rb",
    "lib/shelbytv/user.rb",
    "lib/shelbytv/user_proxy.rb",
    "lib/shelbytv.rb",
    "README.md",
    "spec/UHHHHHH"
  ]
  s.homepage = %q{https://github.com/bdotdub/shelbytv}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Shelby.tv API wrapper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_dependency 'oauth', '~> 0.4.0'
        s.add_dependency 'json', '>= 0'
    else
      s.add_dependency 'oauth', '~> 0.4.0'
      s.add_dependency 'json', '>= 0'
    end
  else
    s.add_dependency 'oauth', '~> 0.4.0'
    s.add_dependency 'json', '>= 0'
  end
end
