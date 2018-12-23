require "bookisbn/version"
require 'rexml/document'

module Bookisbn
  class Error < StandardError; end
  class Isbn
    include REXML

    attr_accessor :isbn
    attr_reader :ean_ucc, :group, :publisher, :title, :check_digit

    def initialize(isbn)

      # proof isbn, delete - and space
      @isbn = isbn.delete(" -")
      @ean_ucc = @group = @publisher = @title = @check_digit = ""

      # if 13, get ean_ucc
      @ean_ucc = @isbn[0..2] if @isbn.length == 13

      file_path = File.join( File.dirname(__FILE__), 'bookisbn/RangeMessage.xml' )
      file = File.new(file_path)
      doc = Document.new(file)

      # set group value with RangeMessage
      doc.elements.each("ISBNRangeMessage/EAN.UCCPrefixes/EAN.UCC/Prefix") do |p|
        group_size = ""
        start = @ean_ucc.length
        ean_ucc_digit = @isbn[start..start+6].to_i
        # get ean ucc if it have, if no, it will set it equal 978
        eanucc = ""
        if @ean_ucc == ""
          eanucc = "978"
        else
          eanucc = @ean_ucc
        end
        if p.text == eanucc
          p.parent.elements.each("Rules/Rule") do |r|
            r.elements.each("Range") do |a|
              range_arry = a.text.split("-")
              if ean_ucc_digit > range_arry[0].to_i and ean_ucc_digit < range_arry[1].to_i
                r.elements.each("Length") do |b|
                  group_size = b.text
                  break
                end
              end
              break unless group_size == ""
            end
            break unless group_size == ""
          end
        end
        unless group_size == ""
          to = start + group_size.to_i - 1
          @group = @isbn[start..to]
          break
        end
      end

      # set publisher
      doc.elements.each("ISBNRangeMessage/RegistrationGroups/Group/Prefix") do |p|
        publisher_size = ""
        start = @ean_ucc.length + @group.length
        publisher_digit = @isbn[start..start+6].to_i
        eanucc = ""
        if @ean_ucc == ""
          eanucc = "978"
        else
          eanucc = @ean_ucc
        end
        if p.text == eanucc + "-" + @group
          p.parent.elements.each("Rules/Rule") do |r|
            r.elements.each("Range") do |a|
              range_arry = a.text.split("-")
              if publisher_digit > range_arry[0].to_i and publisher_digit < range_arry[1].to_i
                r.elements.each("Length") do |b|
                  publisher_size = b.text
                  break
                end
              end
              break unless publisher_size == ""
            end
            break unless publisher_size == ""
          end
        end
        unless publisher_size == ""
          to = start + publisher_size.to_i - 1
          @publisher = @isbn[start..to]
          break
        end
      end

      # set title
      title_start = @ean_ucc.length + @group.length + @publisher.length
      @title = @isbn[title_start..-2]

      # set check_digit
      @check_digit = @isbn[-1]
    end

    def check?
      sum = 0
      # new isbn
      if @isbn.length == 13
        for i in 0..11
          if @isbn[i].to_i.odd?
            sum += @isbn[i].to_i * 1
          else
            sum += @isbn[i].to_i * 3
          end
        end
        if 10 - sum%10 == @isbn[12].to_i
          return true
        else
          return false
        end
      # old isbn
      elsif @isbn.length == 10
        for i in 0..8
          sum += @isbn[i].to_i * (10 - i)
        end
        if 11 - sum%11 == 10 and @isbn[9] == "X"
          return true
        elsif 11 - sum%11 == 11 and @isbn[9] == "0"
          return true
        elsif 11 - sum%11 == @isbn[9].to_i
          return true
        else
          return false
        end
      else
        return false
      end
    end

    def validate?
      if @isbn.length == 13
        if @ean_ucc == "" or @group == "" or @publisher == "" or @title == "" or @check_digit == ""
          false
        else
          true
        end
      elsif @isbn.length == 10
        if @group == "" or @publisher == "" or @title == "" or @check_digit == ""
          false
        else
          true
        end
      else
        false
      end
    end

    def thirteen(joiner="-")
      [@ean_ucc, @group, @publisher, @title, @check_digit].join(joiner)
    end

    def ten(joiner="-")
      [@group, @publisher, @title, @check_digit].join(joiner)
    end
  end
end
