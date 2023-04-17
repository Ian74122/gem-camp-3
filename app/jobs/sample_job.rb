class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # heavy duty it's many take 5s
    sleep 5
    Rails.logger.info 'after heavy duty'
    # end of heavy duty
  end
end
