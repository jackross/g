require 'rubygems'
require 'ruby_gntp'
require 'pp'

$g_host ||= "localhost"
$g_priority ||= 0
$g_sticky ||= true

module Kernel
  def g(*args)
    messages = args.dup

    if messages.empty?
      if block_given?
        messages << yield(self)
      else
        messages << self
      end
    end

    messages.each do |i|
      text = i.is_a?(String) ? i : i.pretty_inspect
      GNTP.notify :app_name => $0, :title => 'g', :text => text, :sticky => $g_sticky
    end

    if args.empty?
      self
    elsif args.size == 1
      args.first
    else
      args
    end
  end
end
