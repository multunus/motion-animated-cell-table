iOS (RubyMotion) Animated Cell Table Controller
============================

This is a library that paves way for programmers to apply fancy animations on tapped cells. When a cell on a table is tapped, this library pops out the view of that cell. This view can be played around with as much as the imagination of the programmer lets him :). And there's more - there's a final means of wrapping it all up - placing the view back in its original slot! Check out the sample app to get a better picture. As always, hearty thanks to team [lorempixel](http://lorempixel.com/) for their super awesome placeholder images.

![Sample Implementation](http://dl.dropboxusercontent.com/s/gbtm147szkgrd6b/animated_cell_sample.gif)

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'motion-animated-cell-table'
```

And then execute:
```ruby
bundle
```

Or install it yourself as:
```ruby
gem install motion-animated-cell-table
```

## Sample App

A sample app is included for reference. To get it up and running, simply clone the repository and run ```rake``` or ```rake device``` depending on whether you want to preview it in the simulator or device.


## Usage

There are a two things that you need to set up first:
1. A table cell and its corresponding view (you can also use the default iOS cell)
2. A duplicate view for the cell (the one that gets popped out)

The table cell needs to implement a special method called ```set_up_duplicate_cell_view``` which accepts two parameters. The first is an instance of CGPoint that gives the x,y position of the cell on the screen and the second is an instance of CGSize that gives the dimensions of the cell. These two parameters can be used to construct the duplicate view and place it appropriately on the screen. Please refer to the sample app to get an exemplified version of this.

Let's call the table cell ```CustomCell```, its view ```CustomCellView``` and the duplicate view ```DuplicateCustomCellView```. Now, here's how you can use the library:

1.  Initialize the table view controller:
    ```ruby
    table = AnimatedCellTableViewController.new
    ```

2. There are very many attributes of the table you can set since it is ultimately a table view controller, but here are the are a few that need to be set mandatorily for the library - the delegate controller for the table, the height of the cells and the number of rows in the table:
    ```ruby
    table.delegate_controller = <DELEGATE_CONTROLLER>
    table.height_of_cell = <HEIGHT_OF_INDIVIDUAL_CELL>
    table.number_of_rows = <NUMBER_OF_ROWS_REQUIRED>
    ```

3. There are delegate methods for creating the individual cells and deciding what to do when a cell is tapped.
    ```ruby
    def cell_was_tapped index, duplicate_cell_view
        # index is the position of the cell in the table
        # duplicate_cell_view is the duplicate view returned from the set_up_duplicate_cell_view method
    end
    ```
    ```ruby
    def create_reusable_cell index, reusable_identifier
        # this is simply a wrapper over the standard cellForRowAtIndexPath method
        # index is the position the cell needs to be created in and can be used for the data selection
        # reusable_identifier is the iOS table reuse identifier
    end
    ```

4. In addition to these fundamental methods, there are two more methods that can be used to show and hide the table:
    ```ruby
    table.show_table_view(duration) # duration is in seconds
    ```
    ```ruby
    table.hide_table_view(duration) # duration is in seconds
    ```

5. And there's more - an extra level of tweaking can be done using two more delegate methods. One is called after the ```show_table_view``` animation is complete and one after the ```hide_table_view``` animation is complete.

    ```ruby
    def after_show_table_view
    end
    ```
    ```ruby
    def after_hide_table_view
    end
    ```

## Contributing

1. Fork it ( http://github.com/multunus/motion-animated-cell-table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request