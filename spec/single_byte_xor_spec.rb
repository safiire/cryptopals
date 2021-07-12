# frozen_string_literal: true

RSpec.describe(Cryptopals::SingleByteXor) do
  describe '.crack' do
    let(:result) { described_class.crack(ciphertext) }

    context 'when given challenge 3' do
      let(:ciphertext) { '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736' }
      let(:plaintext) { 'Cooking MC\'s like a pound of bacon' }
      let(:key) { 'A' }

      it 'finds the key and cracks the ciphertext' do
        expect(result.key).to eq(88)
        expect(result.plaintext).to eq(plaintext)
      end
    end
  end
end
