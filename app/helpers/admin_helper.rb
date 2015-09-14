module AdminHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    # raise column.inspect
    # raise sort_direction.inspect
    # direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"

    if (params[:sort] == sort_column) && (sort_direction == "asc")
      direction = "desc"
    else
      direction = "asc"
    end
    link_to title, :sort => column, :direction => direction
  end

end
