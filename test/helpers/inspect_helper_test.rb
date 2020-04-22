# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative '../test_helper'

# InspectHelperTest.
# @class_description
#   Tests the InspectHelper module.
class InspectHelperTest < Minitest::Test

  # Constants
  NILCLASS_DATA = nil
  INTEGER_DATA  = 2
  STRING_DATA   = 'test'
  SYMBOL_DATA   = :test_symbol
  FLOAT_DATA    = 0.0
  COMPLEX_DATA  = Complex(1)
  RATIONAL_DATA = Rational(2, 3)

  # setup().
  # @description
  #   Set fixtures.
  def setup()
    @node = Node.new(NILCLASS_DATA, INTEGER_DATA, NILCLASS_DATA)
  end

  # inspect_upper()

  # test_iu_x1().
  # @description
  #   A size one list.
  def test_iu_x1()

    x1_l     = LinkedList.new(@node)
    expected = "| base #{@node.to_s()} |\n"
    assert_equal(expected, x1_l.inspect_upper())

  end

  # test_iu_x2().
  # @description
  #   A size two list.
  def test_iu_x2()

    n2   = Node.new(NILCLASS_DATA, SYMBOL_DATA, NILCLASS_DATA)
    x2_l = LinkedList.new(@node)
    x2_l.insert(n2, @node)
    expected = "| base #{@node.to_s()} |-->| #{n2.to_s()} |\n"
    assert_equal(expected, x2_l.inspect_upper())

  end

  # test_iu_x3().
  # @description
  #   A size three list.
  def test_iu_x3()

    n2   = Node.new(NILCLASS_DATA, FLOAT_DATA, NILCLASS_DATA)
    n3   = Node.new(NILCLASS_DATA, COMPLEX_DATA, NILCLASS_DATA)
    x3_l = LinkedList.new(@node)
    x3_l.insert(n2, @node)
    x3_l.insert(n3, n2)
    expected = "| base #{@node.to_s()} |-->| #{n2.to_s()} |-->" +
        "| #{n3.to_s()} |\n"
    assert_equal(expected, x3_l.inspect_upper())

  end

  # inspect_lower()

  # test_il_x1().
  # @description
  #   A size one list.
  def test_il_x1()

    x1_l     = LinkedList.new(@node)
    space    = ' '
    d_p_q    = (26 - 7) / 2
    padding  = space * d_p_q
    expected = "| #{padding}data: #{@node.d()}#{padding}  |"
    assert_equal(expected, x1_l.inspect_lower())

  end

  # test_il_x2().
  # @description
  #   A size two list.
  def test_il_x2()

    x1_l  = LinkedList.new(@node)
    n2    = Node.new(NILCLASS_DATA, FLOAT_DATA, NILCLASS_DATA)
    space = ' '
    x1_l.insert(n2, @node)
    d_p_q1   = (31 - 7) / 2
    padding1 = space * d_p_q1
    d_p_q2   = (26 - 9) / 2
    padding2 = space * d_p_q2
    expected = "| #{padding1}data: #{@node.d()}#{padding1} |" +
        "<--| #{padding2}data: #{n2.d()}#{padding2}  |"
    assert_equal(expected, x1_l.inspect_lower())

  end

  # test_il_x3().
  # @description
  #   A size three list.
  def test_il_x3()

    x3_l = LinkedList.new(@node)
    n2   = Node.new(NILCLASS_DATA, RATIONAL_DATA, NILCLASS_DATA)
    n3   = Node.new(NILCLASS_DATA, FLOAT_DATA, NILCLASS_DATA)
    x3_l.insert(n2, @node)
    x3_l.insert(n3, n2)
    space    = ' '
    d_p_q1   = (31 - 7) / 2
    padding1 = space * d_p_q1
    d_p_q2   = (26 - 9) / 2
    padding2 = space * d_p_q2
    d_p_q3   = (26 - 9) / 2
    padding3 = space * d_p_q3
    expected = "| #{padding1}data: #{@node.d()}#{padding1} |<--" +
        "| #{padding2}data: #{n2.d()}#{padding2}  |<--" +
        "| #{padding3}data: #{n3.d()}#{padding3}  |"
    assert_equal(expected, x3_l.inspect_lower())

  end

  # upper_common(n = nil)

  # test_uc_x().
  # @description
  #   A common Node.
  def test_uc_x()

    x_l    = LinkedList.new(@node)
    ins_n1 = Node.new(NILCLASS_DATA, NILCLASS_DATA, NILCLASS_DATA)
    ins_n2 = ins_n1.shallow_clone()
    x_l.insert(ins_n1, @node)
    x_l.insert(ins_n2, ins_n1)
    row      = x_l.upper_common(ins_n1)
    expected = "| #{ins_n1.to_s()} |-->"
    assert_equal(expected, row)

  end

  # upper_na(n = nil)

  # test_u_na_x().
  # @description
  #   An attachmentless Node.
  def test_n_na_x()

    x_l      = LinkedList.new(@node)
    row      = x_l.upper_na(@node)
    expected = "| base #{@node.to_s()} |\n"
    assert_equal(expected, row)

  end

  # upper_base(n = nil)

  # test_ub_x().
  # @description
  #   A base Node.
  def test_ub_x()

    x_l   = LinkedList.new(@node)
    ins_n = Node.new(NILCLASS_DATA, NILCLASS_DATA, NILCLASS_DATA)
    x_l.insert(ins_n, @node)
    row      = x_l.upper_base(@node)
    expected = "| base #{@node.to_s()} |-->"
    assert_equal(expected, row)

  end

  # upper_pioneer(n = nil)

  # test_up_x().
  # @description
  #   A pioneer Node.
  def test_up_x()

    x_l   = LinkedList.new(@node)
    ins_n = Node.new(NILCLASS_DATA, NILCLASS_DATA, NILCLASS_DATA)
    x_l.insert(ins_n, @node)
    row      = x_l.upper_pioneer(ins_n)
    expected = "| #{ins_n.to_s()} |\n"
    assert_equal(expected, row)

  end

  # lower_element()

  # test_le_x().
  # @description
  #   A common Node.
  def test_le_x()

    x_l    = LinkedList.new(@node)
    ins_n1 = Node.new(NILCLASS_DATA, COMPLEX_DATA, NILCLASS_DATA)
    ins_n2 = ins_n1.shallow_clone()
    x_l.insert(ins_n1, @node)
    x_l.insert(ins_n2, ins_n1)
    space    = ' '
    d_p_q    = (26 - 10) / 2
    padding  = space * d_p_q
    expected = "<--| #{padding}data: #{ins_n1.d()}#{padding} |"
    assert_equal(expected, x_l.lower_element(ins_n1))

  end

  # lower_base()

  # test_lb_x().
  # @description
  #   A base Node.
  def test_lb_x()

    x_l   = LinkedList.new(@node)
    ins_n = Node.new(NILCLASS_DATA, FLOAT_DATA, NILCLASS_DATA)
    x_l.insert(ins_n, @node)
    row      = x_l.lower_base(@node)
    p_q      = (32 - 7) / 2
    padding  = ' ' * p_q
    expected = "| #{padding}data: #{INTEGER_DATA}#{padding} |"
    assert_equal(expected, row)

  end

end