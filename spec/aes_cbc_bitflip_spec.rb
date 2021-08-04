# frozen_string_literal: true

RSpec.describe(Cryptopals::AESCBCBitflip) do
  describe '.forge_admin' do
    let(:prefix) { 'comment1=cooking%20MCs;userdata=' }
    let(:suffix) { ';comment2=%20like%20a%20pound%20of%20bacon' }

    let(:server) do
      lambda do |user_data|
        escaped = user_data.gsub(/[=;]/, '')
        plaintext = [prefix, escaped, suffix].join
        Cryptopals::RandomAES.cbc_with_unknown_key(plaintext)
      end
    end

    let(:result) { described_class.forge_admin(server) }

    context '' do
      it '' do
        expect(described_class.admin?(result)).to eq(true)
      end
    end
  end
end
