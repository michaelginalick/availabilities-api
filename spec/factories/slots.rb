FactoryBot.define do
  factory :slot do
    start_time { Time.zone.now.strftime("%Y-%m-%d %H:%M:%S %z") }
    end_time { (Time.zone.now + 2.hours).strftime("%Y-%m-%d %H:%M:%S %z")  }
  end
end
