module AdminHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    if (params[:sort] == sort_column) && (sort_direction == "asc")
      direction = "desc"
    else
      direction = "asc"
    end
    link_to title, :sort => column, :direction => direction
  end

end
