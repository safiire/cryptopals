# frozen_string_literal: true

module Cryptopals
  class AESOracle
    def self.crack_ecb(oracle)
      new.crack_ecb(oracle)
    end

    def crack_ecb(oracle)
      plaintext_cracked = ''
      with_no_input = oracle.call('')

      user_input_size = with_no_input.bytesize.pred
      focused_block = with_no_input.number_of_blocks.pred

      user_input_size.downto(0) do |input_size|
        user_controlled = 'A' * input_size

        ciphertext = oracle.call(user_controlled)
        ciphertext_block = ciphertext.block_number(focused_block).bytes2hex

        table = 0.upto(255).each_with_object({}) do |byte, table|
          probe_input = user_controlled + plaintext_cracked + byte.chr
          encrypted = oracle.call(probe_input)
          block = encrypted.block_number(focused_block).bytes2hex

          table[block] = byte.chr
        end

        plaintext_cracked += table[ciphertext_block] if table.key?(ciphertext_block)
      end
      PKCS7.unpad(plaintext_cracked)
    end
  end
end
