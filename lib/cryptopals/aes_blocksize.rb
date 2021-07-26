# frozen_string_literal: true

module Cryptopals
  class AESBlocksize
    class GaveUp < StandardError; end
    MAX_BLOCKSIZE = 128

    def self.detect_blocksize(plaintext, &oracle)
      new.detect_blocksize(plaintext, &oracle)
    end

    def detect_blocksize(plaintext, &oracle)
      unshifted_ciphertext = oracle.call(plaintext)

      1.upto(MAX_BLOCKSIZE) do |guess|
        shifted_ciphertext = oracle.call(padding(guess) + plaintext)

        return guess if unshifted_ciphertext.some_of == shifted_ciphertext.some_of(offset: guess)
      end
      raise(GaveUp, "Gave up after #{MAX_BLOCKSIZE} tries")
    end

    private

    def padding(size)
      'A' * size
    end
  end
end
