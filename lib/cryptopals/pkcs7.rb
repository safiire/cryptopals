# frozen_string_literal: true

module Cryptopals
  class PKCS7
    class BlockBiggerThanSize < StandardError; end

    def self.call(block, size: 16)
      new.call(block, size)
    end

    def call(block, size)
      padding_bytes = size - block.size
      raise(BlockBiggerThanSize) if padding_bytes.negative?

      block + (padding_bytes.chr * padding_bytes)
    end
  end
end
