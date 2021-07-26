# frozen_string_literal: true

module Cryptopals
  class AESCBC
    def self.encrypt(plaintext, iv, key)
      new.encrypt(plaintext, iv, key)
    end

    def self.decrypt(ciphertext, iv, key)
      new.decrypt(ciphertext, iv, key)
    end

    def encrypt(plaintext, iv, key)
      cipher = OpenSSL::Cipher.new('aes-128-cbc').encrypt
      cipher.key = key
      cipher.iv = iv
      cipher.update(plaintext) + cipher.final
    end

    def decrypt(ciphertext, iv, key)
      plaintext = ''

      ciphertext.bytes.each_slice(0x10) do |block|
        block = block.map(&:chr).join

        decrypted = block.aes_ecb_single(:decrypt, key)
        plaintext += PKCS7.unpad(decrypted ^ iv)
        iv = block
      end
      plaintext
    end
  end
end
