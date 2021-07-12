# frozen_string_literal: true

module Cryptopals
  class SingleByteXor
    Result = Struct.new(:plaintext, :key)

    def self.crack(string)
      new.call(string.hex2bytes)
    end

    def self.decrypt(ciphertext, key)
      ciphertext.bytes.map { |byte| (byte ^ key).chr }.join
    end

    def call(ciphertext)
      highest_score = 0

      256.times.reduce(empty_result) do |result, key|
        decrypted = self.class.decrypt(ciphertext, key)
        score = English.score(decrypted)

        if score > highest_score
          highest_score = score
          Result.new(decrypted, key)
        else
          result
        end
      end
    end

    private

    def empty_result
      Result.new(nil, nil)
    end
  end
end
