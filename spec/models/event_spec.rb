require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe '#created_by?' do
    let(:event) { create(:event) }
    subject { event.created_by?(user) }

    context '引数がnilのとき' do
      let(:user) { nil }
      it { should be_falsey }
    end

    context '#owner_idと引数の#idが同じとき' do
      let(:user) { double('user', id: event.id) }
      it { should be_truthy }
    end
  end

  describe '#rails?' do
    context '#nameが"Rails勉強会"のとき' do
      it 'trueを返すこと' do
        event = create(:event, name: 'Rails勉強会')
        expect(event.rails?).to eq true
      end
    end

    context '#nameが"Ruby勉強会"のとき' do
      it 'falseを返すこと' do
        event = create(:event, name: 'Ruby勉強会')
        expect(event.rails?).to eq false
      end
    end
  end
end
