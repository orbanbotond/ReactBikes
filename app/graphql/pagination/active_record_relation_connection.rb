module Pagination
  module ActiveRecordRelationConnection

    # Abstract this operation so we can always ignore inputs less than zero.
    # (Sequel doesn't like it, understandably.)
    def set_after_offset(relation, offset_value)
      if offset_value
        # relation.where('id > ?', offset_value)
        relation.where('created_at > ?', offset_value)
      else
        # relation.unscope(where: :id)
        relation.unscope(where: :created_at)
      end
    end

    def set_before_offset(relation, offset_value)
      if offset_value
        # relation.where('id > ?', offset_value)
        relation.where('created_at < ?', offset_value)
      else
        # relation.unscope(where: :id)
        relation.unscope(where: :created_at)
      end
    end

    def sliced_nodes
      @sliced_nodes ||= begin
        paginated_nodes = items

        if after_offset
          paginated_nodes = set_after_offset(paginated_nodes, after_offset)
        end
        if before_offset
          paginated_nodes = set_before_offset(paginated_nodes, before_offset)
        end

        paginated_nodes
      end
    end

    def has_next_page
      false
    end

    def has_previous_page
      false
    end
    # def relation_larger_than(relation, size)
    #   initial_offset = relation.offset_value || 0
    #   relation.offset(initial_offset + size).exists?
    # end

    # def relation_offset(relation)
    #   binding.pry
    #   relation.offset_value
    # end

    def offset_from_cursor(cursor)
      decode(cursor)
    end

    def cursor_for(item)
      timestamp = item.created_at
      encode(timestamp.as_json)
    end
  end
end
