
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MoneyManager/version'

Gem::Specification.new do |spec|
  spec.name          = 'MoneyManager'
  spec.version       = Moneymanager::VERSION
  spec.authors       = ['ignazioc']
  spec.email         = ['ignazioc@gmail.com']

  spec.summary       = 'Import dta from your bank and manage your money'
  spec.description   = 'Import dta from your bank and manage your money'
  spec.homepage      = 'https://www.github.com/ignazioc/moneymanager'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'commander'
  spec.add_dependency 'colorize'
  spec.add_dependency 'terminal-table'
  spec.add_dependency 'tty-prompt'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
