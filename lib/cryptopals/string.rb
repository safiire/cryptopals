# frozen_string_literal: true

class String
  def bytes2hex
    Cryptopals::Conversion.bytes2hex(self)
  end

  def hex2bytes
    Cryptopals::Conversion.hex2bytes(self)
  end

  def hex2base64
    Cryptopals::Conversion.hex2base64(self)
  end

  def fixed_xor(other)
    Cryptopals::Operations.fixed_xor(self, other)
  end

  def ^(other)
    fixed_xor(other)
  end

  def cyclic_xor(other)
    Cryptopals::Operations.cyclic_xor(self, other)
  end

  def aes_128_ecb_encrypt(key)
    Cryptopals::Operations.aes_128_ecb_encrypt(self, key)
  end

  def aes_128_ecb_decrypt(key)
    Cryptopals::Operations.aes_128_ecb_decrypt(self, key)
  end

  def aes_128_cbc_encrypt(key, iv)
    Cryptopals::AESCBC.encrypt(self, key, iv)
  end

  def aes_128_cbc_decrypt(key, iv)
    Cryptopals::AESCBC.decrypt(self, key, iv)
  end
end
