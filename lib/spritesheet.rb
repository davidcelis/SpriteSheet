require 'RMagick'
require 'spritesheet/version'

module SpriteSheet
  module ClassMethods
    def is_valid? file
      file =~ /\.gif$/
    end
  end

  module InstanceMethods
    def width
      @width ||= calculate_width
    end

    def write_to path
      @sprite.write path
    end

    # returns the height of highest frame (memoized)
    def height
      @height ||= @frames.max_by { |frame| frame.rows }.rows
    end

    private
    # calculates the width of the sheet
    def calculate_width
      @frames.inject(0) { |sum, frame| sum + frame.columns }
    end
  end

  class Sheet
    extend SpriteSheet::ClassMethods
    include SpriteSheet::InstanceMethods

    attr_reader :frames
    attr_reader :sprite

    def initialize file
      # only takes gif files
      raise SpriteSheet::ArgumentError unless SpriteSheet::Sheet.is_valid? file
      @frames = Magick::ImageList.new file
      @sprite = @frames.append false
    end
  end

  # errors
  class ArgumentError < ArgumentError
  end

  class FileExistsError < StandardError
  end
end
