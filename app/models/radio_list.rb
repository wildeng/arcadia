# Model that manages the radio states
# @author Alain Mauri
# @version 1.1
class RadioList < ActiveRecord::Base
  include AASM

  # state machine
  aasm do
    state :stopped, initial: true
    state :sleeping
    state :active

    event :sleep do
      transitions from: :active, to: :sleeping
      # needed to prevent unusual user modes....
      transitions from: :sleeping, to: :sleeping
    end

    event :stop do
      transitions from: :sleeping, to: :stopped
      # needed to prevent unusual user modes....
      transitions from: :stopped, to: :stopped
      transitions from: :active, to: :stopped
    end

    event :activate do
      transitions from: :sleeping, to: :active
      transitions from: :stopped, to: :active
      transitions from: :active, to: :active
    end
  end

  RadioList.scope :find_active_radio, -> {
    where('aasm_state = "active" OR aasm_state="sleeping"')
  }

  RadioList.scope :ordered_by_name, -> { order('name asc') }

  def check_link
    true
  end

  def stop_stream
    RadioList.transaction do
      sleep
      save
    end
  end

  def clear_stream
    RadioList.transaction do
      stop
      save
    end
  end

  def activate_stream
    RadioList.transaction do
      activate
      save
    end
  end
end
