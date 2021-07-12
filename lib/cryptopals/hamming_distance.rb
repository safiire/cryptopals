# frozen_string_literal: true

module Cryptopals
  class HammingDistance
    class DifferingLengths < StandardError; end

    def self.call(a, b)
      new.call(a, b)
    end

    def call(a, b)
      raise(DifferingLengths) unless a.bytesize == b.bytesize

      a.bytes.zip(b.bytes).reduce(0) do |sum, (x, y)|
        sum + hamming_distance_byte(x, y)
      end
    end

    private

    def hamming_distance_byte(x, y)
      count_one_bits(x ^ y)
    end

    def count_one_bits(byte)
      8.times.reduce(0) do |sum, bit_shift|
        (byte >> bit_shift) & 1 == 1 ? sum.succ : sum
      end
    end
  end
end
