# frozen_string_literal: true

module Cryptopals
  class CyclicXorKeysize
    def self.call(ciphertext, max_keysize: 40)
      new.call(ciphertext, max_keysize)
    end

    def call(ciphertext, max_keysize)
      results = []
      2.upto(max_keysize) do |key_size|
        hamming_distances = each_slice(ciphertext, key_size).map do |(block1, block2)|
          normalized_hamming(block1, block2)
        end
        results << create_result(hamming_distances, key_size)
      end
      rank_results(results, max: 3)
    end

    private

    def create_result(distances, key_size)
      average = distances.sum / distances.size
      [key_size, average]
    end

    def rank_results(results, max: 3)
      results.sort_by { |result| result.last }.map(&:first).take(max)
    end

    def normalized_hamming(a, b)
      HammingDistance.call(a, b) / a.size.to_f
    end

    def each_slice(string, size)
      slices = string.bytes.each_slice(size).map do |slice|
        slice += [0] * (size - slice.size)
        slice.map(&:chr).join
      end
      slices << ("\x00" * size) unless slices.size.even?
      slices.each_slice(2).to_enum
    end
  end
end
