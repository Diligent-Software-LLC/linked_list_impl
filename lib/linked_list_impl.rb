# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released 
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "linked_list_impl/version"
require_relative 'helpers/inspect_helper'
require 'node_comp'
require 'linked_list_int'

# LinkedList.
# @description
#   A doubly-linked LinkedList data structure library's implementation.
#   Implements the LinkedList interface.
# @attr base [NodeAdapter]
#   A base.
# @attr size [Integer]
#   The list's element quantity.
class LinkedList < LinkedListInt

  include InspectHelper

  # initialize(d_or_n = nil).
  # @description
  #   Initializes a LinkedList instance.
  # @param d_or_n [Node, DataType, NodeAdapter]
  #   Any instance.
  # @return [LinkedList]
  #   A LinkedList instance.
  # @raise [ArgumentError]
  #   In the case the argument is neither a DataType type or Node instance.
  def initialize(d_or_n = nil)

    arg_class = d_or_n.class()
    case
    when arg_class.equal?(Node)
      n_a = NodeAdapter.new(d_or_n)
      self.base = n_a
      increment_s()
    when arg_class.equal?(NodeAdapter)
      self.base = d_or_n
      increment_s()
    when DataType.type?(arg_class)
      self.base = initialize_node(d_or_n)
      increment_s()
    else
      raise(ArgumentError,
            "#{d_or_n} is neither a DataType or Node family type instance.")
    end

  end

  # shallow_clone().
  # @description
  #   Shallowly clones self.
  # @return [LinkedList]
  #   Returns the LinkedList clone.
  def shallow_clone()

    n_a = NodeAdapter.new(base())
    n_a.size = size()
    if (frozen?())
      n_a.freeze()
    end
    return n_a

  end

  # clone_df().
  # @description
  #   Deeply clones.
  # @return [LinkedList]
  #   A deep clone. No Node references are identical. The data references are
  #   identical.
  def clone_df()

    clone = shallow_clone()
    c_iter = LinkedListIterator.new(clone.base())
    iter = LinkedListIterator.new(base())
    list_element = iter.element()

    if (list_element.equal?(base()))

      while (!list_element.pioneer())

        cdf_node = list_element.clone_df()
        clone.insert(list_element, cdf_node)
        c_iter.next()

      end
      cdf_node = list_element.clone_df()
      clone.insert(cdf_node, c_iter.element())

    end
    if (frozen?())
      clone.freeze()
    end
    return clone

  end

  # size().
  # @description
  #   Gets the list's size.
  # @return [Integer]
  #   The element quantity.
  def size()
    return @size
  end

  # exists(n = nil).
  # @description
  #   Predicate. Verifies an object is a list element.
  # @param n [.]
  #   Any object.
  # @return [TrueClass, FalseClass]
  #   True in the case 'n' is a list element. False otherwise.
  def exists(n = nil)

    unless (n.instance_of?(NodeAdapter))
      return false
    else

      iter = LinkedListIterator.new(base())
      iter_element = iter.element()
      while ((!iter_element.pioneer()) && (!iter_element.lone()))

        if (iter_element.equal?(n))
          return true
        end
        iter.next()

      end
      if (iter_element.equal?(n))
        return true
      else
        return false
      end

    end

  end

  # empty().
  # @description
  #   Predicate. Verifies size is 0.
  # @return [TrueClass, FalseClass]
  #   True in the case the size is zero. False otherwise.
  def empty()
    return size().zero?()
  end

  # ==(object = nil).
  # @description
  #   Equality operator.
  # @param object [.]
  #   Any object. A comparison.
  # @return [TrueClass, FalseClass]
  #   True in the case the lhs and rhs' attribute references are identical.
  #   False otherwise.
  def ==(object = nil)

    unless (object.instance_of?(NodeAdapter))
      return false
    else
      return ((back().equal?(object.back()) && (data().equal?(object.data())) &&
          (front().equal?(object.front()))))
    end

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
  #   Removes the list's NodeAdapter 'n'.
  # @param n [NodeAdapter]
  #   A list Node. The removal.
  # @return [NilClass]
  #   nil.
  # @raise [ArgumentError]
  #   In the case the argument was not found in the list.
  def remove(n = nil)

    case
    when (!n.instance_of?(NodeAdapter))
      raise(ArgumentError, "#{n} is not a NodeAdapter instance.")
    when (!exists(n))
      raise(ArgumentError, "#{n} is not a list element.")
    end
    pre_n = n.back()
    post_n = n.front()
    attach(pre_n, post_n)
    n.detach_back()
    n.detach_front()
    decrement_s()
    return nil

  end

  # insert(n1 = nil, n2 = nil).
  # @description
  #   Inserts a Node after a specific Node.
  # @param n1 [Node, NodeAdapter]
  #   A consequent. The insertion.
  # @param n2 [NodeAdapter]
  #   A precession. An existing list Node.
  # @return [NilClass]
  #   nil.
  def insert(n1 = nil, n2 = nil)

    case
    when (!n1.kind_of?(Node))
      raise(ArgumentError, "#{n1} is not a Node family instance.")
    when (!n2.instance_of?(NodeAdapter))
      raise(ArgumentError, "#{n2} is not a NodeAdapter instance.")
    when (!exists(n2))
      raise(ArgumentError, "#{n2} is not a list element.")
    when (n1.instance_of?(Node))
      n1 = NodeAdapter.new(n1)
    end

    na_kind        = n2.kind()
    k1             = 'lone'.freeze()
    k2             = 'pioneer'.freeze()
    k3             = 'base'.freeze()
    k4 = 'common'.freeze()
    case na_kind
    when k1, k2
      attach(n2, n1)
    when k3, k4

      conseq_n = n2.front()
      attach(n2, conseq_n)
      attach(n1, n2)

    end
    increment_s()
    return nil

  end

  protected

  # base().
  # @description
  #   Gets base's reference.
  # @return [NodeAdapter]
  #   'base'.
  def base()
    return @base
  end

  # size=(i = nil).
  # @description
  #   Sets 'size'.
  # @param i [Integer]
  #   An integer list size.
  # @return [Integer]
  #   The argument.
  def size=(i = nil)
    @size = i
  end

  private

  # initialize_node(dti = nil).
  # @description
  #   Initializes a NodeAdapter instance.
  # @param dti [DataType]
  #   The NodeAdapter's data setting.
  # @return [NodeAdapter]
  #   The NodeAdapter instance.
  def initialize_node(dti = nil)

    b_node = Node.new(nil, dti, nil)
    n_a = NodeAdapter.new(b_node)
    return n_a

  end

  # base=(n = nil).
  # @description
  #   Sets 'base'.
  # @param n [NodeAdapter]
  #   The instance becoming 'base'.
  def base=(node = nil)
    @base = node
  end

  # increment_s().
  # @description
  #   Increment operator. Increments size.
  # @return [Integer]
  #   The list's size plus one.
  def increment_s()
    self.size = (size() + 1)
  end

  # decrement_s().
  # @description
  #   Decrement operator. Decrements size.
  # @return [Integer]
  #   The list's size less one.
  def decrement_s()
    self.size = (size() - 1)
  end

  # attach(n1 = nil, n2 = nil).
  # @description
  #   Attaches two NodeAdapters.
  # @param n1 [NodeAdapter]
  #   A precession.
  # @param n2 [NodeAdapter]
  #   A consequent.
  # @return [NilClass]
  #   nil.
  def attach(n1 = nil, n2 = nil)

    n1.attach_front(n2)
    n2.attach_back(n1)
    return nil

  end

  # detach(n1 = nil, n2 = nil).
  # @description
  #   Detaches two linked NodeAdapters.
  # @param n1 [NodeAdapter]
  #   A precession.
  # @param n2 [NodeAdapter]
  #   A consequent.
  # @return [NilClass]
  #   nil.
  def detach(n1 = nil, n2 = nil)

    n1.detach_front()
    n2.detach_back()
    return nil

  end

  # Private constants.
  ZERO = 0
  ONE  = 1
  private_constant :ONE
  private_constant :ZERO

end
