# frozen_string_literal: true

module Cryptopals
  module English
    FREQUENCIES = 'ULDRHS NIOATE'.split('').each_with_index.each_with_object({}) do |(char, i), table|
      table[char.ord] = i.succ
      table[char.downcase.ord] = i.succ
    end.freeze

    def self.score(string)
      string.bytes.reduce(0) do |score, byte|
        score + (FREQUENCIES[byte] || 0)
      end
    end
  end
end
