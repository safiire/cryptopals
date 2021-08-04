# frozen_string_literal: true

module Cryptopals
  class AESCBCBitflip
    def self.forge_admin(server)
      one_block = (0xff.chr * 16)
      zero_block = (0x00.chr * 16)

      injection = 'xxxxx;admin=true'
      inverted = injection ^ one_block

      ciphertext = server.call(inverted)

      bitflip_mask = zero_block + one_block + (zero_block * 4)
      ciphertext ^ bitflip_mask
    end

    def self.admin?(ciphertext)
      plaintext = ciphertext.aes_cbc_decrypt(RandomAES::UNKNOWN_KEY, RandomAES::UNKNOWN_IV)
      plaintext.include?(';admin=true;')
    end
  end
end
