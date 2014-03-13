describe ScreenController do
  before do
    @screen = ScreenController.new
    @screen.items_list = []
  end

  it "should populate sample data initially" do
    @screen.should.receive(:populate_sample_data)
    @screen.view
  end

  it "should set_up_the initial_layout" do
    @screen.set_up_initial_layout
    table = @screen.instance_variable_get(:@table)
    button = @screen.instance_variable_get(:@button)
    table.class.should == AnimatedCellTableViewController
    button.class.should == UIButton
  end

  it "should set up the table" do
    table = @screen.set_up_table
    table.class.should == AnimatedCellTableViewController
    table.tableView.backgroundColor.should == UIColor.clearColor
    table.tableView.separatorStyle.should == UITableViewCellSeparatorStyleNone
  end

end
