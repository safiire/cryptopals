# frozen_string_literal: true

RSpec.describe(Cryptopals::MersenneTwister) do
  let(:uint32_max) { 2**32 - 1 }
  let(:seed) { described_class::DEFAULT_SEED }

  describe '#rand_int32' do
    let(:mt19937) { described_class.new }

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

  describe '.clone' do
    let(:get_next) { -> { Random.rand(uint32_max) } }
    let(:clone) { described_class.clone(get_next) }

    let(:outputs) do
      1000.times.map { Random.rand(uint32_max) }
    end

    let(:cloned_outputs) do
      1000.times.map { clone.rand_uint32 }
    end

    context 'when given any mersenne twister' do
      it 'clones it' do
        expect(cloned_outputs).to eq(outputs)
      end
    end
  end
end
