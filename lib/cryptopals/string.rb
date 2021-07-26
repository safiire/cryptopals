# frozen_string_literal: true

class String
  def bytes2hex
    Cryptopals::Conversion.bytes2hex(self)
  end

  def hex2bytes
    Cryptopals::Conversion.hex2bytes(self)
  end

  def base64
    Base64.strict_encode64(self)
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

  def aes_ecb_encrypt(key)
    Cryptopals::Operations.aes_ecb(:encrypt, self, key)
  end

  def aes_ecb_decrypt(key)
    Cryptopals::Operations.aes_ecb(:decrypt, self, key)
  end

  def aes_ecb_single(method, key)
    Cryptopals::Operations.aes_ecb_single(method, self, key)
  end

  def aes_cbc_encrypt(key, iv)
    Cryptopals::AESCBC.encrypt(self, key, iv)
  end

  def aes_cbc_decrypt(key, iv)
    Cryptopals::AESCBC.decrypt(self, key, iv)
  end

  def block_number(n, blocksize: 0x10)
    Cryptopals::Operations.block_number(self, n, block_size: blocksize)
  end

  def number_of_blocks(blocksize: 0x10)
    (bytesize / blocksize.to_f).ceil
  end

  def first_block
    block_number(0)
  end

  def last_block
    block_number(number_of_blocks.pred)
  end

  def some_of(size: 4, offset: 0)
    self[offset...(offset + size)]
  end
end
