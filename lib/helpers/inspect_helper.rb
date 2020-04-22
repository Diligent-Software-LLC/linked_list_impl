# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative '../linked_list_impl'

# InspectHelper.
# @module_description
#   Inspection helper constants and methods.
module InspectHelper

  # Constants
  FORWARD_ARROW      = '-->'
  PIPE               = '|'
  BASE_LABEL         = 'base'
  SPACE              = ' '
  ARROW_PADDING      = SPACE * 3
  BACKWARD_ARROW     = '<--'
  BASE_LABEL_LENGTH  = (BASE_LABEL + SPACE).length()
  NODE_STRING_LENGTH = 26
  BASE_UPPER_BODY_L  = NODE_STRING_LENGTH + BASE_LABEL_LENGTH
  DATA_LABEL         = 'data:'
  DATA_LABEL_LENGTH  = DATA_LABEL.length()
  SPACE_LENGTH       = 1
  ONE                = 1

  # inspect_upper().
  # @description
  #   Forms the inspection's upper row.
  # @return [String]
  #   The inspection's upper row.
  def inspect_upper()

    row       = ""
    iter      = iterator()
    i_element = iter.element()
    if (i_element.no_attachments())
      row += upper_na(i_element)
    else
      while (!iter.position().equal?(size() - ONE))
        case
        when i_element.base()
          row += upper_base(i_element)
        when i_element.back_attached() && i_element.front_attached()
          row += upper_common(i_element)
        else
          row += upper_pioneer(i_element)
        end
        iter.next()
        i_element = iter.element()
      end
      row += upper_pioneer(i_element)
    end
    return row

  end

  # inspect_lower().
  # @description
  #   Forms the inspection's lower row.
  # @return [String]
  #   The lower row.
  def inspect_lower()

    row       = ""
    iter      = iterator()
    i_element = iter.element()
    if (i_element.no_attachments())
      row += i_element.lower_row()
    else

      while (!i_element.pioneer())

        if (i_element.base())
          row += lower_base(i_element)
        else
          row += lower_element(i_element)
        end
        iter.next()
        i_element = iter.element()

      end
      row += lower_element(i_element)

    end
    return row

  end

  # upper_common(n = nil).
  # @description
  #   Forms a common Node upper row.
  # @param n [Node]
  #   A common Node. A Node front and back attached.
  # @return [String]
  #   The row.
  def upper_common(n = nil)
    row = PIPE + SPACE + "#{n.to_s()}" + SPACE + PIPE + FORWARD_ARROW
    return row
  end

  # upper_na(n = nil).
  # @description
  #   Forms an attachmentless Node's upper row.
  # @param n [Node]
  #   An attachmentless Node.
  # @return [String]
  #   The row.
  def upper_na(n = nil)
    row = (PIPE + SPACE + BASE_LABEL + SPACE + "#{n.to_s()}" + SPACE + PIPE +
        "\n")
    return row
  end

  # upper_base(n = nil).
  # @description
  #   Forms a base Node's upper row.
  # @param n [Node]
  #   a base Node.
  # @return [String]
  #   The row.
  def upper_base(n = nil)
    row = (PIPE + SPACE + BASE_LABEL + SPACE + "#{n.to_s()}" + SPACE + PIPE +
        FORWARD_ARROW)
    return row
  end

  # upper_pioneer(n = nil).
  # @description
  #   Forms a pioneer Node's upper row.
  # @param n [Node]
  #   A pioneer.
  # @return [String]
  #   The row.
  def upper_pioneer(n = nil)
    row = (PIPE + SPACE + "#{n.to_s()}" + SPACE + PIPE + "\n")
    return row
  end

  # lower_element(n = nil).
  # @description
  #   Forms a Node's lower row excluding attachmentless Nodes.
  # @param n [Node]
  #   An element.
  # @return [String]
  #   The row.
  def lower_element(n = nil)
    row = BACKWARD_ARROW + n.lower_row()
    return row
  end

  # lower_base(n = nil).
  # @description
  #   Forms a base Node's lower row.
  # @param n [Node]
  #   A base Node.
  # @return [String]
  #   The row.
  def lower_base(n = nil)

    data_string  = "#{n.d()}"
    data_length  = data_string.length()
    p_q          = (BASE_UPPER_BODY_L - (DATA_LABEL_LENGTH + SPACE_LENGTH +
        data_length)) / 2
    padding      = SPACE * p_q
    lb_body      = SPACE + padding + DATA_LABEL + SPACE + data_string + padding +
        SPACE
    adjust_space = ''
    if (lb_body.length() < BASE_UPPER_BODY_L) then
      adjust_space = ' '
    end
    row = PIPE + lb_body + adjust_space + PIPE
    return row

  end

end