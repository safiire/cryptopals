# frozen_string_literal: true

require 'base64'

module Cryptopals
  module Conversion
    def self.bytes2hex(string)
      string.bytes.map { |byte| '%02x' % byte }.join
    end

    def self.hex2bytes(string)
      string = '0' + string if string.size.odd?
      string.scan(/../).map { |hex| hex.to_i(16).chr }.join
    end

    def self.hex2base64(string)
      Base64.strict_encode64(hex2bytes(string))
    end
  end
end
