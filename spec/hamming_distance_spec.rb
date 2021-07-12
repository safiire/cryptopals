# frozen_string_literal: true

RSpec.describe(Cryptopals::HammingDistance) do
  describe '.call' do
    let(:result) { described_class.call(a, b) }

    context 'when given two differnt length strings' do
      let(:a) { 'different' }
      let(:b) { 'lengths' }

      it 'throws an error' do
        expect { result }.to raise_error(described_class::DifferingLengths)
      end
    end

    context 'when given single bytes' do
      let(:a) { 0b10101010.chr }
      let(:b) { 0b00100010.chr }
      let(:distance) { 2 }

      it 'calcuates the distance correctly' do
        expect(result).to eq(distance)
      end
    end

    context 'when given the challange string' do
      let(:a) { 'this is a test' }
      let(:b) { 'wokka wokka!!!' }
      let(:distance) { 37 }

      it 'calcuates the distance correctly' do
        expect(result).to eq(distance)
      end
    end

    context 'when you encrypt two bytes with the same key' do
      let(:p1) { rand(256).chr }
      let(:p2) { rand(256).chr }
      let(:hamming_distance_plaintext) { described_class.call(p1, p2) }

      let(:key) { rand(256) }
      let(:c1) { p1.fixed_xor(key.chr) }
      let(:c2) { p2.fixed_xor(key.chr) }
      let(:hamming_distance_ciphertext) { described_class.call(c1, c2) }

      it 'has the same hamming distance when encrypted' do
        expect(hamming_distance_plaintext).to eq(hamming_distance_ciphertext)
      end
    end

    context 'when you encrypt two bytes with different keys' do
      let(:p1) { rand(256).chr }
      let(:p2) { rand(256).chr }
      let(:hamming_distance_plaintext) { described_class.call(p1, p2) }
      let(:k1) { "\xde" }
      let(:k2) { "\xad" }

      let(:c1) { p1.fixed_xor(k1) }
      let(:c2) { p2.fixed_xor(k2) }
      let(:hamming_distance_ciphertext_different) { described_class.call(c1, c2) }

      it 'has different hamming distance when encrypted' do
        expect(hamming_distance_plaintext).not_to eq(hamming_distance_ciphertext_different)
      end
    end
  end
end
