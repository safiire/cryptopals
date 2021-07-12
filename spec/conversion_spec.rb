# frozen_string_literal: true

RSpec.describe(Cryptopals::Conversion) do
  describe '.bytes2hex' do
    let(:result) { described_class.bytes2hex(input) }

    context 'when given AAA' do
      let(:input) { 'AAA' }

      it 'returns 414141' do
        expect(result).to eq('414141')
      end
    end

    context 'when given a string with null' do
      let(:input) { "\x00" }

      it 'returns "00"' do
        expect(result).to eq('00')
      end
    end

    context 'when given empty string' do
      let(:input) { '' }

      it 'returns empty string' do
        expect(result).to eq('')
      end
    end
  end

  describe '.hex2bytes' do
    let(:result) { described_class.hex2bytes(input) }

    context 'when given 414141' do
      let(:input) { '414141' }

      it 'returns AAA' do
        expect(result).to eq('AAA')
      end
    end

    context 'when given baf' do
      let(:input) { 'baf' }
      let(:correct) { String.new("\x0b\xaf", encoding: 'ASCII-8BIT') }

      it 'pads the front' do
        expect(result).to eq(correct)
      end
    end

    context 'when given an empty string' do
      let(:input) { '' }

      it 'returns an empty string' do
        expect(result).to eq('')
      end
    end

    context 'when given 00' do
      let(:input) { '00' }
      let(:correct) { String.new("\x00", encoding: 'ASCII-8BIT') }

      it 'returns \x00' do
        expect(result).to eq(correct)
      end
    end
  end

  describe '.hex2base64' do
    let(:input) { '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d' }
    let(:correct) { 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t' }
    let(:result) { described_class.hex2base64(input) }

    it 'converts it correctly' do
      expect(result).to eq(correct)
    end
  end
end
