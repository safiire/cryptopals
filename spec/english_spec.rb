# frozen_string_literal: true

RSpec.describe(Cryptopals::English) do
  describe '.score' do
    let(:result) { described_class.score(input) }

    context 'when given english' do
      let(:input) { 'This is an English sentence' }

      it 'should score the string highly' do
        expect(result).to eq(210)
      end
    end

    context 'when given trash bytes' do
      let(:input) { "\x0a\xaf\x99\x32\x12\xee" }

      it 'should score the string lowly' do
        expect(result).to eq(0)
      end
    end
  end
end
