# frozen_string_literal: true

module Cryptopals
  class CyclicXorKeysize
    Result = Struct.new(:key_size, :average)

    def self.call(ciphertext, max_keysize: 40)
      new.call(ciphertext, max_keysize)
    end

    def call(ciphertext, max_keysize)
      results = []
      2.upto(max_keysize) do |key_size|
        hamming_distances = adjacent_blocks(ciphertext, key_size).map do |(block1, block2)|
          normalized_hamming(block1, block2)
        end
        results << create_result(hamming_distances, key_size)
      end
      rank_results(results, max: 3)
    end

    private

    def create_result(distances, key_size)
      average = distances.sum / distances.size
      Result.new(key_size, average)
    end

    def rank_results(results, max: 3)
      results.sort_by(&:average).map(&:key_size).take(max)
    end

    def normalized_hamming(a, b)
      HammingDistance.call(a, b) / a.size.to_f
    end

    def adjacent_blocks(string, size)
      slices = string.bytes.each_slice(size).map do |slice|
        pad_array(slice, size).map(&:chr).join
      end
      slices << padding_block(size) unless slices.size.even?
      slices.each_slice(2).to_enum
    end

    def pad_array(array, size)
      array + [0] * (size - array.size)
    end

    def padding_block(size)
      "\x00" * size
    end
  end
end
