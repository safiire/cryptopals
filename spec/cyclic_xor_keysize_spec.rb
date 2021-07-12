# frozen_string_literal: true

require 'pry-byebug'

RSpec.describe(Cryptopals::CyclicXorKeysize) do
  describe '.call' do
    let(:ciphertext) do
      path = File.join(__dir__, 'fixtures/challenge6.b64')
      contents = File.read(path)
      Base64.decode64(contents)
    end

    let(:results) { described_class.call(ciphertext) }
    let(:correct_keysize) { 29 }

    context 'when given the challenge6.b64 file' do
      it 'returns a result including the correct keysize' do
        expect(results).to include(correct_keysize)
      end
    end
  end
end
