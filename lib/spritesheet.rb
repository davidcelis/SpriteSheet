require 'RMagick'
require 'spritesheet/version'

module SpriteSheet
  class SpriteSheet::Sheet
    attr_reader :frames
    attr_reader :sprite

    def initialize file
      # only takes gif files
      throw ArgumentError unless file =~ /\.gif$/
      @frames = Magick::ImageList.new file
      @sprite = @frames.append(false)
    end

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
      @frames.inject(0) { |sum, frame|
        sum + frame.columns
      }
    end
  end
end
