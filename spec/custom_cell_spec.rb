describe CustomCell do
  before do
    @cell = CustomCell.new
  end

  it "should set up its view" do
    position = CGPointMake(0,0)
    dimensions = CGSizeMake(0,0)
    image_url = "http://image.url"
    @cell.set_up_cell(position, dimensions, image_url)
    cell_view = @cell.instance_variable_get(:@custom_cell_view)
    cell_view.class.should == CustomCellView
  end
end
