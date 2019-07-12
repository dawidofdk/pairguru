# frozen_string_literal: true

class ActionError < StandardError
  def initialize(message: nil)
    @message = message
  end

  def errors
    error_message = message || 'data invalid'

    { parameters: [error_message] }
  end

  private

    attr_reader :message
end
