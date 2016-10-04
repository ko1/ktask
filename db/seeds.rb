# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times{|i|
  task = Task.create(name: "t#{i}", description: "test-script",
                     script: 'echo hello > "/tmp/foo" & sleep 5',
                     priority: 0, repeat: true)
}

