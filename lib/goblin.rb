#!/usr/bin/env ruby
require 'socket'

class Goblin

  def initialize(messages, user, server, port)
    @messages = messages
    @user = user
    @socket = TCPSocket.open(server, port)
    say "Nick goblin_irc_thing"
    say "User ircbot 0 * IRCBot"
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end

  def say_to_name
    @messages.each {|n| say "PRIVMSG #{@user} :#{n}"}
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg

      if msg.match(/End\sof/)
        say_to_name
        quit
      end
    end
    @socket.close
  end

  def quit
    say "PART ##{@channel} : Bye bye."
    say 'QUIT'
  end
end
