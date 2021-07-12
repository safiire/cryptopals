# frozen_string_literal: true

module Cryptopals
  class CrackCyclicXor
    def self.call(ciphertext)
      new.call(ciphertext)
    end

    def call(ciphertext)
      key_size = CyclicXorKeysize.call(ciphertext).first

      key = transpose_to_columns(ciphertext, key_size).map do |single_byte_xor|
        SingleByteXor.crack(single_byte_xor.bytes2hex).key.chr
      end.join

      ciphertext.cyclic_xor(key)
    end

    private

    def transpose_to_columns(ciphertext, key_size)
      [].tap do |columns|
        ciphertext.bytes.each_slice(key_size) do |block|
          padded_block(block, key_size).each_with_index do |byte, col|
            columns[col] ||= ''
            columns[col] += byte.chr
          end
        end
      end
    end

    def padded_block(block, key_size)
      block + [0] * (key_size - block.size)
    end
  end
end
