# frozen_string_literal: true

RSpec.describe(Cryptopals::RandomAES) do
  describe '.call' do
    context 'when called with plaintext' do
      let(:plaintext) { SecureRandom.random_bytes(32) }
      let(:result) { described_class.call(plaintext) }

      it 'returns a random ecb or cbc encrypted string' do
        expect(result).to be_an_instance_of(String)
        expect(result).to_not be_empty
      end
    end
  end
end
