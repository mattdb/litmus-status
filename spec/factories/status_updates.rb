FactoryBot.define do
  factory :status_update do
    transient do
      completeness {[:only_status, :only_message, :both].sample }
    end
    is_up { completeness == :only_message ? nil : [true, false].sample }
    message { completeness == :only_status ? nil : Faker::TheITCrowd.quote }
  end
end
