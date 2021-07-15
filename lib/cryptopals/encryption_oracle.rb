# frozen_string_literal: true

module Cryptopals
  class EncryptionOracle
    def self.call(ciphertext)
      unique_blocks = Set.new

      ciphertext.bytes.each_slice(0x10) do |block|
        unique_blocks << block
      end

      (ciphertext.bytesize / 16 - unique_blocks.size).zero? ? :cbc : :ecb
    end
  end
end
