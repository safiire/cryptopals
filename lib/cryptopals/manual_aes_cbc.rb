# frozen_string_literal: true

module Cryptopals
  class ManualAESCBC
    def self.decrypt(ciphertext, iv, key)
      new.decrypt(ciphertext, iv, key)
    end

    def decrypt(ciphertext, iv, key)
      plaintext = ''

      ciphertext.bytes.each_slice(0x10) do |block|
        block = block.map(&:chr).join

        plaintext += PKCS7.unpad(ecb(:decrypt, block, key) ^ iv)
        iv = block
      end
      plaintext
    end

    private

    def ecb(method, block, key)
      cipher = OpenSSL::Cipher.new('aes-128-ecb').send(method)
      cipher.key = key
      cipher.padding = 0
      cipher.update(block)
    end
  end
end
