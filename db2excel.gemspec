# -*- encoding: utf-8 -*-
require File.expand_path('../lib/db2excel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Yury Korolev"]
  gem.email         = ["yury.korolev@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "db2excel"
  gem.require_paths = ["lib"]
  gem.version       = Db2Excel::VERSION

  gem.add_dependency "multi_json"
end
