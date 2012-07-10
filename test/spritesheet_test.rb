require 'test/unit'
require 'digest/md5'
require File.expand_path('../../lib/spritesheet.rb', __FILE__)

class SpriteSheetTest < Test::Unit::TestCase
  include SpriteSheet

  def setup
    @sample_gif   = 'test/assets/example.gif'
    @sample_sheet = 'test/assets/example_sheet.jpg'
    @temp_sheet   = 'test/assets/temp_sheet.jpg'
  end

  def test_takes_only_gif_as_argument
    assert_raise ArgumentError do
      sheet = Sheet.new 'donotcare.jpg'
    end
  end

  def test_creates_imagelist
    sheet = Sheet.new @sample_gif
    assert_equal Magick::ImageList, sheet.frames.class
  end

  def test_sheet_width
    sheet = Sheet.new @sample_gif
    assert_equal ( 9*85 ), sheet.width
  end

  def test_height
    sheet = Sheet.new @sample_gif
    assert_equal 80, sheet.height
  end

  def test_sheet_frames
    sheet = Sheet.new @sample_gif
    assert_equal 9, sheet.frames.count
  end

  def test_creates_image
    sheet = Sheet.new @sample_gif
    assert_equal Magick::Image, sheet.sprite.class
    assert_equal sheet.width, sheet.sprite.columns
  end

  def test_write_image
    sheet = Sheet.new @sample_gif
    sheet.write_to @temp_sheet
    assert File.exists?(@temp_sheet), "The should have been a File generated"
    assert_equal Digest::MD5.hexdigest(File.read(@sample_sheet)),
      Digest::MD5.hexdigest(File.read(@temp_sheet))
  end

  def teardown
    File.delete @temp_sheet if File.exists? @temp_sheet
  end
end
