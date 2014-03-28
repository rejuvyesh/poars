#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
#
# File: table.rb
#
# Copyright rejuvyesh <mail@rejuvyesh.com>, 2014
# License: GNU GPL 3 <http://www.gnu.org/copyleft/gpl.html>

require 'csv'

print"<table>"
s='h'
CSV.parse($<.read.gsub'\,',"\013"){|r|print"<tr>#{r.map{|c|"<t#{s}>#{c}</t#{s}>"}.join.gsub"\013",','}</tr>";s='d'}
puts"</table>"
