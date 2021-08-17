# frozen_string_literal: true

RSpec.describe(Cryptopals::MersenneTwister) do
  describe '#rand_int32' do
    let(:seed) { described_class::DEFAULT_SEED }
    let(:mt19937) { described_class.new }
    let(:uint32_max) { 2**32 - 1 }

    context 'when compared with the Ruby mt19937 generator with same seed' do
      let(:ruby_rand) do
        Random.srand(seed)
        1000.times.map { Random.rand(uint32_max) }
      end

      let(:my_rand) do
        mt19937.srand(seed)
        1000.times.map { mt19937.rand_uint32 }
      end

      it 'generates the same output as Random.rand' do
        expect(my_rand).to eq(ruby_rand)
      end
    end
  end
end
