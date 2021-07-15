# frozen_string_literal: true

require 'openssl'

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

    def self.aes_128_ecb_encrypt(plaintext, key)
      cipher = OpenSSL::Cipher.new('aes-128-ecb').encrypt
      cipher.key = key
      cipher.update(plaintext) + cipher.final
    end

    def self.aes_128_ecb_decrypt(ciphertext, key)
      cipher = OpenSSL::Cipher.new('aes-128-ecb').decrypt
      cipher.key = key
      cipher.update(ciphertext) + cipher.final
    end
  end
end
