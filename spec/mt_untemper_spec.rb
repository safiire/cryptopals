# frozen_string_literal: true

RSpec.describe(Cryptopals::MTUntemper) do
  let(:uint32_max) { 2**32 - 1 }

  describe '.undo_xor_lsr' do
    let(:y) { x ^ (x >> shift) }
    let(:result) { described_class.undo_xor_lsr(y, shift) }

    context 'when undoing this operation' do
      let(:shift) { 18 }
      let(:x) { 0b0010_0101_0010_1100_0011_0101_0110_0101 }

      it 'gives the correct result' do
        expect(result).to eq(x)
      end
    end

    context 'when undoing this operation with random arguments' do
      let(:shift) { Random.rand(1..31) }
      let(:x) { Random.rand(uint32_max) }

      it 'gives the correct result' do
        expect(result).to eq(x)
      end
    end
  end

  describe '.undo_xor_lsl_and' do
    let(:y) { x ^ (x << shift) & c }
    let(:result) { described_class.undo_xor_lsl_and(y, shift, c) }

    context 'when undoing this operation' do
      let(:shift) { 15 }
      let(:x) { 0b1110_0111_0011_0001_0000_1100_1111_0011 }
      let(:c) { 0xefc60000 }

      it 'gives the correct result' do
        expect(result).to eq(x)
      end
    end

    context 'when undoing this operation with random arguments' do
      let(:shift) { Random.rand(1..31) }
      let(:x) { Random.rand(uint32_max) }
      let(:c) { Random.rand(uint32_max) }

      it 'gives the correct result' do
        expect(result).to eq(x)
      end
    end
  end
end
