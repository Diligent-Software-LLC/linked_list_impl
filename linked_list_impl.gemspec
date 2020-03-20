require_relative 'lib/linked_list_impl/version'

Gem::Specification.new do |spec|

  spec.name                  = "linked_list_impl"
  spec.version               = LinkedList::VERSION
  spec.authors               = ["Bradley J. Tannor", "Diligent Software LLC"]
  spec.email                 = ["bradleytannor@gmail.com"]
  spec.summary               = %q{A LinkedList implementation. Implements the
linked_list_int interface.}
  spec.description           = %q{A LinkedList implementation. Implements the
linked_list_int interface. Donations support continuous improvement and maintenance. The aim is a reliable,
integrable, and endurable LinkedList library. Make a donation at the 
project's collective page: https://opencollective.com/linkedlist.
One-time and recurring donations are available at $1, $2, $4, $8, and $16. 
Greatly appreciated.}
  spec.homepage              =
      "https://docs.diligentsoftware.org/linkedlist-1/implementation"
  spec.license               = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.5")

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] =
      "https://github.com/Diligent-Software-LLC/linked_list_impl"
  spec.metadata['changelog_uri']   =
      "https://docs.diligentsoftware.org/linkedlist-1/implementation#changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development and testing dependencies
  spec.add_development_dependency 'bundler', '~> 2.1.2'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'linked_list_int', '~> 0.1.0'
  spec.add_development_dependency 'node_error', '~> 2.0.0'
  spec.add_development_dependency 'data_error_library', '~> 0.1.0'
  spec.add_development_dependency 'node', '~> 2.0.0'

  # Gem specific runtime dependencies
  spec.add_runtime_dependency 'linked_list_int', '~> 0.1.0'
  spec.add_runtime_dependency 'node_error', '~> 2.0.0'
  spec.add_runtime_dependency 'data_error_library', '~> 0.1.0'
  spec.add_runtime_dependency 'node', '~> 2.0.0'

end

