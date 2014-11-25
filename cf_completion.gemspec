# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cf_completion/version'

Gem::Specification.new do |spec|
  spec.name          = "cf_completion"
  spec.version       = CfCompletion::VERSION
  spec.authors       = ["Sai To Yeung and Rasheed Abdul-Aziz"]
  spec.email         = ["pair+squeedee+syeung@pivotal.io"]
  spec.summary       = %q{Bash completion for the Cloud Foundry CLI}
  spec.description   = %q{Bash completion for the Cloud Foundry CLI}
  spec.homepage      = "https://github.com/cf-buildpacks/cf_completion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.post_install_message =<<-POST_INSTALL_MESSAGE
*************
cf_complete installed!

To activate cf autocompletions, run the following line:

echo "complete -C cf_completion cf" >> ~/.bash_profile

  POST_INSTALL_MESSAGE
end
