require_relative 'test_helper'

# LinkedListTest.
# @class_description
#   Tests the LinkedList class.
class LinkedListTest < Minitest::Test

  # Constants.
  CLASS = LinkedList
  NILCLASS_I = nil
  INTEGER_DATA    = 2
  FALSECLASS_DATA = false
  TRUECLASS_DATA  = true
  TEST_SYMBOL     = :test_symbol
  COMPLEX_DATA    = Complex(1)
  TEST_FLOAT      = 0.0
  INVALID_DATA    = {}
  ZERO = 0
  ONE  = 1
  TWO  = 2

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   .yardopts, .gitignore, Changelog.md, CODE_OF_CONDUCT.md,
  #   linked_list_impl.gemspec, Gemfile.lock, and Rakefile files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')
    assert_path_exists('.gitignore')
    assert_path_exists('Changelog.md')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('linked_list_impl.gemspec')
    assert_path_exists('Gemfile.lock')
    assert_path_exists('Rakefile')

  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(CLASS::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()

    @node = Node.new(NILCLASS_I, INTEGER_DATA, NILCLASS_I)
    @empty_list = LinkedList.new(@node)
    @empty_list.remove(@node)

  end

  # initialize(d_or_n = nil).

  # test_init_x1().
  # @description
  #   A valid DataType type instance argument.
  def test_init_x1()
    x1_l  = CLASS.new(INTEGER_DATA)
    assert_same(x1_l.size(), ONE)
  end

  # test_init_x2().
  # @description
  #   A Node instance.
  def test_init_x2()
    x2_l  = CLASS.new(@node)
    assert_same(x2_l.size(), ONE)
  end

  # test_init_x3().
  # @description
  #   A NodeAdapter argument.
  def test_init_x3()

    na = NodeAdapter.new(@node)
    r = LinkedList.new(na)
    assert_instance_of(LinkedList, r)
    refute_predicate(r, :empty)

  end

  # test_init_x4().
  # @description
  #   Any object excluding DataType type and Node family instances.
  def test_init_x4()

    assert_raises(ArgumentError, "#{INVALID_DATA} is not a DataType type
instance or a Node family type instance.") {
      LinkedList.new(INVALID_DATA)
    }

  end

  # shallow_clone().

  # test_sc_x1().
  # @description
  #   An empty list.
  def test_sc_x1()

    s_c = @empty_list.shallow_clone()
    refute_same(s_c, @empty_list)
    assert_equal(s_c, @empty_list)

  end

  # test_sc_x2().
  # @description
  #   A size one list.
  def test_sc_x2()

    list = LinkedList.new(@node)
    s_c = list.shallow_clone()
    refute_same(list, s_c)
    assert_equal(list, s_c)

  end

  # test_sc_x3().
  # @description
  #   A list size greater than one.
  def test_sc_x3()

    n1   = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    x3_l = LinkedList.new(@node)
    x3_l.insert(n1, @node)
    s_c = x3_l.shallow_clone()
    refute_same(x3_l, s_c)
    assert_equal(x3_l, s_c)

  end

  # test_sc_x4().
  # @description
  #   The list is frozen.
  def test_sc_x4()

    list = LinkedList.new(@node_adapter)
    list.freeze()
    clone = list.shallow_clone()
    refute_same(list, clone)
    assert_predicate(clone, :frozen?)

  end

  # clone_df().

  # test_cdf_x1().
  # @description
  #   An empty list.
  def test_cdf_x1()

    clone = @empty_list.clone_df()
    assert_equal(clone, @empty_list)
    refute_same(clone, @empty_list)

  end

  # test_cdf_x2().
  # @description
  #   The list size is one.
  def test_cdf_x2()

    list = LinkedList.new(@node)
    clone = list.clone_df()
    refute_same(list, clone)
    refute_equal(list, clone)

  end

  # test_cdf_x3().
  # @description
  #   A list size greater than one.
  def test_cdf_x3()

    list = LinkedList.new(@node)
    insertion = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)
    list.insert(insertion, @node)
    clone = list.clone_df()
    refute_same(clone, list)
    refute_equal(clone, list)

  end

  # test_cdf_x4().
  # @description
  #   The list is frozen.
  def test_cdf_x4()

    list = LinkedList.new(@node_adapter)
    list.freeze()
    clone = list.shallow_clone()
    refute_same(list, clone)
    assert_predicate(clone, :frozen?)

  end

  # size().

  # test_size_x1().
  # @description
  #   An empty list.
  def test_size_x1()

    x1_l = LinkedList.new(@node)
    x1_l.remove(@node)
    assert_same(ZERO, x1_l.size())

  end

  # test_size_x2().
  # @description
  #   A LinkedList containing one Node is size 1.
  def test_size_x2()
    x2_l = LinkedList.new(@node)
    assert_same(ONE, x2_l.size())
  end

  # test_size_x3().
  # @description
  #   A LinkedList containing two nodes is size 2.
  def test_size_x3()

    x3_l  = LinkedList.new(@node)
    ins_n = Node.new(NILCLASS_I, COMPLEX_DATA, NILCLASS_I)
    x3_l.insert(ins_n, @node)
    assert_same(TWO, x3_l.size())

  end

  # exists(n = nil).

  # test_exists_x1().
  # @description
  #   The argument is not a list element.
  def test_exists_x1()
    refute_operator(@empty_list, 'exists', @node)
  end

  # test_exists_x2().
  # @description
  #   The argument is a list element.
  def test_exists_x2()
    list = LinkedList.new(@node)
    assert_operator(list, 'exists', @node)
  end

  # empty().

  # test_empty_x1().
  # @description
  #   An empty list contains zero nodes.
  def test_empty_x1()

    x1_l = LinkedList.new(@node)
    x1_l.remove(@node)
    assert_predicate(x1_l, :empty)

  end

  # test_empty_x2().
  # @description
  #   A list containing greater than zero nodes is not empty.
  def test_empty_x2()
    x2_l = LinkedList.new(@node)
    refute_predicate(x2_l, :empty)
  end

  # ==(object = nil).

  # test_attreq_x1().
  # @description
  #   A shallow clone attributively equals its origin.
  def test_attreq_x1()

    x1_l  = LinkedList.new(@node)
    clone = x1_l.shallow_clone()
    assert_operator(clone, '==', x1_l)

  end

  # test_attreq_x2().
  # @description
  #   An unequal 'base' or 'size'.
  def test_attreq_x2()
    list = LinkedList.new(@node)
    refute_equal(list, @empty_list)
  end

  # inspect().

  # test_insp_x1a().
  # @description
  #   An empty list inspection returns a String containing a nil between pipes.
  def test_insp_x1a()

    x1_l = CLASS.new(@node)
    x1_l.remove(@node)
    expected = '| nil |'
    assert_equal(expected, x1_l.inspect())

  end

  # test_insp_x1b().
  # @description
  #   A list containing one node. Returns the arrowless inspection.
  def test_insp_x1b()

    x1_l     = CLASS.new(@node)
    space    = ' '
    d_p_q    = (26 - 7) / 2
    padding  = space * d_p_q
    expected = "| base #{@node.to_s()} |\n" +
        "| #{padding}data: #{@node.data()}#{padding}  |"
    assert_equal(expected, x1_l.inspect())

  end

  # test_insp_x1c().
  # @description
  #   A list sizing greater than one. The nodes' rows concatenated and newline
  #   separated.
  def test_insp_x1c()

    x1_l  = CLASS.new(@node)
    ins_n    = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    x1_l.insert(ins_n, @node)
    space    = ' '
    d_p_q1   = (31 - 7) / 2
    padding1 = space * d_p_q1
    d_p_q2   = (26 - 17) / 2
    padding2 = space * d_p_q2
    expected = "| base #{@node.to_s()} |-->| #{ins_n.to_s()} |\n" +
        "| #{padding1}data: #{@node.data()}#{padding1} |<--|" +
        " #{padding2}data: #{ins_n.data()}#{padding2}  |"
    assert_equal(expected, x1_l.inspect())

  end

  # remove(n = nil).

  # test_remove_x1().
  # @description
  #   The list is empty.
  def test_remove_x1()

    x1_l = CLASS.new(@node)
    x1_l.remove(@node)
    assert_raises(ArgumentError, "#{@node} is not a list element.") {
      x1_l.remove(@node)
    }

  end

  # test_remove_x2().
  # @description
  #   A size one list.
  def test_remove_x2()

    x2_l = CLASS.new(@node)
    x2_l.remove(@node)
    assert_same(ZERO, x2_l.size())

  end

  # test_remove_x3().
  # @description
  #   A list size greater than one.
  def test_remove_x3()

    list = LinkedList.new(@node_adapter)
    n = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)
    list.insert(n, @node_adapter)
    assert_same(list.size(), TWO)
    list.remove(@node_adapter)
    assert_same(list.size(), ONE)

  end

  # test_remove_x4().
  # @description
  #   The argument is not a Node instance.
  def test_remove_x4()

    assert_raises(ArgumentError,
                  "#{TEST_SYMBOL} is not a Node family instance.") {
      @empty_list.remove(TEST_SYMBOL)
    }

  end

  # test_remove_x5().
  # @description
  #   The argument is not a list element.
  def test_remove_x5()

    list = LinkedList.new(@node_adapter)
    assert_raises(ArgumentError, "#{@node_adapter} is not a list element.") {
      list.remove(na)
    }

  end

  # test_remove_x6().
  # @description
  #   The argument is the 'base' reference, and the list size is greater than
  #   one.
  def test_remove_x6()

    list = LinkedList.new(@node_adapter)
    n2 = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    list.insert(n2, @node_adapter)
    assert_same(list.size(), TWO)
    list.remove(@node_adapter)
    assert_operator(list, 'exists', n2)
    assert_same(list.size(), ONE)

  end

  # test_remove_x7().
  # @description
  #   The removal is a 'common' Node.
  def test_remove_x7()

    x8_l = CLASS.new(@node)
    n1   = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
    n2   = Node.new(NILCLASS_I, COMPLEX_DATA, NILCLASS_I)
    na1 = NodeAdapter.new(n1)
    na2 = NodeAdapter.new(n2)
    x8_l.insert(na1, @node)
    x8_l.insert(na2, n1)
    x8_l.remove(na1)
    assert_same(x8_l.size(), TWO)
    assert_operator(x8_l, 'exists', @node_adapter)
    assert_operator(x8_l, 'exists', na2)

  end

  # insert(n1 = nil, n2 = nil).

  # test_ins_x1().
  # @description
  #   The insertion is not a Node or NodeAdapter instance.
  def test_ins_x1()

    list = LinkedList.new(@node_adapter)
    assert_raises(ArgumentError, "#{TEST_SYMBOL} is not a Node family
instance.") {
      list.insert(TEST_SYMBOL, @node_adapter)
    }

  end

  # test_ins_x2().
  # @description
  #   The precession argument is not a NodeAdapter instance.
  def test_ins_x2()

    list = LinkedList.new(@node_adapter)
    n = Node.new(NILCLASS_I, TEST_COMPLEX, NILCLASS_I)
    insertion = NodeAdapter.new(n)
    assert_raises(ArgumentError, "#{TEST_SYMBOL} is not a NodeAdapter
instance.") {
      list.insert(insertion, @node_adapter)
    }

  end

  # test_ins_x3().
  # @description
  #   The precession is not a list element.
  def test_ins_x3()

    list = LinkedList.new(@node_adapter)
    n1 = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)
    na1 = NodeAdapter.new(n1)
    n2 = Node.new(NILCLASS_I, TEST_RATIONAL, NILCLASS_I)
    na2 = NodeAdapter.new(n2)
    assert_raises(ArgumentError, "#{na2} is not a list element.") {
      list.insert(na1, na2)
    }

  end

  # test_ins_x4().
  # @description
  #   The precession is a 'common' or 'base' Node.
  def test_ins_x4()

    list = LinkedList.new(@node_adapter)
    n = Node.new(NILCLASS_I, TEST_COMPLEX, NILCLASS_I)
    insertion = NodeAdapter.new(n)
    assert_same(list.size(), ONE)
    r = list.insert(insertion, @node_adapter)
    assert_same(list.size(), TWO)
    assert_nil(r)

  end

  # test_ins_x5().
  # @description
  #   The precession is a 'lone' Node.
  def test_ins_x5()

    list = LinkedList.new(@node_adapter)
    n1 = Node.new(NILCLASS_I, TEST_COMPLEX, NILCLASS_I)
    na1 = NodeAdapter.new(n1)
    n2 = Node.new(NILCLASS_I, TEST_RATIONAL, NILCLASS_I)
    na2 = NodeAdapter.new(n2)
    list.insert(na1, @node_adapter)
    assert_same(list.size(), TWO)
    r = list.insert(na2, na1)
    assert_nil(r)
    assert_same(list.size(), THREE)
    assert_predicate(na2, :common)

  end

  # test_ins_x6().
  # @description
  #   The precession is a 'pioneer' Node.
  def test_ins_x6()

    list = LinkedList.new(@node_adapter)
    n1 = Node.new(NILCLASS_I, TEST_COMPLEX, NILCLASS_I)
    na1 = NodeAdapter.new(n1)
    list.insert(na1, @node_adapter)
    assert_same(list.size(), TWO)
    n2 = Node.new(NILCLASS_I, TEST_RATIONAL, NILCLASS_I)
    na2 = NodeAdapter.new(n2)
    r = list.insert(na2, na1)
    assert_nil(r)
    assert_same(list.size(), THREE)
    assert_predicate(na2, :pioneer)

  end

  # Protected methods.

  # size=(i = nil).

  # test_sass_x1().
  # @description
  #   'size=(i = nil)' was protected.
  def test_sass_x1()

    assert_raises(NameError) {
      @empty_list.size = 1
    }

  end

  # base().

  # test_base_x1().
  # @description
  #   'base()' was protected.
  def test_base_x1()

    assert_raises(NameError) {
      @empty_list.base()
    }

  end

  # Private methods.

  # initialize_node(dti = nil).

  # initialize_node(dti = nil).
  # @description
  #   'initialize_node(dti = nil)' is private.
  def test_initn_x1()

    assert_raises(NameError) {
      @empty_list.initialize_node(TEST_SYMBOL)
    }

  end

  # base=(n = nil).

  # test_bass_x1().
  # @description
  #   'base=(n = nil)' is private.
  def test_bass_x1()

    assert_raises(NameError) {
      @empty_list.back = @node
    }

  end

  # increment_s().

  # test_incop_x1().
  # @description
  #   'increment_s()' is private.
  def test_incop_x1()

    assert_raises(NameError) {
      @empty_list.increment_s()
    }

  end

  # decrement_s().

  # test_sdecrement_x1().
  # @description
  #   The size decrement operator is private.
  def test_sdecrement_x1()

    assert_raises(NameError) {
      @empty_list.decrement_s()
    }

  end

  # attach(n1 = nil, n2 = nil).

  # test_attach_x1().
  # @description
  #   'attach(n1 = nil, n2 = nil)' is private.
  def test_attach_x1()

    assert_raises(NameError) {
      @empty_list.attach(nil, nil)
    }

  end

  # detach(n1 = nil, n2 = nil).

  # test_detach_x1().
  # @description
  #   'detach(n1 = nil, n2 = nil)' is private.
  def test_detach_x1()

    assert_raises(NameError) {
      @empty_list.detach(nil, nil)
    }

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
