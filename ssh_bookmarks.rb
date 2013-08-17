require 'yaml'
require 'pry'

class BookmarkManager
  attr_accessor :bookmark_number

  def initialize(bookmark_number: bookmark_number)
    bookmark_number = Integer(bookmark_number) if bookmark_number.is_a?(String)
    self.bookmark_number = bookmark_number
  end

  def self.bookmarks
    bookmarks_from_file.map{|bookmark| Bookmark.new(number: bookmark["number"], command: bookmark["command"])}.sort_by{|b| b.number }
  end

  def self.bookmarks_from_file
    raise "Please create the bookmarks.yml file. Copy bookmarks.example.yml to bookmarks.yml" unless File.exist?('bookmarks.yml')
    begin
      YAML.load_file('bookmarks.yml')
    rescue
      []
    end
  end

  def self.print_bookmarks
    bookmarks.map do |bookmark|
      "[#{bookmark.number}] - #{bookmark.command}"
    end.join("\n")
  end

  def connect
    bookmark = self.class.bookmarks.select{|bm| bm.number == bookmark_number }.first
    return unless bookmark
    system(bookmark.command)
  end
end

class Bookmark
  attr_accessor :number, :command

  def initialize(number: number, command: command)
    self.number = number
    self.command = command
  end
end

puts "Pick a bookmark:"
puts BookmarkManager.print_bookmarks
bm = BookmarkManager.new(bookmark_number: gets.chomp)
bm.connect
