["green", "yellow", "red"].each do |color|
  Status.create(name: color)
end
ApiKey.create
