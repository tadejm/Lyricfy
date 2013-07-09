module Lyricfy
  class Song
    attr_accessor :title, :author, :lines

    def initialize(title, author, lines)
      self.title  = title
      self.author = author
      self.lines  = lines
    end

    def body(separator="")
      lines.join(separator)
    end
  end
end