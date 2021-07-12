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

  def cyclic_xor(other)
    Cryptopals::Operations.cyclic_xor(self, other)
  end
end
