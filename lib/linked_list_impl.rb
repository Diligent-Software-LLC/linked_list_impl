# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released 
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "linked_list_impl/version"
require 'node'
require 'data_library'
require 'linked_list_iterator'

# LinkedList.
# @class_description
#   A LinkedList data structure implementation. Implements the LinkedList
#   interface.
# @attr base [Node]
#   A node reference. The list's base.
# @attr size [Integer]
#   The list's node quantity.
class LinkedList < LinkedListInt

  # initialize(d_or_n = nil).
  # @description
  #   Initializes a list instance.
  # @param d_or_n [DataType, Node]
  #   A DataType type or Node instance.
  # @return [LinkedList]
  #   A LinkedList instance.
  # @raise [ArgumentError]
  #   In the case the argument is neither a DataType type or Node instance.
  def initialize(d_or_n = nil)

    case
    when DataType.instance?(d_or_n)
      self.base = initialize_node(d_or_n)
      self.size = 1
    when d_or_n.instance_of?(Node)
      self.base = d_or_n
      self.size = 1
    else
      error = ArgumentError.new()
      raise(error, "#{d_or_n} is neither a DataType or Node instance.")
    end

  end

  # clone().
  # @description
  #   Clones self. Overrides Object's clone method.
  # @return [LinkedList]
  #   self's clone. The clone is attributively equal and not identical.
  def clone()

    unless (base().nil?())
      l_clone = LinkedList.new(base())
      return l_clone
    else

      nil_node = Node.new(nil, nil, nil)
      l_clone  = LinkedList.new(nil_node)
      l_clone.insert(base(), nil_node)
      l_clone.remove(nil_node)
      return l_clone

    end

  end

  # size().
  # @description
  #   Gets the list's node quantity.
  # @return [Integer]
  #   The list size.
  def size()
    return @size
  end

  # empty?().
  # @description
  #   Boolean method.
  # @return [TrueClass, FalseClass]
  #   True in the case size is 0. False otherwise.
  def empty?()
    return size().zero?()
  end

  # ==(inst = nil).
  # @description
  #   Equality operator.
  # @param inst [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the lists' attributes are attributively equal. False
  #   otherwise.
  def ==(inst = nil)

    if (!inst.instance_of?(LinkedList))
      return false
    else

      a_iterator = inst.iterator()
      attr_eql   = ((a_iterator.eql_node?(base())) && (size().eql?(ll.size())))
      return attr_eql

    end

  end

  # ===(inst = nil).
  # @description
  #   Identity comparison operator. Compares self and inst.
  # @param inst [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   true in the case the two lists' object_ids are the same. false
  #   otherwise.
  def ===(inst = nil)
    return equal?(inst)
  end

  # inspect().
  # @description
  #   Represents the String diagrammatically.
  # @return [String]
  #   The list nodes' inspections concatenated. The base node inspection
  #   appends "base" following the first pipe.
  def inspect()

    diagram = ""
    unless (empty?())
      l_it  = iterator()
      l_pos = iterator.position()
      while (l_pos != size())

        insp_n = at(l_pos)
        case
        when size().equal?(ONE) && l_pos.equal?(ZERO)
          diagram += "| base #{insp_n.to_s()} |\n"
        when size() > ONE && l_pos.equal?(ZERO)
          diagram += "| base #{insp_n.to_s()} |#{FORWARD_ARROW}"
        when l_pos.equal?(size() - 1)

          insp_d  = insp_n.nil_front_insp()
          upper_s = insp_d[:upper] + "\n"
          diagram += upper_s

        else
          insp_d  = insp_n.doubly_linked_insp()
          diagram += insp_d[:upper]
        end
        l_it.next()
        l_pos += ONE

      end

      l_it2 = iterator()
      l_pos = l_it2.position()
      while (l_pos != size())
        insp_n = at(l_pos)
        if (l_pos.equal?(ZERO))
          insp_d  = node.only_data_insp()
          diagram += insp_d[:lower]
        else
          insp_d  = node.nil_front_insp()
          diagram += insp_d[:lower]
        end
        l_pos += 1
      end
      return diagram
    end
    diagram = "| nil |"
    return diagram

  end

  # remove(n = nil).
  # @description
  #   Removes the list's node. In the case node is not in the list, removes
  #   nothing.
  # @param node [Node]
  #   The removal node.
  # @return [NilClass]
  #   nil.
  # @raise [NodeError]
  #   In the case the argument is not a Node instance. In the case the list
  #   is empty.
  def remove(n = nil)

    error = NodeError.new()
    if (!n.instance_of?(Node))
      raise(error, error.message())
    else

      l_iterator        = iterator()
      l_pos             = l_iterator.position()
      identical_node    = nil
      idn_pos           = l_pos
      identical_node_sc = identical_node.shallow_clone()

      while (l_pos < size())
        if (l_iterator.identical_node?(n))
          identical_node = n
          idn_pos        = l_pos
        end
        l_iterator.next() unless (l_iterator.position().equal?(size() - ONE))
        l_pos += 1
      end

      case
      when identical_node.nil?()
        return nil
      when identical_node_sc.b().nil?() && identical_node_sc.f().nil?()
        self.base = nil
        self.size = 0
      when identical_node_sc.b().nil?() && !identical_node_sc.f().nil?()

        prev_base = base()
        sub_n     = Node.new(prev_base.back(), prev_base.data(), nil)
        self.base = prev_base.front()
        self.size -= 1
        prev_base.substitute(sub_n)

      when !identical_node_sc.b().nil?() && identical_node_sc.f().nil?()

        prec_node = identical_node.back()
        sub_n1    = Node.new(prec_node.back(), prec_node.data(), nil)
        sub_n2    =
            Node.new(nil, identical_node.data(), identical_node.front())
        prec_node.substitute(sub_n1)
        identical_node.substitute(sub_n2)
        self.size -= 1

      when !identical_node.back().nil?() && identical_node.front().nil?()

        prec_node = identical_node.back()
        pro_node  = identical_node.front()
        sub_n     = Node.new(prec_node.back(), prec_node.data(), pro_node)
        prec_node.substitute(sub_n)
        sub_n = Node.new(prec_node, pro_node.data(), pro_node.front())
        pro_node.substitute(sub_n)
        sub_n = Node.new(nil, identical_node.data(), nil)
        identical_node.substitute(sub_n)
        self.size -= 1

      end

    end
    return nil

  end

  # insert(node1 = nil, node2 = nil).
  # @description
  #   Inserts a node after a specific node.
  # @param node1 [Node]
  #   The insertion node.
  # @param node2 [Node]
  #   The insertion's preceding Node.
  # @return [NilClass]
  #   nil.
  # @raise [NodeError]
  #   In the case node1 or node2 are any type other than Node.
  def insert(node1 = nil, node2 = nil)

    error = NodeError.new()
    if (!node1.instance_of?(Node) || !node2.instance_of?(Node))
      raise(error, error.message())
    else

      id_n       = nil
      l_iterator = iterator()
      l_pos      = l_iterator.position()
      while (l_pos < size())

        if (l_iterator.identical_node?(node2))
          id_n = node2
        end
        l_iterator.next() unless (l_iterator.position().equal?(size() - ONE))
        l_pos += 1

      end

      case
      when id_n.nil?()
        return nil
      when !id_n.front().nil?()

        pro_node = id_n.front()
        prec_n   = id_n
        node1    = Node.new(prec_n, node1.data(), pro_node)
        sub_n    = Node.new(prec_n.back(), prec_n.data(), node1)
        prec_n.substitute(sub_n)
        sub_n = Node.new(node1, pro_node.data(), pro_node.front())
        pro_node.substitute(sub_n)
        self.size += 1

      when id_n.front().nil?()

        id_n_sub = Node.new(id_n.back(), id_n.data(), node1)
        id_n.substitute(id_n_sub)
        n1_sub = Node.new(id_n, node1.data(), node1.front())
        node1.substitute(n1_sub)
        self.size += 1

      end

    end
    return nil

  end

  # [](position = nil).
  # @description
  #   Subscript operator. Gets the data at the list position.
  # @param position [Integer]
  #   The data's location.
  # @return [Numeric, FalseClass, Symbol, TrueClass, String, Time, NilClass]
  #   The data at the position.
  def [](position = nil)
    case
    when !position.instance_of?(Integer)
      raise(ArgumentError, 'The position is not an Integer instance.')
    when position < 0, position >= size()
      raise(IndexError, "The argument is less than zero or greater than" +
          "#{size() - 1}.")
    else
      node = at(position)
      return node.data()
    end
  end

  # []=(position = nil, data = nil).
  # @description
  #   Subscript assignment operator. Sets the data at the specified position.
  # @param position [Integer]
  #   The set location.
  # @param data [Numeric, FalseClass, Symbol, TrueClass, String, Time, NilClass]
  #   The data setting.
  # @return [NilClass]
  #   nil.
  def []=(position = nil, data = nil)
    error = DataError.new()
    case
    when !position.instance_of?(Integer)
      raise(ArgumentError, 'The position is not an Integer instance.')
    when position < 0, position >= size()
      raise(IndexError, "The argument is less than zero or greater than " +
          "#{size() - 1}.")
    when !DataType.instance?(data)
      raise(error, error.message())
    else
      node      = at(position)
      node.data = data
    end
  end

  # iterator().
  # @description
  #   Instantiates a LinkedListIterator.
  # @return [LinkedListIterator]
  #   An iterator instance.
  def iterator()
    return LinkedListIterator.new(base())
  end

  private

  # initialize_node(dti = nil).
  # @description
  #   Initializes an insertion Node.
  # @param dti [DataType]
  #   The initialize method's data argument.
  # @return [Node]
  #   A Node instance. The Node's data is the argument.
  def initialize_node(dti = nil)
    b_node = Node.new(nil, dti, nil)
    return b_node
  end

  # size=(integer = nil).
  # @description
  #   Setter. Sets the size attribute.
  # @param [Integer] integer
  #   The list's Node quantity.
  def size=(integer = nil)
    @size = integer
  end

  # base()
  # @description
  #   Gets the base node's reference.
  # @return [Node]
  #   The base node.
  def base()
    return @base
  end

  # base=(node = nil).
  # @description
  #   Sets the base node.
  # @param [Node]
  #   The node becoming the list's base.
  def base=(node = nil)
    @base = node
  end

  # at(position = nil).
  # @description
  #   Gets the list's node at the position.
  # @param position [Integer]
  #   The list position.
  # @return [Node]
  #   The node reference at the list position.
  def at(position = nil)

    node  = base()
    count = 0
    while (position != count)
      node  = node.front()
      count += 1
    end
    return node

  end

  ZERO = 0
  ONE  = 1
  private_constant :ONE
  private_constant :ZERO

end
