# frozen_string_literal: true

require 'securerandom'

module Cryptopals
  class RandomAES
    UNKNOWN_KEY = "(q\xB9$\xBB.DH\xB1\"V\xCEX\xA10\x0E"

    def self.call(plaintext, mode = rand(2) == 1 ? :ecb : :cbc)
      new.call(plaintext, mode)
    end

    def self.ecb_with_unknown_key(plaintext)
      new.call(plaintext, :ecb, UNKNOWN_KEY)
    end

    def self.cbc_with_unknown_key(plaintext)
      new.call(plaintext, :cbc, UNKNOWN_KEY)
    end

    def call(plaintext, mode, key = random_key)
      mode == :ecb ? ecb(plaintext, key) : cbc(plaintext, key)
    end

    private

    def ecb(plaintext, key)
      plaintext.aes_ecb_encrypt(key)
    end

    def cbc(plaintext, key)
      plaintext.aes_cbc_encrypt(key, random_iv)
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
