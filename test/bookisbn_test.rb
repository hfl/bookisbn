require "test_helper"

class BookisbnTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bookisbn::VERSION
  end

  def setup
    @isbn = Bookisbn::Isbn.new("978-7-115-36646- 7")
    @isbn_ten = Bookisbn::Isbn.new("7-81074-096-2")
    @isbn_error_format = Bookisbn::Isbn.new("123-123")
  end

  def test_isbn_after_proof
    assert_equal "9787115366467", @isbn.isbn
    assert_equal "7810740962", @isbn_ten.isbn
  end

  def test_ean_ucc
    assert_equal "978", @isbn.ean_ucc
    assert_equal "", @isbn_ten.ean_ucc
  end

  def test_group
    assert_equal "7", @isbn.group
    assert_equal "7", @isbn_ten.group
  end

  def test_publisher
    assert_equal "115", @isbn.publisher
    assert_equal "81074", @isbn_ten.publisher
  end

  def test_title
    assert_equal "36646", @isbn.title
    assert_equal "096", @isbn_ten.title
  end

  def test_check_digit
    assert_equal "7", @isbn.check_digit
    assert_equal "2", @isbn_ten.check_digit
  end

  def test_check?
    assert_equal true, @isbn.check?
    assert_equal true, @isbn_ten.check?
  end

  def test_thirteen
    assert_equal "978-7-115-36646-7", @isbn.thirteen
    assert_equal "978 7 115 36646 7", @isbn.thirteen(" ")
    assert_equal "978-7-81074-096-2", @isbn_ten.thirteen
    assert_equal "978 7 81074 096 2", @isbn_ten.thirteen(" ")
    assert_equal "978,7,81074,096,2", @isbn_ten.thirteen(",")
  end

  def test_ten
    assert_equal "7-81074-096-2", @isbn_ten.ten
    assert_equal "7 81074 096 2", @isbn_ten.ten(" ")
    assert_equal "7-115-36646-9", @isbn.ten
    assert_equal "7 115 36646 9", @isbn.ten(" ")
    assert_equal "7/115/36646/9", @isbn.ten("/")
  end

  def test_validate?
    assert_equal true, @isbn.validate?
    assert_equal true, @isbn_ten.validate?
    assert_equal false, @isbn_error_format.validate?
  end
end
