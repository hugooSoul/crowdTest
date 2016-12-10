# == Schema Information
#
# Table name: projects
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  name              :string
#  short_description :text
#  description       :text
#  image_url         :string
#  status            :string           default("pending")
#  goal              :decimal(8, 2)
#  expiration_date   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Project < ActiveRecord::Base

  belongs_to :user
  has_many :rewards

  before_validation :start_project, :on => :create
  validates :name, :short_description, :description, :image_url, :expiration_date, :goal, presence: true

  def pledges
    rewards.flat_map(&:pledges)
  end

  def total_backed_amount
    pledges.map(&:amount).inject(0, :+)
  end

  def funded?
    status == "funded"
  end

  def expired?
    status == "expired"
  end

  def canceled?
    status == "canceled"
  end

  def funded!
    update(status: "funded")
  end

  def expired!
    update(status: "expired")
    void_pledged
  end

  def canceled!
    update(status: "canceled")
    void_pledged
  end


  private

  def void_pledged
    self.pledges.each { |p| p.void! }
  end

  def start_project
    self.expiration_date = 1.month.from_now
  end

end
