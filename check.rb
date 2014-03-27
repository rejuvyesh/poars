#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: check.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

Dir.glob('*.html').each do |file|
  p file if File.zero?(file)
  `rm -f #{file}` if File.zero?(file)
end
