# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released 
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "linked_list_impl/version"
require_relative 'helpers/inspect_helper'
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

  include InspectHelper

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

  # shallow_clone().
  # @description
  #   Shallowly clones self.
  # @return [LinkedList]
  #   Returns the LinkedList clone.
  def shallow_clone()

    if (base().nil?())
      return clone()
    end

    iter   = iterator()
    c_list = LinkedList.new(base().shallow_clone())
    c_iter = c_list.iterator()
    while (!iter.position().equal?(size() - ONE))

      iter.next()
      c_element = c_iter.element()
      pro_n     = iter.element()
      pro_n_c   = pro_n.shallow_clone()
      detach(pro_n_c)
      c_list.insert(pro_n_c, c_element)
      c_iter.next()

    end
    return c_list

  end

  # clone().
  # @description
  #   Clones self. Overrides Object's clone method.
  # @return [LinkedList]
  #   self's clone. The clone is attributively equal and not identical.
  def clone()

    case
    when empty?()

      l_clone = LinkedList.new(base())
      c_iter  = l_clone.iterator()
      l_clone.remove(c_iter.element())
      return l_clone

    when size() === ONE
      return LinkedList.new(base())
    else

      iter = iterator()
      iter.next()
      l_c         = LinkedList.new(base())
      lci         = l_c.iterator()
      lci_element = lci.element()
      pos         = ONE
      while (pos < size())

        ie_clone = iter.element()
        l_c.insert(ie_clone, lci_element)
        iter.next()
        pos += 1
        lci.next()

      end
      return l_c

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
      attr_eql = (base().equal?(inst.base()) && (size().equal?(inst.size())))
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
  #   appends the first pipe the label "base".
  def inspect()

    diagram = ""
    unless (empty?())
      diagram += inspect_upper()
      diagram += inspect_lower()
    else
      diagram = '| nil |'
    end
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

    case
    when empty?()
      raise(IndexError, 'The list is empty.')
    when !n.instance_of?(Node)
      error = NodeError.new()
      raise(error, error.message())
    when base().no_attachments() && (n === base())
      self.base = nil
      self.size = 0
    when base().no_attachments() && !(n === base())
      return nil
    else

      l_iterator = iterator()
      id_n       = nil
      l_element  = l_iterator.element()
      while (!(n === l_element) && !(l_element.pioneer()))
        l_iterator.next()
        l_element = l_iterator.element()
      end
      if (l_element.equal?(n))
        id_n = n
      else
        return id_n
      end

      case
      when id_n.nil?()
        return nil
      when id_n.base()

        l_iterator.next()
        self.base = l_iterator.element()
        detach_nodes(id_n, l_iterator.element())

      when id_n.pioneer()

        l_iterator.prev()
        back_n = l_iterator.element()
        detach_nodes(back_n, id_n)

      when id_n.back_attached() && id_n.front_attached()

        l_iterator.prev()
        pre_n = l_iterator.element()
        l_iterator.next()
        l_iterator.next()
        pro_n = l_iterator.element()
        attach_nodes(pre_n, pro_n)
        detach(id_n)

      end
      self.size = size() - 1

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

    case
    when (!node1.instance_of?(Node) || !node2.instance_of?(Node))
      error = NodeError.new()
      raise(error, error.message())
    else

      detach(node1)
      id_n       = nil
      l_iterator = iterator()
      id_n       = node2 if (node2 === l_iterator.element())
      while ((!(node2 === l_iterator.element()) &&
          !(l_iterator.element().pioneer() ||
              l_iterator.element().no_attachments())))
        l_iterator.next()
      end

      if (node2 === l_iterator.element())
        id_n = node2
      else
        return id_n
      end

      case
      when id_n.no_attachments(), node2.pioneer()
        attach_nodes(node2, node1)
      when node2.base(), (node2.front_attached() && node2.back_attached())

        l_iterator.next()
        pro_n = l_iterator.element()
        attach_nodes(node2, node1)
        attach_nodes(node1, pro_n)

      end
      self.size += 1

    end
    return nil

  end

  # iterator().
  # @description
  #   Instantiates a LinkedListIterator.
  # @return [LinkedListIterator]
  #   An iterator instance.
  def iterator()
    return LinkedListIterator.new(base())
  end

  protected

  # base()
  # @description
  #   Gets the base node's reference.
  # @return [Node]
  #   The base node.
  def base()
    return @base
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

  # base=(node = nil).
  # @description
  #   Sets the base node.
  # @param [Node]
  #   The node becoming the list's base.
  def base=(node = nil)
    @base = node
  end

  # attach_nodes(n1 = nil, n2 = nil).
  # @description
  #   Attaches two Nodes.
  # @param n1 [Node]
  #   The precession Node. Sets the front attribute the second Node's reference.
  # @param n2 [Node]
  #   The consequential Node. Sets the back attribute the preceding Node.
  # @return [NilClass]
  #   nil.
  def attach_nodes(n1 = nil, n2 = nil)

    n1.attach_front(n2)
    n2.attach_back(n1)
    return nil

  end

  # detach_nodes(n1 = nil, n2 = nil).
  # @description
  #   Detaches two Nodes.
  # @param n1 [Node]
  #   The precession. Sets front nil.
  # @param n2 [Node]
  #   The consequent. Sets back nil.
  # @return [NilClass]
  #   nil.
  def detach_nodes(n1 = nil, n2 = nil)

    n1.detach_front()
    n2.detach_back()
    return nil

  end

  # detach(n = nil).
  # @description
  #   Detaches a list Node's front and back references.
  # @param n [Node]
  #   Any list Node.
  # @return [NilClass]
  #   nil.
  def detach(n = nil)

    n.detach_back()
    n.detach_front()
    return nil

  end

  ZERO = 0
  ONE  = 1
  private_constant :ONE
  private_constant :ZERO

end
