# frozen_string_literal: true

RSpec.describe(Cryptopals::Operations) do
  describe '.fixed_xor' do
    let(:result) { described_class.fixed_xor(a, b) }

    context 'when the inputs are not the same byte length' do
      let(:a) { 'differing' }
      let(:b) { 'lengths' }

      it 'throws an error' do
        expect { result }.to raise_error(described_class::DifferingLengths)
      end
    end

    context 'when the inputs are the same lengths' do
      let(:a) { 'same' }
      let(:b) { 'size' }
      let(:correct) { "\x00\b\x17\x00" }

      it 'xors them together' do
        expect(result).to eq(correct)
        expect(a ^ b).to eq(correct)
      end
    end
  end

  describe '.cyclic_xor' do
    let(:result1) { described_class.cyclic_xor(a, b) }
    let(:result2) { described_class.cyclic_xor(b, a) }
    let(:correct) { 'iceiceicei' }

    context 'when one term is shorter' do
      let(:a) { "\x00" * 10 }
      let(:b) { 'ice' }

      it 'calculates by cycling the shorter term' do
        expect(result1).to eq(correct)
        expect(result2).to eq(correct)
      end
    end
  end

  describe '.aes_128_ecb_decrypt' do
    let(:key) { 'YELLOW SUBMARINE' }
    let(:ciphertext) do
      path = File.join(__dir__, 'fixtures/challenge7.b64')
      contents = File.read(path)
      Base64.decode64(contents)
    end
    let(:plaintext) do
      path = File.join(__dir__, 'fixtures/challenge7.decrypted')
      File.read(path)
    end

    context 'when decrypting challenge7' do
      it 'should decrypt the file' do
        expect(ciphertext.aes_128_ecb_decrypt(key)).to eq(plaintext)
      end
    end

    context 'when encrypting aes cbc' do
      let(:key) { 'YELLOW SUBMARINE' }
      let(:plaintext) { 'This is some text to encrypt and decrypt' }
      let(:ciphertext) { plaintext.aes_128_ecb_encrypt(key) }

      it 'can decrypt it' do
        expect(ciphertext.aes_128_ecb_decrypt(key)).to eq(plaintext)
      end
    end
  end
end
