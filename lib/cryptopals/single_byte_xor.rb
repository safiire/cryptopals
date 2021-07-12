# frozen_string_literal: true

module Cryptopals
  class SingleByteXor
    Result = Struct.new(:plaintext, :key)

    def self.crack(string)
      new.crack(string.hex2bytes)
    end

    def self.encrypt(string, key)
      string.bytes.map { |byte| (byte ^ key).chr }.join
    end

    def self.decrypt(string, key)
      encrypt(string, key)
    end

    def crack(ciphertext)
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
