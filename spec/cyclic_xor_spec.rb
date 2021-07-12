# frozen_string_literal: true

RSpec.describe(Cryptopals::CyclicXor) do
  describe '.crack' do
    context 'when given challenge6' do
      let(:result) { described_class.crack(ciphertext) }

      let(:ciphertext) do
        path = File.join(__dir__, 'fixtures/challenge6.b64')
        contents = File.read(path)
        Base64.decode64(contents)
      end

      let(:correct_plaintext) do
        path = File.join(__dir__, 'fixtures/challenge6.decrypted')
        File.read(path)
      end

      it 'discovers the key' do
        expect(result.key).to eq('Terminator X: Bring the noise')
      end

      it 'cracks the file' do
        expect(result.plaintext).to eq(correct_plaintext)
      end
    end

    context 'when we try to crack our own ciphertext' do
      let(:key) { 'ice' }
      let(:plaintext) { 'This is some plaintext that I want to crack' }
      let(:ciphertext) { plaintext.cyclic_xor(key) }
      let(:result) { described_class.crack(ciphertext, max_keysize: 9) }

      it 'discovers the key' do
        expect(result.key).to eq(key)
      end

      it 'cracks the ciphertext' do
        expect(result.plaintext).to eq(plaintext)
      end
    end
  end
end
