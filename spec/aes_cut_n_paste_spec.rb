# frozen_string_literal: true

RSpec.describe(Cryptopals::AESCutNPaste) do
  describe '.profile_for' do
    context 'when given an email address' do
      let(:result) { described_class.profile_for('a@example.com').bytes2hex }

      it 'returns a ciphertext' do
        expect(result).to match(/\A[a-f0-9]{96}\z/)
      end
    end

    describe '.admin?' do
      let(:result) { described_class.admin?(ciphertext) }

      context 'when given ciphertext with role=user' do
        let(:ciphertext) { described_class.profile_for('a@example.com') }

        it 'returns false' do
          expect(result).to eq(false)
        end
      end

      context 'when given ciphertext with role=admin' do
        let(:ciphertext) { described_class.profile_for('a@example.com', 'admin') }

        it 'returns true' do
          expect(result).to eq(true)
        end
      end

      context '.forge_admin_role' do
        let(:oracle) do
          ->(email) { described_class.profile_for(email) }
        end
        let(:forged_ciphertext) { described_class.forge_admin_role(oracle) }

        it 'forges a ciphertext with admin role' do
          expect(described_class.admin?(forged_ciphertext)).to eq(true)
        end
      end
    end
  end
end
