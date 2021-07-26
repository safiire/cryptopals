# frozen_string_literal: true

require 'set'

module Cryptopals
  class AESMode
    def self.detect_mode(ciphertext)
      new.detect_mode(ciphertext)
    end

    def detect_mode(ciphertext)
      block_size = 0x10
      differing_blocks = ciphertext.bytesize / block_size - unique_blocks(ciphertext, block_size).size
      differing_blocks.zero? ? :cbc : :ecb
    end

    def unique_blocks(ciphertext, size)
      Set.new.tap do |set|
        ciphertext.bytes.each_slice(size) do |block|
          set << block
        end
      end
    end
  end
end
