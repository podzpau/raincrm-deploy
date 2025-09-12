class DealsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "deals_#{current_user.id}"
    stream_from "deals_global" # For team-wide updates
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # Handle incoming real-time data if needed
  end
end
