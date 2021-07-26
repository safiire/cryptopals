# frozen_string_literal: true

RSpec.describe(Cryptopals::AESBlocksize) do
  describe '.call' do
    let(:unknown_plaintext) do
      Base64.decode64(
        'Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkg' \
        'aGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBq' \
        'dXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUg' \
        'YnkK'
      )
    end
    let(:result) do
      described_class.detect_blocksize(unknown_plaintext) do |plaintext|
        Cryptopals::RandomAES.ecb_with_unknown_key(plaintext)
      end
    end

    context 'when passed a block' do
      it 'uses the block as an oracle to discover the block size' do
        expect(result).to eq(0x10)
      end
    end
  end
end
