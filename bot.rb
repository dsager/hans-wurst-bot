require 'telegram_bot'
require 'logger'

require_relative 'hans_wurst_bot'
hans_wurst = HansWurstBot.new(
  logger: Logger.new(STDOUT, Logger::DEBUG),
  token: ENV['HANS_WURST_BOT_TOKEN']
)
hans_wurst.start
