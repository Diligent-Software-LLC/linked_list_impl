# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require 'linked_list_int'

# LinkedList.
# @description
#   A LinkedList data structure implementation. Implements the LinkedList
#   interface.
# @attr base [Node]
#   A base Node.
# @attr size [Integer]
#   The list's Node quantity.
class LinkedList < LinkedListInt
  VERSION = '1.0.0'.freeze()
end
