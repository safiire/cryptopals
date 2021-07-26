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

    def self.aes_ecb(method, ciphertext, key)
      cipher = OpenSSL::Cipher.new('aes-128-ecb').send(method)
      cipher.key = key
      cipher.update(ciphertext) + cipher.final
    end

    def self.aes_ecb_single(method, block, key)
      cipher = OpenSSL::Cipher.new('aes-128-ecb').send(method)
      cipher.key = key
      cipher.padding = 0
      cipher.update(block)
    end

    def self.block_number(string, n, block_size: 0x10)
      start = block_size * n
      finish = block_size * n.succ
      string[start...finish]
    end
  end
end
