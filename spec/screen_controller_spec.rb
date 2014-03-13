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

  it "should set up the reverse animation button" do
    button = @screen.set_up_reverse_animator_button
    button.class.should == UIButton
    button.backgroundColor.should == UIColor.blackColor
  end

  it "should create a reusable cell for the table" do
    cell = @screen.create_reusable_cell 0, AnimatedCellTableViewController.name
    cell.class.should == CustomCell
  end

  it "should show animation button" do
    button = @screen.set_up_reverse_animator_button
    @screen.instance_variable_set(:@button, button)
    button.alpha = 0
    @screen.show_reverse_animator_button
    button.alpha.should == 1
  end

  it "should hide animation button" do
    button = @screen.set_up_reverse_animator_button
    @screen.instance_variable_set(:@button, button)
    button.alpha = 1
    @screen.hide_reverse_animator_button
    button.alpha.should == 0
  end

  it "should populate sample data" do
    @screen.populate_sample_data
    @screen.items_list.count.should == 10
  end
end
