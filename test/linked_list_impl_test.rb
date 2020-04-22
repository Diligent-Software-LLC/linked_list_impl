require_relative 'test_helper'

# LinkedListTest.
# @class_description
#   Tests the LinkedList class.
class LinkedListTest < Minitest::Test

  # Constants.
  CLASS = LinkedList

  NIL_DATA        = nil
  INTEGER_DATA    = 2
  FALSECLASS_DATA = false
  TRUECLASS_DATA  = true
  SYMBOL_DATA     = :test_symbol
  STRING_DATA     = 'test'
  TIME_DATA       = Time.now()
  COMPLEX_DATA    = Complex(1)
  FLOAT_DATA      = 0.0
  INVALID_DATA    = {}

  ZERO = 0
  ONE  = 1
  TWO  = 2

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md, and
  #   .yardopts files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')

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
    @node = Node.new(NIL_DATA, INTEGER_DATA, NIL_DATA)
  end

  # initialize(d_or_n = nil)

  # test_init_x1().
  # @description
  #   A valid DataType type instance argument.
  def test_init_x1()

    x1_l  = CLASS.new(INTEGER_DATA)
    x1_it = x1_l.iterator()
    assert_same(INTEGER_DATA, x1_it.data())

  end

  # test_init_x2().
  # @description
  #   A Node instance.
  def test_init_x2()

    x2_l  = CLASS.new(@node)
    x2_it = x2_l.iterator()
    assert_operator(x2_it, 'identical_node?', @node)

  end

  # test_init_x3().
  # @description
  #   An invalid argument.
  def test_init_x3()
    assert_raises(ArgumentError) { CLASS.new(INVALID_DATA) }
  end

  # test_init_x4().
  # @description
  #   No arguments.
  def test_init_x4()

    x4_init = CLASS.new()
    x4_it   = x4_init.iterator()
    assert_same(x4_it.data(), NIL_DATA)

  end

  # clone()

  # test_clone_x1().
  # @description
  #   The list is empty.
  def test_clone_x1()

    x1_l = CLASS.new(@node)
    x1_l.remove(@node)
    l_clone = x1_l.clone()
    assert_same(x1_l.size(), l_clone.size())
    assert_raises(NodeError) { x1_l.iterator() }
    assert_raises(NodeError) { l_clone.iterator() }

  end

  # test_clone_x2().
  # @description
  #   The list size is greater than 0.
  def test_clone_x2()

    x2_l    = CLASS.new(@node)
    x2_it   = x2_l.iterator()
    x2_l_c  = x2_l.clone()
    x2_c_it = x2_l_c.iterator()
    assert_operator(x2_c_it, 'identical_node?', @node)
    assert_same(x2_l.size(), x2_l_c.size())

  end

  # test_clone_x3().
  # @description
  #   Cloning a list sizing greater than 1. The lists are attributively equal
  #   and identically unequal.
  def test_clone_x3()

    x3_1  = LinkedList.new(@node)
    ins_n = Node.new(NIL_DATA, SYMBOL_DATA, NIL_DATA)
    x3_l.insert(ins_n, @node)
    x3_l_c = x3_l.clone()
    assert_equal(x3_l, x3_l_c)
    refute_same(x3_l, x3_l_c)

  end

  # size()

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
    ins_n = Node.new(NIL_DATA, COMPLEX_DATA, NIL_DATA)
    x3_l.insert(ins_n, @node)
    assert_same(TWO, x3_l.size())

  end

  # empty?()

  # test_empty_x1().
  # @description
  #   An empty list contains zero nodes.
  def test_empty_x1()

    x1_l = LinkedList.new(@node)
    x1_l.remove(@node)
    assert_predicate(x1_l, :empty?)

  end

  # test_empty_x2().
  # @description
  #   A list containing greater than zero nodes is not empty.
  def test_empty_x2()
    x2_l = LinkedList.new(@node)
    refute_predicate(x2_l, :empty?)
  end

  # ==(inst = nil)

  # test_attr_eq_op_x1().
  # @description
  #   A clone attributively equals its origin.
  def test_attr_eq_op_x1()

    x1_l  = LinkedList.new(@node)
    clone = x1_l.clone()
    assert_operator(clone, '==', x1_l)

  end

  # ===(inst = nil)

  # test_identity_op_x1().
  # @description
  #   A list identically equals itself.
  def test_identity_op_x1()
    x1_l = LinkedList.new(@node)
    assert_operator(x1_l, '===', x1_l)
  end

  # test_identity_op_x2().
  # @description
  #   Comparing an instance type other than LinkedList.
  def test_identity_op_x2()
    x2_l = LinkedList.new(@node)
    refute_operator(x2_l, '===', SYMBOL_DATA)
  end

  # inspect()

  # test_insp_x1a().
  # @description
  #   An empty list inspection returns a String containing a nil between pipes.
  def test_insp_x1a()

    x1_l = CLASS.new(@node)
    x1_l.remove(@node)
    expected = '| nil |'
    assert_equal(expected, x.inspect())

  end

  # test_insp_x1b()
  # @description
  #   A list containing one node. Returns the arrowless inspection.
  def test_insp_x1b()

    x1_l     = CLASS.new(@node)
    expected = "| base: #{@node.to_s()} |\n|         data: #{@node.data()}" +
        "           |"
    assert_equal(expected, x1_l.inspect())

  end

  # test_insp_x1c().
  # @description
  #   A list sizing greater than one. The nodes' rows concatenated and newline
  #   separated.
  def test_insp_x1c()

    x1_l = CLASS.new(@node)
    x1_l.insert(Node.new(nil, STRING_DATA, nil), @node)
    expected = "| base: #{@node.to_s()} |-->| #{ins_n.to_s()} |\n|         " +
        "data: #{@node.data()}          |<--|         data: #{ins_n.data()}" +
        "        |"
    assert_equal(expected, x1_l.inspect())

  end

  # remove(n = nil)

  # test_remove_x1().
  # @description
  #   The list is empty.
  def test_remove_x1()

    x1_l = CLASS.new(@node)
    x1_l.remove(@node)
    assert_raises(NodeError) {
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
    assert_raises(NodeError) {
      x2_l.iterator()
    }

  end

  # test_remove_x3().
  # @description
  #   A list size greater than one.
  def test_remove_x3()

    x3_l = CLASS.new(@node)
    n_n  = Node.new(nil, STRING_DATA, nil)
    x3_l.insert(n_n, @node)
    x3_l.remove(n_n)
    x3_it = x3_l.iterator()
    assert_operator(x3_it, 'identical_node?', @node)
    assert_same(ONE, x3_l.size())

  end

  # test_remove_x4().
  # @description
  #   The argument is not a Node instance.
  def test_remove_x4()

    assert_raises(NodeError) {
      x4_l = CLASS.new()
      x4_l.remove(NIL_DATA)
    }

  end

  # test_remove_x5().
  # @description
  #   The argument is a list element.
  def test_remove_x5()

    x5_l = CLASS.new(@node)
    x5_l.remove(@node)
    assert_raises(NodeError) {
      x5_l.iterator()
    }

  end

  # test_remove_x6().
  # @description
  #   The argument is not a list element. The argument is a Node.
  def test_remove_x6()

    x6_l = CLASS.new(@node)
    r_n  = Node.new(nil, SYMBOL_DATA, nil)
    x6_l.remove(r_n)
    assert_same(ONE, x6_l.size())
    x6_it = x6_l.iterator()
    assert_operator(x6_it, 'identical_node?', @node)

  end

  # test_remove_x7().
  # @description
  #   The argument Node is the list's base, and the list size is greater than
  #   one.
  def test_remove_x7()

    x7_l = CLASS.new(@node)
    n_n  = Node.new(NIL_DATA, TIME_DATA, NIL_DATA)
    x7_l.insert(n_n, @node)
    x7_l.remove(@node)
    x7_it = x7_l.iterator()
    assert_same(ONE, x7_l.size())
    assert_operator(x7_it, 'identical_node?', n_n)

  end

  # test_remove_x8().
  # @description
  #   The list size is greater than two. The removal Node's position is
  #   neither zero or last. The argument Node is a list element.
  def test_remove_x8()

    x8_l = CLASS.new(@node)
    n1   = Node.new(NIL_DATA, STRING_DATA, NIL_DATA)
    n2   = Node.new(NIL_DATA, TIME_DATA, NIL_DATA)
    x8_l.insert(n1, @node)
    x8_l.insert(n2, n1)
    x8_l.remove(n1)
    x8_it = x8_l.iterator()
    assert_operator(x8_it, 'identical_node?', @node)
    x8_it.next()
    assert_operator(x8_it, 'identical_node?', n2)

  end

  # insert(node1 = nil, node2 = nil)

  # test_ins_x1().
  # @description
  #   The insertion node is not a Node instance.
  def test_ins_x1()

    assert_raises(NodeError) {
      x1_l = CLASS.new(@node)
      x1_l.insert(FALSECLASS_DATA, @node)
    }

  end

  # test_ins_x2().
  # @description
  #   The precessional Node argument is not a Node instance.
  def test_ins_x2()

    assert_raises(NodeError) {
      x1_l = CLASS.new(@node)
      x1_l.insert(Node.new(nil, TIME_DATA, nil), SYMBOL_DATA)
    }

  end

  # test_ins_x3().
  # @description
  #   Neither arguments are Node instances.
  def test_ins_x3()

    assert_raises(NodeError) {
      x3_l = CLASS.new(@node)
      x3_l.insert(STRING_DATA, SYMBOL_DATA)
    }

  end

  # test_ins_x4().
  # @description
  #   The precessional Node argument is not a list element.
  def test_ins_x4()

    x4_l     = CLASS.new(@node)
    pre_size = x4_l.size()
    x4_l.insert(Node.new(nil, INTEGER_DATA, nil), Node.new(nil, STRING_DATA,
                                                           nil))
    x4_it = x4_l.iterator()
    assert_same(pre_size, x4_l.size())

  end

  # test_ins_x5().
  # @description
  #   The precessional Node argument is a list element. The insertion Node
  #   argument is valid.
  def test_ins_x5()

    ins_node = Node.new(nil, STRING_DATA, nil)
    x5_l     = CLASS.new(@node)
    x5_l.insert(ins_node, @node)
    l_it = x5_l.iterator()
    l_it.next()
    assert_operator(l_it, 'identical_node?', ins_node)

  end

  # test_ins_x6().
  # @description
  #   The insertion Node argument is a list element.
  def test_ins_x6()

    assert_raises(ArgumentError) {
      x6_l = CLASS.new(@node)
      x6_l.insert(@node, nil)
    }

  end

  # test_ins_x7().
  # @description
  # A list sizing greater than zero inserts a node at the position index. Size
  # increments.
  def test_ins_x7()
    # xb       = @y1_inst
    # pre_size = xb.size()
    # xb.insert_at(0, @x4_data)
    # post_size = xb.size()
    # assert_same(pre_size + 1, post_size)
    # ins_data = xb[0]
    # assert_same(@x4_data, ins_data)
  end

  # test_ins_x8().
  # @description
  # Inserting data in an empty list raises an IndexError.
  def test_ins_x8()
    x8_l = LinkedList.new(@node)
    x8_l.remove(@node)
    assert_raises(NodeError) {
      x8_l.insert(@node, nil)
    }
  end

  # [](position = nil)

  # test_subscript_x1().
  # @description
  #   The data and the original are identical.
  def test_subscript_x1()

    x1_l = LinkedList.new(@node)
    d    = x1_l[ZERO]
    assert_same(@node.data(), d)

  end

  # test_subscript_x1b().
  # @description
  #   Calling the subscript operator on an empty list.
  def test_subscript_x1b()

    x1b_l = LinkedList.new(@node)
    x1b_l.remove(@node)
    assert_raises(IndexError) {
      x1b_l[ZERO]
    }

  end

  # test_subscript_x2b().
  # @description
  #   Arguing a negative integer or an integer greater than or equalling size
  #   raises an IndexError. Any object other than an Integer instance raises an
  #   ArgumentError.
  def test_subscript_x2b()

    x2b_l   = LinkedList.new(@node)
    neg_int = -1
    assert_raises(IndexError) {
      x2b_l[neg_int]
    }
    upper_bound_i = x2b_l.size()
    assert_raises(IndexError) {
      x2b_l[upper_bound_i]
    }
    illegal_type_name = 0.0
    assert_raises(ArgumentError) {
      x2b_l[illegal_type_name]
    }

  end

  # []=(position = nil, dti = nil)

  # test_subs_ass_x1b().
  # @description
  #   Assigning valid data.
  def test_subs_ass_x1b()

    x1b_l       = LinkedList.new(@node)
    x1b_l[ZERO] = COMPLEX_DATA
    assert_same(x1b_l[ZERO], COMPLEX_DATA)

  end

  # test_subs_ass_x1a().
  # @description
  #   Calling the subscript assignment operator on an empty list.
  def test_subs_ass_x1a()

    x1a_l = LinkedList.new(@node)
    x1a_l.remove(@node)
    assert_raises(IndexError) {
      x1a_l[ZERO] = STRING_DATA
    }

  end

  # test_subs_ass_x2bc().
  # @description
  #   Arguing a position less than zero or greater than or equalling size.
  def test_subs_ass_x2bc()

    x2bc_l = LinkedList.new(@node)
    b      = -1
    c      = x2bc_l.size()
    assert_raises(IndexError) {
      x2bc_l[b] = NIL_DATA
    }
    assert_raises(IndexError) {
      x2bc_l[c] = NIL_DATA
    }

  end

  # test_subs_ass_x2d().
  # @description
  #   Arguing a position instance type anything excluding Integer.
  def test_subs_ass_x2d()

    x2d_l = LinkedList.new(@node)
    assert_raises(ArgumentError) {
      x2d_l[FLOAT_DATA] = NIL_DATA
    }

  end

  # test_subs_ass_x3b().
  # @description
  #   Arguing invalid data.
  def test_subs_ass_x3b()

    x3b_l = LinkedList.new(@node)
    assert_raises(DataError) {
      x3b_l[ZERO] = INVALID_DATA
    }

  end

  # iterator()

  # test_it_x1().
  # @description
  #   An empty list.
  def test_it_x1()

    assert_raises(NodeError) {
      x1_l = CLASS.new(@node)
      x1_l.remove(@node)
      x1_l.iterator()
    }

  end

  # test_it_x2().
  # @description
  #   The list's base node is not nil.
  def test_it_x2()

    x2_l  = CLASS.new(@node)
    x2_it = x2_l.iterator()
    assert_operator(x2_it, 'identical_node?', @node)

  end

  # teardown().
  # @description
  # Cleanup.
  def teardown()
  end

end
