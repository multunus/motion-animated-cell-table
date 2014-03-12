class DuplicateCustomCellView < UIView

  def set_up_view(view_position, view_dimensions, image)
    self.frame = CGRectMake(view_position.x, view_position.y, view_dimensions.width, view_dimensions.height)
    image_view = set_up_image_view(view_dimensions, image)
    self.addSubview(image_view)
  end

  def set_up_image_view(view_dimensions, image)
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, view_dimensions.width, view_dimensions.height))
    image_view.setImage image
    image_view
  end

end
