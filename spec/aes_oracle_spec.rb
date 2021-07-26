# frozen_string_literal: true

RSpec.describe(Cryptopals::AESOracle) do
  let(:oracle) do
    lambda do |user_controlled|
      Cryptopals::RandomAES.ecb_with_unknown_key(user_controlled + unknown_plaintext)
    end
  end
  let(:result) { described_class.crack_ecb(oracle) }

  describe '.crack_ecb' do
    let(:unknown_plaintext) do
      Base64.decode64(
        'Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkg' \
        'aGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBq' \
        'dXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUg' \
        'YnkK'
      )
    end

    context 'when given challenge 12' do
      it 'uses the oracle to crack unknown_plaintext' do
        expect(result).to eq(unknown_plaintext)
        p result
      end
    end
  end

  let(:unknown_plaintext) do
    ' : This is a secret message that no one will ever guess'
  end

  context 'when given the example in my writeup' do
    it 'uses the oracle to crack uknown_plaintext' do
      expect(result).to eq(unknown_plaintext)
    end
  end
end
