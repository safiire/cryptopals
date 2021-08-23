# frozen_string_literal: true

module Cryptopals
  class MersenneTwisterCipher
    class Keystream
      include Enumerable

      def initialize(seed)
        @mt = MersenneTwister.new(seed & 0xffff)
      end

      def each
        return to_enum unless block_given?

        loop do
          uint32 = @mt.rand_uint32
          [uint32].pack('L').bytes.each { |k| yield(k) }
        end
      end
    end

    def self.encrypt(plaintext, seed)
      new.call(plaintext, seed)
    end

    def self.decrypt(ciphertext, seed)
      new.call(ciphertext, seed)
    end

    def call(input, seed)
      keystream = Keystream.new(seed)
      input.bytes.zip(keystream).map { |p, k| (p ^ k).chr }.join
    end
  end
end
