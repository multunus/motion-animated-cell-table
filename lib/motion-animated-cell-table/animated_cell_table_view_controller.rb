class AnimatedCellTableViewController < UITableViewController
  attr_accessor :delegate_controller, :height_of_cell, :number_of_rows

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    duplicate_cell_view = create_duplicate_view_from_cell(table_view, index_path)
    toggle_cell_visibility(table_view, index_path)
    self.delegate_controller.cell_was_tapped(index_path.row, duplicate_cell_view)
  end

  def create_duplicate_view_from_cell(table_view, index_path)
    cell = tableView(table_view, cellForRowAtIndexPath: index_path)
    view_position = get_cell_position_on_screen(table_view, index_path)
    view_dimensions = get_cell_dimensions(cell)
    cell.set_up_duplicate_cell_view(view_position, view_dimensions)
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    reusable_identifier = AnimatedCellTableViewController.name
    cell = table_view.dequeueReusableCellWithIdentifier(reusable_identifier)
    unless cell
      cell = self.delegate_controller.create_reusable_cell(index_path.row, reusable_identifier)
    end
    cell.hidden = true if hide_cell?(index_path.row)
    cell
  end

  def show_hidden_cell
    index_path = NSIndexPath.indexPathForRow(@hidden_cell_index, inSection: 0)
    toggle_cell_visibility(self.tableView, index_path)
  end

  def hide_cell?(index)
    @hidden_cell_index == index
  end

  def toggle_cell_visibility(table_view, index_path)
    cell = tableView(table_view, cellForRowAtIndexPath: index_path)
    cell.hidden = !cell.isHidden
    @hidden_cell_index = cell.isHidden ? index_path.row : nil
    self.tableView.reloadData
  end

  def show_table_view(duration)
    self.tableView.hidden = false
    UIView.animateWithDuration(duration,
                               animations: lambda{
                                 self.tableView.alpha = 1
                               },
                               completion: lambda{|completion|
                                 show_hidden_cell
                                 self.delegate_controller.after_show_table_view
                               }
                               )
  end

  def hide_table_view(duration)
    UIView.animateWithDuration(duration,
                               animations: lambda{
                                 self.tableView.alpha = 0
                               },
                               completion: lambda{|completion|
                                 self.tableView.hidden = true
                                 self.delegate_controller.after_hide_table_view
                               }
                               )
  end

  def get_cell_position_on_screen(table_view, index_path)
    CGPointMake(table_view.contentOffset.x, self.height_of_cell * index_path.row - table_view.contentOffset.y)
  end

  def get_cell_dimensions(cell)
    cell.get_frame_size
  end

  def tableView(table_view, numberOfRowsInSection: section)
    return 0 if self.number_of_rows.nil?
    self.number_of_rows
  end

  def numberOfSectionsInTableView(table_view)
    1
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    self.height_of_cell
  end

end
