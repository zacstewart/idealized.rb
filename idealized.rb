$:.unshift File.expand_path(File.dirname(__FILE__))
require 'idealized/boolean'
require 'idealized/boolean/true'
require 'idealized/boolean/false'
require 'idealized/number'
require 'idealized/number/zero'
require 'idealized/number/non_zero'
include Idealized
module Idealized
end
