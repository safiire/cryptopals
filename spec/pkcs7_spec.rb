# frozen_string_literal: true

RSpec.describe(Cryptopals::PKCS7) do
  describe '.call' do
    let(:result) { described_class.call(block, size: size) }
    let(:block) { 'YELLOW SUBMARINE' }

    context 'when given the challenge 9 block' do
      let(:size) { 20 }
      let(:correct) { "YELLOW SUBMARINE\x04\x04\x04\x04" }

      it 'should pad the block correctly' do
        expect(result).to eq(correct)
      end
    end

    context 'when given an empty block' do
      let(:size) { 16 }
      let(:block) { '' }
      let(:correct) { "\x10" * 0x10 }

      it 'should pad the block correctly' do
        expect(result).to eq(correct)
      end
    end

    context 'when given a block that is bigger than size' do
      let(:size) { block.size.pred }

      it 'should pad the block correctly' do
        expect { result }.to raise_error(described_class::BlockBiggerThanSize)
      end
    end
  end
end
