# frozen_string_literal: true

module Cryptopals
  class CrackCyclicXor
    def self.call(ciphertext)
      new.call(ciphertext)
    end

    def call(ciphertext)
      key_size = CyclicXorKeysize.call(ciphertext).first

      key = transpose_blocks(ciphertext, key_size).map do |single_xor|
        SingleByteXor.crack(single_xor.bytes2hex).key.chr
      end.join

      ciphertext.cyclic_xor(key)
    end

    private

    def transpose_blocks(string, size)
      columns = []
      string.bytes.each_slice(size) do |slice|
        slice += [0] * (size - slice.size)
        slice.each_with_index do |byte, i|
          columns[i] ||= ''
          columns[i] += byte.chr
        end
      end
      columns
    end
  end
end
