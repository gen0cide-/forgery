require 'spec_helper'

describe Forgery::RussianTax do

  it 'bik should be 9 symbols' do
    expect(Forgery::RussianTax.bik.length).to eq 9
  end

  it "bik should start with 04" do
    expect(Forgery::RussianTax.bik[0,2]).to eq '04'
  end

  it "bik should have valid last part" do
    expect(Forgery::RussianTax.bik[6,8].to_i).to be > 50
  end

  it 'bik should be 20 symbols' do
    expect(Forgery::RussianTax.account_number.length).to eq 20
  end

  context 'legal inn' do
    let(:inn) { Forgery::RussianTax.inn({ :type =>:legal }) }

    it 'legal inn should be 10 symbols' do
      expect(inn.length).to eq 10
    end

    it 'leagl inn crc' do
      mask = [2, 4, 10, 3, 5, 9, 4, 6, 8]
      expect((0..(inn.length-2)).inject(0) {|crc, i| crc + inn[i].to_i*mask[i].to_i} % 11 % 10).to  eq inn[9].chr.to_i
    end

  end

  context 'person inn' do
    let(:inn) { Forgery::RussianTax.inn({ :type => :person }) }

    it 'person inn should be 12 symbols' do
      expect(inn.length).to eq 12
    end

    it 'person inn crc 10' do
      mask = [7, 2, 4, 10, 3, 5, 9, 4, 6, 8]
      expect((0..(inn.length-3)).inject(0) {|crc, i| crc + inn[i].to_i*mask[i].to_i} % 11 % 10).to eq inn[10].chr.to_i
    end

    it 'person inn crc 11' do
      mask = [3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8]
      expect((0..(inn.length-2)).inject(0) {|crc, i| crc + inn[i].to_i*mask[i].to_i} % 11 % 10).to eq inn[11].chr.to_i
    end

  end

  context 'legal ogrn' do
    let(:ogrn) { Forgery::RussianTax.ogrn({ :type => :legal }) }

    it 'legal ogrn should be 13 symbols' do
      expect(ogrn.length).to eq 13
    end

    it 'legal ogrn should have valid crc' do
      expect(ogrn[0..-2].to_i%11%10).to eq ogrn[-1].chr.to_i
    end
  end

  context 'person ogrn' do
    let(:ogrn) { Forgery::RussianTax.ogrn({ :type => :person }) }

    it 'person ogrn should be 15 symbols' do
      expect(ogrn.length).to eq 15
    end

    it 'person ogrn should have valid crc' do
      expect(ogrn[0..-2].to_i%13%10).to eq ogrn[-1].chr.to_i
    end
  end




end
