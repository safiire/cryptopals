# frozen_string_literal: true

module Cryptopals
  class MTUntemper
    MASK32 = 0xffffffff

    def self.clone(get_next)
      MersenneTwister.new.tap do |mt|
        mt.replace_state(624.times.map { untemper(get_next.call) })
      end
    end

    def self.untemper(value)
      y = undo_xor_lsr(value, 18)
      y = undo_xor_lsl_and(y, 15, 0xefc60000)
      y = undo_xor_lsl_and(y, 7, 0x9d2c5680)
      undo_xor_lsr(y, 11)
    end

    # Solve for x: y = x ^ (x >> shift)
    def self.undo_xor_lsr(y, shift)
      mask = ~(1 << (32 - shift)).pred & MASK32

      (32 / shift).times.reduce(y) do |acc, n|
        partial = acc & (mask >> (shift * n))
        acc ^ (partial >> shift)
      end
    end

    # Sove for x: y = x ^ (x << shift) & c
    def self.undo_xor_lsl_and(y, shift, c)
      mask = (1 << shift).pred

      (32.0 / shift).ceil.times.reduce(y) do |acc, n|
        partial = acc & (mask << (shift * n)) & MASK32
        acc ^ (partial << shift) & c
      end
    end
  end
end
