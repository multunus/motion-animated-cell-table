describe AnimatedCellTableViewController do
  extend Facon::SpecHelpers

  before do
    @table = AnimatedCellTableViewController.new
    @screen = ScreenController.new
    @screen.populate_sample_data
    @screen.instance_variable_set(:@animator, MotionAnimator.new)
    @table.delegate_controller = @screen
    @table.height_of_cell = 30
  end

  it "should call the method in the delegate controller on cell tap" do
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    @table.delegate_controller.stub!(:cell_was_tapped)
    @table.delegate_controller.should.receive(:cell_was_tapped) do |index, duplicate_cell_view|
      index.class.should == Fixnum
      duplicate_cell_view.class.should == DuplicateCustomCellView
    end
    @table.tableView(@table.tableView, didSelectRowAtIndexPath: index_path)
  end

  it "should call the cell creation/reuse method in the delegate" do
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    reusable_identifier = AnimatedCellTableViewController.name
    @table.delegate_controller.should.receive(:create_reusable_cell)
    @table.tableView(@table.tableView, cellForRowAtIndexPath: index_path)
  end

  it "should set the height of a cell" do
    @table.height_of_cell = 40
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    cell_height = @table.tableView(@table.tableView, heightForRowAtIndexPath: index_path)
    cell_height.should == 40
  end

  it "should hide the table view" do
    @table.tableView.hidden = false
    @table.tableView.alpha = 1
    @table.delegate_controller.stub!(:after_hide_table_view)
    @table.hide_table_view(0.0)
    wait 0.1 do
      @table.tableView.isHidden.should == true
      @table.tableView.alpha.should == 0
    end
  end

  it "should show the table view" do
    @table.tableView.hidden = true
    @table.tableView.alpha = 0
    @table.stub!(:show_hidden_cell)
    @table.delegate_controller.stub!(:after_show_table_view)
    @table.show_table_view(0.0)
    wait 0.1 do
      @table.tableView.isHidden.should == false
      @table.tableView.alpha.should == 1
    end
  end

  it "should toggle the cell visibility at a particular index" do
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    cell = @table.tableView(@table.tableView, cellForRowAtIndexPath: index_path)
    cell.hidden = false
    @table.toggle_cell_visibility(@table.tableView, index_path)
    cell = @table.tableView(@table.tableView, cellForRowAtIndexPath: index_path)
    hidden_cell_index = @table.instance_variable_get(:@hidden_cell_index)
    hidden_cell_index.should == index_path.row
    cell.isHidden.should == true
  end

  it "should determine whether to hide a cell or not" do
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    cell = @table.tableView(@table.tableView, cellForRowAtIndexPath: index_path)
    @table.instance_variable_set(:@hidden_cell_index, index_path.row)
    @table.hide_cell?(index_path.row).should == true
  end

  it "should return the position the cell occupies on the screen" do
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    @table.height_of_cell = 40
    computed_cell_position = @table.get_cell_position_on_screen(@table.tableView, index_path)
    actual_x_origin = @table.tableView.frame.origin.x
    actual_y_origin = @table.height_of_cell * index_path.row - @table.tableView.contentOffset.y
    computed_cell_position.x.should == actual_x_origin
    computed_cell_position.y.should == actual_y_origin
  end

  it "should return the dimensions of the cell" do
    index_path = NSIndexPath.indexPathForRow(0, inSection: 0)
    cell = @table.tableView(@table.tableView, cellForRowAtIndexPath: index_path)
    computed_cell_dimensions = @table.get_cell_dimensions(cell)
    computed_cell_dimensions.class.should == CGSize
  end

end
