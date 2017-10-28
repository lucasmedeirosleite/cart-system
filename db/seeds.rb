# frozen_string_literal: true

# This file should contain all the record creation needed
# to seed the database with its default values.
# The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'João',
            email: 'joao@example.com',
            password: 'password',
            password_confirmation: 'password')

User.create(name: 'Diogo',
            email: 'diogo@example.com',
            password: 'password',
            password_confirmation: 'password')

Product.find_or_create_by(name: 'Learn RoR - Beginner', price: 24.99)
Product.find_or_create_by(name: 'Mastering RoR - Level over 9000', price: 9001.0)
