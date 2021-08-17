# frozen_string_literal: true

RSpec.describe(Cryptopals::MersenneTwister) do
  describe '#genrand_int32' do
    let(:mt19937) { described_class.new }

    context 'when compared with the Ruby mt19937 generator' do
      let(:ruby_mt19937) do
        Random.srand(5489)
        1000.times.map { Random.rand(2**32 - 1) }
      end

      let(:my_mt19937) do
        1000.times.map { mt19937.rand_uint32 }
      end

      it 'generates the same out put as Random.rand' do
        expect(my_mt19937).to eq(ruby_mt19937)
      end
    end
  end
end
