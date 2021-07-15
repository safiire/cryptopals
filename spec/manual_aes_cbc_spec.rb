# frozen_string_literal: true

RSpec.describe(Cryptopals::ManualAESCBC) do
  describe '.decrypt' do
    let(:iv) { "\x00" * 0x10 }
    let(:key) { 'YELLOW SUBMARINE' }
    let(:result) { described_class.decrypt(ciphertext, iv, key) }

    let(:ciphertext) do
      path = File.join(__dir__, 'fixtures/challenge10.b64')
      contents = File.read(path)
      Base64.decode64(contents)
    end
    let(:plaintext) do
      path = File.join(__dir__, 'fixtures/challenge7.decrypted')
      File.read(path)
    end

    context 'when decrypting challenge 10' do
      it 'decrypts properly' do
        expect(result).to eq(plaintext)
      end
    end
  end
end
