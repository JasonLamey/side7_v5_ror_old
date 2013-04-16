FactoryGirl.define do
  factory :user do
    username              "TestyUser"
    email_address         "testy@example.com"
    password              "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :account do
    user
    first_name            "Example"
    last_name             "User"
    other_aliases         "Bob, Tom, Dick"
    biography             "I am an example user.  It's pretty lonely."
    birthday              "1973-01-15"
    webpage_name          "Example City"
    webpage_url           "www.example.com"
    blog_name             "Example Blog"
    blog_url              "blog.example.com"
    aim                   "exampleaim"
    yahoo                 "exampleyahoo"
    gtalk                 "examplegtalk"
    skype                 "exampleskype"
    state                 "Virginia"
    country_id            224
  end

  factory :journal do
    title                 "Example Journal"
    body                  Faker::Lorem::paragraphs(3)
    privacy               "Public"
    allow_comments        "Anyone"
    account
  end

  factory :user_link do
    name                  "Example Link"
    url                   "http://www.example.com"
    nsfw                  0
    sort_order            1
    click_throughs        15
    account
  end

  factory :friend do
    account
    friend_id             2
    accepted              1
  end

  factory :watched do
    watcher_id            account
    watched_id            1
  end
end
