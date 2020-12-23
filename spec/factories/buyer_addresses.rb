FactoryBot.define do
  factory :buyer_address do
    prefectural_id { 2 }
    postal_code    {"123-4567"}
    city           {"大阪"}
    street         {"1-1-1"}
    tel            {"09000000000"}
    building       {"建物"}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
