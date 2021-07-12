# frozen_string_literal: true

RSpec.describe(Cryptopals::Operations) do
  describe '.fixed_xor' do
    let(:result) { described_class.fixed_xor(a, b) }

    context 'when the inputs are not the same byte length' do
      let(:a) { 'differing' }
      let(:b) { 'lengths' }

      it 'throws an error' do
        expect { result }.to raise_error(Cryptopals::Operations::DifferingLengths)
      end
    end

    context 'when the inputs are the same lengths' do
      let(:a) { 'same' }
      let(:b) { 'size' }
      let(:correct) { "\x00\b\x17\x00" }

      it 'xors them together' do
        expect(result).to eq(correct)
      end
    end
  end

  describe '.cyclic_xor' do
    let(:result1) { described_class.cyclic_xor(a, b) }
    let(:result2) { described_class.cyclic_xor(b, a) }
    let(:correct) { 'iceiceicei' }

    context 'when the second term is shorter' do
      let(:a) { "\x00" * 10 }
      let(:b) { 'ice' }

      it 'calculates by cycling the shorter term' do
        expect(result1).to eq(correct)
        expect(result2).to eq(correct)
      end
    end
  end
end
