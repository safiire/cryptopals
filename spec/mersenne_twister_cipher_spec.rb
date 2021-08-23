# frozen_string_literal: true

RSpec.describe(Cryptopals::MersenneTwisterCipher) do
  describe '.decrypt' do
    let(:seed) { 64_265 }
    let(:plaintext) { 'Hey hey, time to encrypt some stuff in a shitty way, lesssgo!' }
    let(:ciphertext) { described_class.encrypt(plaintext, seed) }
    let(:decrypted) { described_class.decrypt(ciphertext, seed) }

    context 'when testing both methods' do
      it 'can decrypt what it encrypts' do
        expect(decrypted).to eq(plaintext)
      end
    end
  end
end
