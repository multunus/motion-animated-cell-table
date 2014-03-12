class CustomCell < UITableViewCell
  attr_reader :custom_cell_view

  def set_up_cell(cell_position, cell_dimensions, image_url)
    @custom_cell_view = CustomCellView.new
    @custom_cell_view.set_up_view(cell_dimensions, image_url)
    self.addSubview(@custom_cell_view)
  end

  def set_up_duplicate_cell_view(view_position, view_dimensions)
    duplicate_custom_cell_view = DuplicateCustomCellView.new
    image = @custom_cell_view.image_view.image
    duplicate_custom_cell_view.set_up_view(view_position, view_dimensions, image)
    duplicate_custom_cell_view
  end

  def get_frame_size
    @custom_cell_view.frame.size
  end
end
