class RadioList < ActiveRecord::Base
  attr_accessible :name, :description, :radio_url
  include AASM

  attr_accessible :name,:description, :radio_url, :aasm_state

  # state machine
  aasm do
    state :stopped, :initial => true
    state :sleeping
    state :active

    event :sleep do
      transitions :from => :active, :to => :sleeping
    end

    event :stop do
      transitions :from => :active, :to => :stopped
      transitions :from => :sleeping, :to => :stopped
    end

    event :activate do
      transitions :from => :sleeping, :to => :active
      transitions :from => :stopped, :to => :active
      transitions :from => :active, :to => :active
    end
  end

  def check_link
  	return true
  end

  def stop_stream
    RadioList.transaction do
      self.sleep
      self.save
    end
  end

  def clear_stream
    RadioList.transaction do
      self.stop
      self.save
    end
  end

  def activate_stream
    RadioList.transaction do
      self.activate
      self.save
    end
  end
end
