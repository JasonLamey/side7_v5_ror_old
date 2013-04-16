namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users_and_accounts
    make_journal_entries
    make_friends
    make_museums
  end
end

def make_users_and_accounts
  User.create!(username:              "TestyUser2",
               email_address:         "testy2@example.com",
               password:              "foobar",
               password_confirmation: "foobar")
  user = User.first
  user.create_account(first_name:         "Example",
                       last_name:          "User",
                       other_aliases:      "Bob, Tom, Dick",
                       biography:          "I am an example user.  It's pretty lonely.",
                       birthday:           "1973-01-15",
                       webpage_name:       "Example City",
                       webpage_url:        "www.example.com",
                       blog_name:          "Example Blog",
                       blog_url:           "blog.example.com",
                       aim:                "exampleaim",
                       yahoo:              "exampleyahoo",
                       gtalk:              "examplegtalk",
                       skype:              "exampleskype",
                       state:              "Virginia",
                       country_id:         224)
  99.times do |n|
    username = "#{Faker::Internet.user_name}_00#{n}"
    email_address = Faker::Internet.safe_email
    password = "password"
    User.create!(username: username,
                 email_address: email_address,
                 password: password,
                 password_confirmation: password)

    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    other_aliases = Faker::Name.name
    biography = Faker::Lorem.paragraph(2)
    birthday = Time.at(rand * Time.now.to_i).to_date

    user = User.last
    user.create_account(first_name:     fname,
                         last_name:      lname,
                         other_aliases:  other_aliases,
                         biography:      biography,
                         birthday:       birthday)
  end
end

def make_journal_entries
  users = User.all(limit: 10)
  100.times do
    body = Faker::Lorem.paragraphs(3)
    title = Faker::Lorem.sentence(5)
    users.each { |user| user.account.journals.create!(title: title, body: body) }
  end
end

def make_friends
  accounts = Account.all
  account  = accounts.first
  friended_users = accounts[2..50]
  friended_backs = accounts[3..40]
  friended_users.each { |friended| account.make_friend!(friended) }
  friended_backs.each { |f_backed| f_backed.approve_friend!(account) }
end

def make_museums
  accounts = Account.all
  account  = accounts.first
  watched_accounts = accounts[2..50]
  watchers         = accounts[3..40]
  watched_accounts.each { |watched| account.watch!(watched) }
  watchers.each         { |watcher| watcher.watch!(account) }
end
