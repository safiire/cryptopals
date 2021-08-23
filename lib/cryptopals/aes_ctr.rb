# frozen_string_literal: true

module Cryptopals
  class AESCTR
    class Keystream
      include Enumerable

      def initialize(nonce, key)
        @key = key
        @nonce = nonce
      end

      def each
        return to_enum unless block_given?

        0.upto(Float::INFINITY) do |counter|
          block = [@nonce, counter].pack('Q2')
          keystream = block.aes_ecb_single(:encrypt, @key)
          keystream.bytes.each { |k| yield(k) }
        end
      end
    end

    def self.encrypt(plaintext, nonce, key)
      new.call(plaintext, nonce, key)
    end

    def self.decrypt(ciphertext, nonce, key)
      new.call(ciphertext, nonce, key)
    end

    def call(input, nonce, key)
      keystream = Keystream.new(nonce, key)
      input.bytes.zip(keystream).map { |p, k| (p ^ k).chr }.join
    end
  end
end
