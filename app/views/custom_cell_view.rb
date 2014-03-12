class CustomCellView < UIView
  attr_reader :image_view

  def set_up_view(cell_dimensions, image_url)
    self.frame = CGRectMake(0, 0, cell_dimensions.width, cell_dimensions.height)
    @image_view = set_up_image_view(cell_dimensions, image_url)
    self.addSubview(@image_view)
  end

  def set_up_image_view(cell_dimensions, image_url)
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, cell_dimensions.width, cell_dimensions.height))
    image_view.setImageWithURL(NSURL.URLWithString(image_url))
    image_view
  end
end
