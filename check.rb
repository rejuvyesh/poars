#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: check.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

Dir.glob('*.html').each do |file|
  if File.zero?(file) || system("grep error #{file}")
    p file
    `rm -f #{file}`
  end
end
