describe DuplicateCustomCellView do
  before do
    @duplicate_view = DuplicateCustomCellView.new
  end

  it "should set up the view" do
    @duplicate_view.set_up_view(CGPointMake(0,0), CGSizeMake(0,0), UIImage.new)
    @duplicate_view.subviews.count.should == 1
  end

  it "should set up an image view" do
    image_view = @duplicate_view.set_up_image_view(CGSizeMake(0,0), UIImage.new)
    image_view.class.should == UIImageView
  end
end
