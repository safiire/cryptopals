# frozen_string_literal: true

module Cryptopals
  class CrackMersenneTwisterCipher
    UINT16_MAX = 2**16 - 1
    Result = Struct.new(:score, :seed, :plaintext)

    def self.crack(ciphertext)
      new.call(ciphertext)
    end

    def call(ciphertext)
      0.upto(UINT16_MAX).map do |seed|
        plaintext = MersenneTwisterCipher.decrypt(ciphertext, seed)
        score = English.score(plaintext)
        Result.new(score, seed, plaintext)
      end.max { |a, b| a.score <=> b.score }
    end
  end
end
