require "rails_helper"

RSpec.describe CardsMailer do
  describe "pending_cards_notification" do
    let!(:user) { create(:user) }
    let!(:mail) { described_class.pending_cards_notification(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('You have pending cards!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['notifications@flashcards.com'])
    end
  end
end
