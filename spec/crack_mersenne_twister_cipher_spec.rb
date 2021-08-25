# frozen_string_literal: true

RSpec.describe(Cryptopals::CrackMersenneTwisterCipher) do
  describe '.crack' do
    let(:seed) { Random.rand(described_class::UINT16_MAX) }
    let(:plaintext) { 'Here is some English text that we want to break for our spec' }
    let(:ciphertext) do
      Cryptopals::MersenneTwisterCipher.encrypt(plaintext, seed)
    end

    let(:result) { described_class.crack(ciphertext) }

    context 'when encrypted with a random seed' do
      xit 'can discover the seed and plaintext' do
        expect(result.seed).to eq(seed)
        expect(result.plaintext).to eq(plaintext)
      end
    end
  end
end
