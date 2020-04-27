# Changelog

## v1.1.0, 2020-04-27

### Added

### Edited

### Fixed

- linked_list_impl.rb 'require' data_library statement.
- Tests using 'STRING_DATA' and 'TIME_DATA'. 'STRING_DATA' and 'TIME_DATA' were 
substituted.

## v1.0.0, 2020-04-22

### Added

- YARDocumentation.
- 'initialize(d_or_n = nil)', 'clone()', 'size()', 'empty?()', 
'==(inst = nil)', '===(inst = nil', 'inspect()', 'remove(n = nil)', 
'insert(node1 = nil, node2 = nil)', '[](position = nil)', 
'[]=(position = nil, data = nil)', 'iterator()', 'initialize_node(dti = nil)', 
'size=(integer = nil)', 'base()', 'base=(node = nil)', and 'at(position = nil)'.
- .yardopts file.
- README.md.
- InspectHelper module.
- InspectHelper tests.
- 'require' and include helper statements.
- 'shallow_clone()', 'attach_nodes(n1 = nil, n2 = nil)', 'detach_nodes(n1
 = nil, n2 = nil)', and 'detach(n = nil)' methods.
- Tests covering additions, editions, and deletions.

### Edited

- Rewrote 'clone()', 'inspect()', 'remove(n = nil)', and 
'insert(node1 = nil, node2 = nil)'.
- 'base()' privacy. Protected method.
- Deleted '[](position = nil)', '[]=(position = nil, data = nil)', and 
'at(position = nil)' methods.
- Deleted Travis CI deployment settings.
- Dependency linked_list_int's Major Version number.

### Fixed

- Minor Version number.
