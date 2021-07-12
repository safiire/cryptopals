# frozen_string_literal: true

module Cryptopals
  module Operations
    class DifferingLengths < StandardError; end

    def self.fixed_xor(a, b)
      raise(DifferingLengths) unless a.bytesize == b.bytesize

      a.bytes.zip(b.bytes).map { |(x, y)| (x ^ y).chr }.join
    end

    def self.cyclic_xor(a, b)
      smaller, larger = [a, b].sort_by(&:bytesize)
      larger.bytes.zip(smaller.bytes.cycle).map { |(x, y)| (x ^ y).chr }.join
    end
  end
end
