# frozen_string_literal: true

require 'pry-byebug'

RSpec.describe(Cryptopals::PKCS7) do
  describe '.pad' do
    let(:size) { 0x10 }
    let(:block) { 'YELLOW SUBMARINE' }
    let(:result) { described_class.pad(block, size: size) }

    context 'when given a block that doesnt need padding' do
      it 'should do nothing' do
        expect(result).to eq(block)
      end
    end

    context 'when given a block that needs padding' do
      let(:size) { 0x14 }
      let(:correct) { "YELLOW SUBMARINE\x04\x04\x04\x04" }

      it 'should pad the block' do
        expect(result).to eq(correct)
      end
    end

    context 'when given an empty block' do
      let(:block) { '' }
      let(:correct) { "\x10" * 0x10 }

      it 'is completely padded' do
        expect(result).to eq(correct)
      end
    end

    context 'when given a block that is bigger than size' do
      let(:size) { block.size.pred }

      it 'should throw an error' do
        expect { result }.to raise_error(described_class::BlockBiggerThanSize)
      end
    end
  end

  describe '.unpad' do
    let(:size) { 0x10 }
    let(:block) { 'YELLOW SUBMARINE' }
    let(:result) { described_class.unpad(block, size: size) }

    context 'when given a block that has no padding' do
      it 'does nothing' do
        expect(result).to eq(block)
      end
    end

    context 'when given a block that has padding' do
      let(:block) { "YELLOW SUBMARINE\x04\x04\x04\x04" }
      let(:correct) { 'YELLOW SUBMARINE' }

      it 'removes the padding' do
        expect(result).to eq(correct)
      end
    end

    context 'when given a block that is all padding' do
      let(:size) { 3 }
      let(:block) { "\x03\x03\x03" }

      it 'returns an empty string' do
        expect(result).to eq('')
      end
    end
  end
end
