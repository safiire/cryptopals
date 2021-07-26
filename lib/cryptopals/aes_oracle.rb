# frozen_string_literal: true

require 'pry-byebug'

module Cryptopals
  class AESOracle
    ONE_PADDING_BYTE = "\x01"

    def self.crack_ecb(oracle)
      new(oracle).crack_ecb
    end

    def initialize(oracle)
      @oracle = oracle
      @initial_input_size, @focused_block = inital_sizes
    end

    def crack_ecb
      plaintext_cracked = ''

      initial_input_size.downto(0) do |input_size|
        user_controlled = 'A' * input_size
        ciphertext_block = ask_oracle(user_controlled)
        table = build_table(user_controlled, plaintext_cracked)
        plaintext_cracked += table[ciphertext_block]

        break if plaintext_cracked.end_with?(ONE_PADDING_BYTE)
      end
      PKCS7.unpad(plaintext_cracked)
    end

    private

    attr_reader :oracle, :initial_input_size, :focused_block

    def inital_sizes
      with_no_input = oracle.call('')
      input_size = with_no_input.bytesize.pred
      block = with_no_input.number_of_blocks.pred
      [input_size, block]
    end

    def ask_oracle(user_controlled)
      ciphertext = oracle.call(user_controlled)
      ciphertext.block_number(focused_block).bytes2hex
    end

    def build_table(user_controlled, plaintext_cracked)
      0.upto(255).each_with_object({}) do |byte, table|
        probe_input = user_controlled + plaintext_cracked + byte.chr
        encrypted = oracle.call(probe_input)
        block = encrypted.block_number(focused_block).bytes2hex

        table[block] = byte.chr
      end
    end
  end
end
