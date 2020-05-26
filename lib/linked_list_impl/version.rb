# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

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
  VERSION = '2.0.0'.freeze()
end
