# encoding: UTF-8

class Location
  def self.init
    @locations = read_locations("locations.txt")
  end

  # def self.esc(text)
  #   Rack::Utils.escape_html(text)
  # end

  def self.read_locations(fn)
    locs = {:tried => [], :not_tried => []}

  	File.open(fn, "r:UTF-8") do |f| 
      line = f.read.split("\n").compact
      if line[1].downcase=="tried"
        locs[:tried] << line[0]
      elsif line[1].downcase=="not-tried"
        locs[:not_tried] << line[0]
      end
    end

    locs
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
    @locations[:tried]
  end

  def self.not_tried
    @locatoins[:not_tried]
  end

  def self.all
    tried.collect {|x| {name: x[:name], status: "tried"}} + not_tried.collect {|x| {name: x[:name], status: "not-tried"}}
  end
end