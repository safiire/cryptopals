# frozen_string_literal: true

module Cryptopals
  class CyclicXor
    Result = Struct.new(:plaintext, :key)

    def self.crack(ciphertext, max_keysize: 40)
      new.crack(ciphertext, max_keysize)
    end

    def crack(ciphertext, max_keysize)
      key_size = CyclicXorKeysize.call(ciphertext, max_keysize: max_keysize).first

      key = transpose_to_columns(ciphertext, key_size).map do |single_byte_xor|
        SingleByteXor.crack(single_byte_xor).key.chr
      end.join

      Result.new(ciphertext.cyclic_xor(key), key)
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
