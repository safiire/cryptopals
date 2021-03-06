# frozen_string_literal: true

module Cryptopals
  class PKCS7
    class InvalidPadding < StandardError; end
    class BlockBiggerThanSize < StandardError; end

    def self.pad(block, size: 16)
      padding_size = size - block.bytesize
      raise(BlockBiggerThanSize) if padding_size.negative?

      block + padding(padding_size)
    end

    def self.unpad(block, size: 16)
      last_byte = block[-1].ord
      return block if last_byte > size

      block.gsub(padding(last_byte), '')
    end

    def self.padding(size)
      size.chr * size
    end
  end
end
