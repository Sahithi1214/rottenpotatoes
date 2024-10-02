module ApplicationHelper
  def sortable_column(column, title = nil)
    #   title ||= column.titleize
    #   # Determine the sort direction
    #   direction = (column == session[:sort] && session[:direction] == "asc") ? "desc" : "asc"

    #   # Create an arrow indicating the sort direction
    #   arrow = (column == session[:sort]) ? (session[:direction] == "asc" ? " ↑" : " ↓") : ""
    #   # Generate the link with sort parameters
    #   puts "session direction : #{session[:direction]}"
    #   session[:direction] = direction
    #   link_to title + arrow, { sort: column, direction: direction }, class: (column == session[:sort] ? "highlighted" : "")
    # end
    title ||= column.titleize
    css_class = column == session[:sort] ? "highlighted" : nil
    direction = column == session[:sort] && session[:direction] == "asc" ? "desc" : "asc"
    link_to title, movies_path(sort: column, direction: direction), class: css_class
  end
end
