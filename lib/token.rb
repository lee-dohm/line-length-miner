#
# Copyright (c) 2013 by Lifted Studios. All Rights Reserved.
#

require 'highline/import'
require 'octokit'

# Represents a GitHub API access token.
class Token
  # Creates the token from the storage location or retrieves one from GitHub.
  #
  # @return [Token] New or stored token.
  def self.create
    Token.create_authorization unless File.exists?(Token.path)
    Token.new(File.read(Token.path))
  end

  # Creates a new authorization given the user's GitHub credentials.
  #
  # @return [nil]
  def self.create_authorization
    puts 'Enter your GitHub credentials. They will be used to create an API access token for '\
         'future connections.'
    login = ask('Email Address: ')
    password = ask('Password: ') { |q| q.echo = '*' }

    client = Octokit::Client.new(login: login, password: password)
    token = client.create_authorization(note: 'line-length-miner',
                                        note_url: 'https://github.com/lee-dohm/line-length-miner')
    File.write(Token.path, token.token)

    nil
  end

  # Standard location where the access token should be stored.
  #
  # @return [String] Path at which to store the token.
  def self.path
    File.expand_path('../../.token', __FILE__)
  end

  # Creates a new Token object.
  #
  # @param [String] 40-character token text.
  def initialize(text)
    @text = text
  end

  # Returns the token text.
  #
  # @return [String] 40-character token text.
  def to_s
    @text
  end
end
