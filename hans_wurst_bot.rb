class HansWurstBot
  attr_reader :logger,
              :token,
              :message,
              :bot

  def initialize(token:, logger:)
    logger.debug 'setting up hans wurst bot'
    @token = token
    @logger = logger
  end

  def start
    bot.get_updates(fail_silently: true) { |message| handle_message(message) }
  end

  def bot
    @bot ||= TelegramBot.new(token: token, logger: logger)
  end

  def handle_message(message)
    @message = message
    logger.debug "receive (@#{message.from.username}): #{message.text}"
    handle_command(message.get_command_for(bot))
  ensure
    @message = nil
  end

  def handle_command(command)
    case command
    when /^hi|hey|moin|hola$/i
      reply "#{command} #{message.from.first_name}"
    end
  end

  def reply(reply_text)
    return if reply_text.nil?
    message.reply do |reply|
      reply.text = reply_text
      logger.debug "reply (@#{message.from.username}): #{reply.text.inspect}"
      reply.send_with(bot)
    end
  end
end
