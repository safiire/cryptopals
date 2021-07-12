# frozen_string_literal: true

RSpec.describe(Cryptopals::SingleByteXor) do
  describe '.encrypt' do
    let(:key) { 0xaf }
    let(:plaintext) { 'This is some plaintext' }
    let(:encrypted) { described_class.encrypt(plaintext, key) }
    let(:decrypted) { described_class.decrypt(encrypted, key) }

    context 'when inverting the operation' do
      it 'is the inverse' do
        expect(decrypted).to eq(plaintext)
      end
    end
  end

  describe '.crack' do
    let(:result) { described_class.crack(ciphertext) }

    context 'when given challenge 3' do
      let(:ciphertext) { '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736' }
      let(:plaintext) { 'Cooking MC\'s like a pound of bacon' }

      it 'finds the key and cracks the ciphertext' do
        expect(result.key).to eq(0x58)
        expect(result.plaintext).to eq(plaintext)
      end
    end

    context 'when cracking our own message' do
      let(:key) { 0xaf }
      let(:plaintext) { 'Lets get cracking' }
      let(:ciphertext) { described_class.encrypt(plaintext, key).bytes2hex }
      let(:result) { described_class.crack(ciphertext) }

      it 'finds the key and cracks the ciphertext' do
        expect(result.key).to eq(key)
        expect(result.plaintext).to eq(plaintext)
      end
    end
  end
end
