class ScreenController < UIViewController
  attr_accessor :table, :items_list

  def viewDidLoad
    super
    populate_sample_data
    set_up_initial_layout
    @animator = MotionAnimator.new
  end

  def set_up_initial_layout
    self.view.backgroundColor = UIColor.whiteColor
    @table = set_up_table
    @button = set_up_reverse_animator_button
    hide_reverse_animator_button
    self.view.addSubview(@table.view)
    self.view.addSubview(@button)
  end

  def set_up_table
    table = AnimatedCellTableViewController.new
    table.height_of_cell = 60
    table.number_of_rows = self.items_list.count
    table.tableView.frame = self.view.bounds
    table.delegate_controller = self
    table.tableView.backgroundColor = UIColor.clearColor
    table.tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    table
  end

  def set_up_reverse_animator_button
    animator_button = UIButton.buttonWithType(UIButtonTypeCustom)
    animator_button.layer.cornerRadius = 10.0
    animator_button.addTarget(self, action: "perform_reverse_animation:", forControlEvents:UIControlEventTouchDown)
    animator_button.backgroundColor = UIColor.blackColor
    animator_button.setTitle("Reverse Animation", forState:UIControlStateNormal)
    animator_button.frame = CGRectMake(80.0, 440.0, 160.0, 40.0)
    animator_button
  end

  def cell_was_tapped index, duplicate_cell_view
    @duplicate_cell_view = duplicate_cell_view
    @original_view_position = @duplicate_cell_view.frame.origin
    self.view.addSubview(@duplicate_cell_view)
    self.view.bringSubviewToFront(@duplicate_cell_view)
    @table.hide_table_view(0.3)
  end

  def create_reusable_cell index, reusable_identifier
    custom_cell = CustomCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reusable_identifier)
    cell_dimensions = CGSizeMake(320, 60)
    cell_position = CGPointMake(0, 0)
    custom_cell.set_up_cell(cell_position, cell_dimensions, self.items_list[index])
    custom_cell
  end

  def perform_reverse_animation sender
    hide_reverse_animator_button
    @animator.linear_animate(@duplicate_cell_view, to: @original_view_position, duration: 0.3, completion: nil)
    @table.show_table_view(0.3)
  end

  def after_show_table_view
    @duplicate_cell_view.removeFromSuperview
  end

  def after_hide_table_view
    final_point = CGPointMake(0,0)
    @animator.linear_animate(@duplicate_cell_view, to: final_point, duration: 0.3, completion: lambda{|completion| show_reverse_animator_button})
  end
 
  def show_reverse_animator_button
    @button.alpha = 1
  end

  def hide_reverse_animator_button
    @button.alpha = 0
  end

  def populate_sample_data
    self.items_list = []
    10.times do |n|
      self.items_list << "http://lorempixel.com/320/60/technics/#{n}"
    end
  end

  def prefersStatusBarHidden
    true
  end
end
