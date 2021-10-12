# frozen_string_literal: true

module Pagination
  module ActiveRecordRelationConnection
    def set_after_offset(relation, offset_value)
      if offset_value
        # TODO make these fields injectable from the outside customizable
        # relation.where('id > ?', offset_value)
        relation.where("created_at > ?", offset_value)
      else
        # relation.unscope(where: :id)
        relation.unscope(where: :created_at)
      end
    end

    def set_before_offset(relation, offset_value)
      if offset_value
        # relation.where('id > ?', offset_value)
        relation.where("created_at < ?", offset_value)
      else
        # relation.unscope(where: :id)
        relation.unscope(where: :created_at)
      end
    end

    # This provides limit to the relation
    # By applying the `first` and `last` to `sliced_nodes`
    def limited_nodes
      @limited_nodes ||= begin
        paginated_nodes = sliced_nodes

        if first
          paginated_nodes = paginated_nodes.first(first)
        end
        if last
          paginated_nodes = paginated_nodes.last(last)
        end
        paginated_nodes
      end
    end

    # This provides pagination to the relation
    # By applying the `after` and `before` to `items`
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
      load_nodes.last != items.last
    end

    def has_previous_page
      load_nodes.first != items.first
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

GraphQL::Pagination::ActiveRecordRelationConnection.send(:include, Pagination::ActiveRecordRelationConnection)
