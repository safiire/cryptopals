# frozen_string_literal: true

RSpec.describe(Cryptopals::AESCTR) do
  describe '.decrypt' do
    let(:nonce) { 0 }
    let(:key) { 'YELLOW SUBMARINE' }
    let(:result) { described_class.decrypt(ciphertext, nonce, key) }

    let(:plaintext) { "Yo, VIP Let's kick it Ice, Ice, baby Ice, Ice, baby " }
    let(:ciphertext) do
      Base64.decode64(
        'L77na/nrFsKvynd6HzOoG7GHTLXsTVu9qvY/2syLXzhPweyyMTJULu/6/kXX0KSvoOLSFQ=='
      )
    end

    context 'when decrypting challenge 18' do
      it 'decrypts correctly' do
        expect(result).to eq(plaintext)
      end
    end
  end
end
