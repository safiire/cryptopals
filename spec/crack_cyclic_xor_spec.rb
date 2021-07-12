# frozen_string_literal: true

RSpec.describe(Cryptopals::CrackCyclicXor) do
  describe '.call' do
    let(:ciphertext) do
      path = File.join(__dir__, 'fixtures/challenge6.b64')
      contents = File.read(path)
      Base64.decode64(contents)
    end

    let(:correct_plaintext) do
      path = File.join(__dir__, 'fixtures/challenge6.decrypted')
      File.read(path)
    end

    let(:result) { described_class.call(ciphertext) }

    context 'when given challenge6' do
      it 'decrypts the file correctly' do
        expect(result).to eq(correct_plaintext)
      end
    end
  end
end
