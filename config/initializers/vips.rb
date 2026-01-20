# config/initializers/vips.rb

# Silence repeated ruby-vips constant warnings
old_verbose = $VERBOSE
$VERBOSE = nil
require "vips"
$VERBOSE = old_verbose