# -*- encoding: utf-8 -*-
require File.expand_path('../lib/spritesheet/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nils Riedemann"]
  gem.email         = ["nils.riedemann@gmail.com"]
  gem.description   = %q{A small gem to convert .gifs to sprites}
  gem.summary       = %q{converts gifs to spritesheets that can be used by other libraries such as EaselJS}
  gem.homepage      = "https://github.com/noxoc/SpriteSheet"

  gem.add_runtime_dependency 'RMagick'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "spritesheet"
  gem.require_paths = ["lib"]
  gem.version       = Spritesheet::VERSION
end
