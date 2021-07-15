# frozen_string_literal: true

require 'securerandom'

module Cryptopals
  class RandomAES
    def self.call(plaintext, mode = rand(2) == 1 ? :ecb : :cbc)
      new.call(plaintext, mode)
    end

    def call(plaintext, mode)
      mode == :ecb ? ecb(plaintext) : cbc(plaintext)
    end

    private

    def ecb(plaintext)
      plaintext.aes_128_ecb_encrypt(random_key)
    end

    def cbc(plaintext)
      plaintext.aes_128_cbc_encrypt(random_key, random_iv)
    end

    def random_key
      random_bytes(0x10)
    end

    def add_random_bytes(plaintext)
      random_bytes + plaintext + random_bytes
    end

    def random_bytes(length = rand(5..10))
      SecureRandom.random_bytes(length)
    end

    alias random_iv random_key
  end
end
