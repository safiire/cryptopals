# frozen_string_literal: true

RSpec.describe(Cryptopals::AESMode) do
  describe '.detect_mode' do
    let(:plaintext) { "\x00" * 2000 }
    let(:ciphertext) { Cryptopals::RandomAES.call(plaintext, mode) }

    context 'when given ciphertext encrypted in AES ECB mode' do
      let(:mode) { :ecb }
      let(:result) { described_class.detect_mode(ciphertext) }

      it 'it detects it' do
        expect(result).to eq(mode)
      end
    end

    context 'when given ciphertext encrypted in AES CBC mode' do
      let(:mode) { :cbc }
      let(:result) { described_class.detect_mode(ciphertext) }

      it 'it detects it' do
        expect(result).to eq(mode)
      end
    end
  end
end
