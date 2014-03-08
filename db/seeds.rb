["green", "yellow", "red"].each do |color|
  Status.create(name: color)
end

User.create(name: "admin", password: "admin", admin: true)
