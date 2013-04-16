# == Schema Information
#
# Table name: accounts
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  first_name              :string(45)
#  last_name               :string(45)
#  user_type_id            :integer          default(1), not null
#  user_status_id          :integer          default(1), not null
#  reinstate_on            :date
#  other_aliases           :string(255)
#  biography               :text
#  birthday                :date             not null
#  birthday_visibility     :integer          default(1), not null
#  webpage_name            :string(255)
#  webpage_url             :string(255)
#  blog_name               :string(255)
#  blog_url                :string(255)
#  aim                     :string(45)
#  yahoo                   :string(45)
#  gtalk                   :string(45)
#  skype                   :string(45)
#  state                   :string(255)
#  country_id              :integer
#  is_public               :integer
#  referred_by             :integer
#  subscription_expires_on :date
#  delete_on               :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'spec_helper'

describe Account do

  let(:user) { FactoryGirl.create(:user) }
  before  { @account = FactoryGirl.create(:account, user_id: user.id) }

  subject { @account }

  # Account
  it { should respond_to(:user_id)                 }
  it { should respond_to(:first_name)              }
  it { should respond_to(:last_name)               }
  it { should respond_to(:user_type_id)            }
  it { should respond_to(:user_status_id)          }
  it { should respond_to(:reinstate_on)            }
  it { should respond_to(:other_aliases)           }
  it { should respond_to(:biography)               }
  it { should respond_to(:birthday)                }
  it { should respond_to(:birthday_visibility)     }
  it { should respond_to(:webpage_name)            }
  it { should respond_to(:webpage_url)             }
  it { should respond_to(:blog_name)               }
  it { should respond_to(:blog_url)                }
  it { should respond_to(:aim)                     }
  it { should respond_to(:yahoo)                   }
  it { should respond_to(:gtalk)                   }
  it { should respond_to(:skype)                   }
  it { should respond_to(:state)                   }
  it { should respond_to(:country_id)              }
  it { should respond_to(:is_public)               }
  it { should respond_to(:referred_by)             }
  it { should respond_to(:subscription_expires_on) }
  it { should respond_to(:delete_on)               }
  it { should respond_to(:user)                    }

  # Journal
  it { should respond_to(:journals)                }

  # UserLink
  it { should respond_to(:user_links)              }

  # Friend
  it { should respond_to(:relationships)           }
  it { should respond_to(:reverse_relationships)   }
  it { should respond_to(:friended_accounts)       }
  it { should respond_to(:friended_backs)          }
  it { should respond_to(:friends?)                }
  it { should respond_to(:make_friend!)            }
  it { should respond_to(:approve_friend!)         }
  it { should respond_to(:unfriend!)               }

  # Museum
  it { should respond_to(:museums)                 }
  it { should respond_to(:watched_accounts)        }
  it { should respond_to(:watching?)               }
  it { should respond_to(:watch!)                  }
  it { should respond_to(:unwatch!)                }
  it { should respond_to(:reverse_museums)         }
  it { should respond_to(:watchers)                }

  # UserPreference
  it { should respond_to(:user_preference)         }

  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @account.user_id = nil }
    it { should_not be_valid }
  end

  describe "when user_type_id is not present" do
    before { @account.user_type_id = nil }
    it { should_not be_valid }
  end

  describe "when user_status_id is not present" do
    before { @account.user_status_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Account.new(user_id: user.id, first_name: 'Example', last_name: 'User', birthday: '1973-01-15')
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    it "should not allow access to user_status_id" do
      expect do
        Account.new(user_status_id: '2', first_name: 'Example', last_name: 'User', birthday: '1973-01-15')
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    it "should not allow access to user_type_id" do
      expect do
        Account.new(user_type_id: '2', first_name: 'Example', last_name: 'User', birthday: '1973-01-15')
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "journal associations" do
    before { @account.save }
    let!(:old_journal) do
      FactoryGirl.create(:journal, account: @account, allow_comments: :anyone, privacy: :public, created_at: 1.day.ago)
    end
    let!(:new_journal) do
      FactoryGirl.create(:journal, account: @account, allow_comments: :anyone, privacy: :public, created_at: 1.hour.ago)
    end

    it "should have the right journal entries in the right order" do
      @account.journals.should == [new_journal, old_journal]
    end
  end

  describe "user_link associations" do
    before { @account.save }
    let!(:link_five) do
      FactoryGirl.create(:user_link, account: @account, name: "Link 5", url: "www.link5.com", nsfw: 0, sort_order: 5)
    end
    let!(:link_one) do
      FactoryGirl.create(:user_link, account: @account, name: "Link 1", url: "www.link1.com", nsfw: 1, sort_order: 1)
    end

    it "should have the right user_links in the right order" do
      @account.user_links.should == [link_one, link_five]
    end
  end

  describe "friending" do
    let(:other_user) { FactoryGirl.create(:user, username: 'OtherUser', email_address: 'other@example.com') }
    let(:other_acct) { other_user.create_account(birthday: '1980-10-01') }
    before do
      @account.save!
      @account.make_friend!(other_acct)
    end

    it { should be_friends(other_user.account) }
    its(:friended_accounts) { should include(other_acct) }

    describe "friended account" do
      subject { other_acct }
      its(:friended_backs) { should include(@account) }

      describe "approving friend request" do
        before do
          other_user.account.approve_friend!(@account)
        end

        its(:friended_accounts) { should include(@account) }
      end
    end

    describe "and unfriending" do
      before { @account.unfriend!(other_acct) }
      it { should_not be_friends(other_user.account) }
      its(:friended_accounts) { should_not include(other_user.account) }
    end
  end

  describe "watching" do
    let(:other_user) { FactoryGirl.create(:user, username: 'OtherUser', email_address: 'other@example.com') }
    let(:other_acct) { other_user.create_account(birthday: '1980-10-01') }
    before do
      @account.save!
      @account.watch!(other_acct)
    end

    it { should be_watching(other_user.account) }
    its(:watched_accounts) { should include(other_user.account) }

    describe "watched accounts" do
      subject { other_acct }
      its(:watchers) { should include(@account) }
    end

    describe "and unwatching" do
      before { @account.unwatch!(other_acct) }

      it { should_not be_watching(other_user.account) }
      its(:watched_accounts) { should_not include(other_user.account) }
    end
  end
end
