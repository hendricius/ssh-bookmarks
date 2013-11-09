require 'yaml'

class BookmarkManager
  attr_accessor :bookmark_number, :bookmark_description

  def initialize(bookmark_number: nil)
    bookmark_number = Integer(bookmark_number) if bookmark_number.is_a?(String)
    self.bookmark_number = bookmark_number
  end

  def self.bookmarks
    bookmarks_from_file.map do |bookmark|
      Bookmark.new(number: bookmark["number"], command: bookmark["command"],
                   description: bookmark["description"])
    end.sort_by{|b| b.number }
  end

  def self.bookmarks_from_file
    file = "#{File.dirname(__FILE__)}/bookmarks.yml"
    raise "Please create the bookmarks.yml file. Copy bookmarks.example.yml to bookmarks.yml" unless File.exist?(file)
    begin
      YAML.load_file(file)
    rescue
      []
    end
  end

  def self.print_bookmarks
    bookmarks.map do |bookmark|
      print_single_bookmark(bookmark)
    end.join("\n")
  end

  # Creates the string that is used for printing the single bookmark.
  def self.print_single_bookmark(bookmark)
    return "" unless bookmark
    if bookmark.description
      # For pretty aligning the description to the above text.
      digits_in_number  = bookmark.number.to_s.length
      spaces = ""
      digits_in_number.times do
        spaces += " "
      end
      "[#{bookmark.number}] - #{bookmark.command}\n   #{spaces}- #{bookmark.description}"
    else
      "[#{bookmark.number}] - #{bookmark.command}"
    end
  end

  def connect
    bookmark = self.class.bookmarks.select{|bm| bm.number == bookmark_number }.first
    return unless bookmark
    system(bookmark.command)
  end
end

class Bookmark
  attr_accessor :number, :command, :description

  def initialize(number: nil, command: nil, description: nil)
    self.number = number
    self.command = command
    self.description = description
  end
end

puts "Pick a bookmark:"
puts BookmarkManager.print_bookmarks
bm = BookmarkManager.new(bookmark_number: gets.chomp)
bm.connect
