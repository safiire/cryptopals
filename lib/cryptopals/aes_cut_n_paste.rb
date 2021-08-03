# frozen_string_literal: true

module Cryptopals
  class AESCutNPaste
    def self.profile_for(email, role='user')
      email = email.gsub(/&=/, '')
      cookie = {email: email, uid: 10, role: role}
      plaintext = cookie.map { |key, value| [key, value].join('=') }.join('&')

      RandomAES.ecb_with_unknown_key(plaintext)
    end

    def self.is_admin?(ciphertext)
      plaintext = ciphertext.aes_ecb_decrypt(RandomAES::UNKNOWN_KEY)
      Hash[URI.decode_www_form(plaintext)]['role'] == 'admin'
    end

    def self.forge_admin_role(oracle)
      email = "eeeeeeeeeeadmin\xb\xb\xb\xb\xb\xb\xb\xb\xb\xb\xb"
      ciphertext = oracle.call(email)
      forged_end_block = ciphertext.block_number(1)

      email = 'A' * 13
      ciphertext = oracle.call(email)

      [ciphertext.block_number(0), ciphertext.block_number(1), forged_end_block].join
    end
  end
end
