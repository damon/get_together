# encoding: UTF-8

class Location
  def self.init
    @trieds = read_locations("tried.txt")
    @not_trieds = read_locations ("not_tried.txt")
  end

  def self.esc(text)
    #Rack::Utils.escape_html(text)
    text
  end

  def self.read_locations(fn)
  	File.open(fn, "r:UTF-8") do |f| 
      f.read.split("\n").compact
    end 
  end
  
  def self.suggest
  	available = not_tried.collect {|x| x[:name]}
    h = {}
    1000000.times do
      n = Random.rand(available.size).to_s
      h[n] = (h[n] ? h[n] += 1 : 1)
    end
    name = available[h.sort_by {|_key, value| value}.reverse[0][0].to_i]
    {:name => esc(name)}
  end

  def self.tried
    @trieds.collect {|x| {:name => esc(x)}}
  end

  def self.not_tried
    @not_trieds.collect {|x| {:name => esc(x)}}
  end

  def self.all
    tried.collect {|x| {name: x[:name], status: 'tried'}} + not_tried.collect {|x| {name: x[:name], status: 'not-tried'}}
  end
end