require 'twitter'
require 'dotenv'

Dotenv.load!

TWEET_MAX_SIZE = 140
SUFFIX_SIZE = 2 # "@".size + " ".size
PREFIX_SIZE = 22 # "名前をつけようか Snow halation".size
TEXT_MAX_SIZE = TWEET_MAX_SIZE - SUFFIX_SIZE - PREFIX_SIZE

@stream = Twitter::Streaming::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

@stream.user do |object|
  if object.is_a?(Twitter::Tweet)
    text = object.text
    if text.match(/には$/) && text.size + object.user.screen_name.size <= TEXT_MAX_SIZE
      puts "@#{object.user.screen_name} #{text}名前をつけようか Snow halation"
      @client.update "@#{object.user.screen_name} #{text}名前をつけようか Snow halation"
    end
  end
end
