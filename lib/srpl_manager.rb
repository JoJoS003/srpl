#encoding=utf-8

require 'srpl'
require 'yaml'
require 'erb'

module SRPL

  class SRPLManager
    
    attr_reader :league
    attr_accessor :tpl_path
    
    def initialize(plist = nil)
      @file = 'league.yml'
      from_players(plist.to_s) if plist

      game = File.basename(Dir.pwd)
      @tpl_path = "#{File.dirname(__FILE__)}/../tpl/#{game}"
    end
    
    def load
      @league = @file ? YAML::load(File.read(@file)) : League.new
    end
    
    def save
      File.write(@file, YAML::dump(@league))
    end
    
    def rank
      players = @league.rank
      template('rank').result(binding)
    end
    
    def characters
      persos = {}
      @league.players.each do |p|
        persos[p.character] = persos[p.character] ? persos[p.character] + 1 : 1
      end
      persos = persos.sort_by {|perso, nbr| nbr}.reverse!
      
      template('characters').result(binding)
    end
    
    def rounds
      output = ''
      @league.rounds.reverse.each do |round|
        output += template('rounds').result(binding)
      end
      output
    end
    
    private 
    
    def from_players(file)
      reg = /^(?<nick>[\w\s]+) <(?<email>[\w\d\-_.]+@[\w\d-_.]+\.[\w]{2,4})> : (?<chara>[\w\. \-]+)$/

      @league = League.new

      File.open(file, 'r') do |io|
        io.lines do |line|
          m = reg.match line
          @league.add_player(Player.new(m['nick'], m['chara'], m['email'])) if m
        end
      end
      
      @league
    end
    
    def perso_img(perso)
      "http://shoryupif.fr/wp-content/uploads/2012/07/sprite_#{perso.downcase}.png"
    end
    
    def format_date(date)
      format_in = "%Y%m%d%H%M"
      format_out = "%d/%m/%Y à %Hh%M"
      
      date ? DateTime.strptime(date, format_in).strftime(format_out) : 'à venir'
    end
    
    def template(name)
      ERB.new(File.read(File.join(@tpl_path, "#{name}.html.erb")))
    end
    
  end

end
