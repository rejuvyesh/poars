#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: dump.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>


Dir.glob('*.html').each do |file|
  out = File.basename(file, ".*") + ".txt"
  `elinks -dump #{file} > #{out}`
end
