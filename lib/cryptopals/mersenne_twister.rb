# frozen_string_literal: true

module Cryptopals
  N = 624
  M = 397
  F = 0x6c078965
  DEFAULT_SEED = 5489

  MASK32 = 0xffffffff
  MATRIX_A = 0x9908b0df
  UPPER_MASK = 0x80000000
  LOWER_MASK = 0x7fffffff

  class MersenneTwister
    def initialize(seed = DEFAULT_SEED)
      srand(seed)
    end

    def srand(seed)
      self.mt = Array.new(N, 0)
      set_last_index

      N.times do |n|
        prev = mt[n.pred]
        mt[n] = (n.zero? ? seed : (F * (prev ^ (prev >> 30)) + n)) & MASK32
      end
    end

    def rand_uint32
      twist if out_of_values?

      temper(mt[index]).tap { self.index += 1 }
    end

    private

    attr_accessor :index, :mt

    def twist
      N.times do |n|
        y = ((mt[n] & UPPER_MASK) | (mt[n.succ % N] & LOWER_MASK)) & MASK32
        y_shifted = y >> 1
        y_shifted ^= MATRIX_A if y.odd?
        mt[n] = mt[(n + M) % N] ^ y_shifted
      end
      reset_index
    end

    def temper(y)
      y ^= (y >> 11)
      y ^= (y << 7) & 0x9d2c5680
      y ^= (y << 15) & 0xefc60000
      y ^= (y >> 18)
      y & MASK32
    end

    def out_of_values?
      index >= N
    end

    def reset_index
      self.index = 0
    end

    def set_last_index
      self.index = N
    end
  end
end
