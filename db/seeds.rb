# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creating sample data for RainCRM..."

# Create admin user
admin = User.find_or_create_by!(email: 'admin@raincrm.com') do |user|
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.role = 'admin'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.phone = '555-0100'
end

# Create loan officers
loan_officer1 = User.find_or_create_by!(email: 'john@raincrm.com') do |user|
  user.first_name = 'John'
  user.last_name = 'Smith'
  user.role = 'loan_officer'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.phone = '555-0101'
end

loan_officer2 = User.find_or_create_by!(email: 'jane@raincrm.com') do |user|
  user.first_name = 'Jane'
  user.last_name = 'Doe'
  user.role = 'loan_officer'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.phone = '555-0102'
end

# Create contacts
contact1 = Contact.find_or_create_by!(email: 'client1@example.com', user: loan_officer1) do |contact|
  contact.first_name = 'Michael'
  contact.last_name = 'Johnson'
  contact.phone = '555-1001'
  contact.address = '123 Main St, Anytown, CA 90210'
  contact.contact_type = 'lead'
  contact.notes = 'First-time homebuyer, pre-qualified for $400k'
end

contact2 = Contact.find_or_create_by!(email: 'client2@example.com', user: loan_officer1) do |contact|
  contact.first_name = 'Sarah'
  contact.last_name = 'Wilson'
  contact.phone = '555-1002'
  contact.address = '456 Oak Ave, Somewhere, CA 90211'
  contact.contact_type = 'borrower'
  contact.notes = 'Refinancing existing mortgage'
end

contact3 = Contact.find_or_create_by!(email: 'client3@example.com', user: loan_officer2) do |contact|
  contact.first_name = 'Robert'
  contact.last_name = 'Davis'
  contact.phone = '555-1003'
  contact.address = '789 Pine St, Elsewhere, CA 90212'
  contact.contact_type = 'buyer'
  contact.notes = 'Looking to upgrade from current home'
end

# Create deals
deal1 = Deal.find_or_create_by!(title: 'Johnson Purchase - 123 Main St', contact: contact1, loan_officer: loan_officer1) do |deal|
  deal.deal_type = 'purchase'
  deal.status = 'pre_approval'
  deal.purchase_price = 450000
  deal.loan_amount = 360000
  deal.estimated_close_date = 45.days.from_now
  deal.notes = 'Conventional loan, 20% down payment'
end

deal2 = Deal.find_or_create_by!(title: 'Wilson Refinance', contact: contact2, loan_officer: loan_officer1) do |deal|
  deal.deal_type = 'refinance'
  deal.status = 'under_contract'
  deal.purchase_price = 500000
  deal.loan_amount = 400000
  deal.estimated_close_date = 21.days.from_now
  deal.notes = 'Rate and term refinance, cash-out option'
end

deal3 = Deal.find_or_create_by!(title: 'Davis Purchase - 789 Pine St', contact: contact3, loan_officer: loan_officer2) do |deal|
  deal.deal_type = 'purchase'
  deal.status = 'lead'
  deal.purchase_price = 650000
  deal.loan_amount = 520000
  deal.estimated_close_date = 60.days.from_now
  deal.notes = 'FHA loan, first-time buyer program'
end

# Create some messages
Message.find_or_create_by!(deal: deal1, user: loan_officer1, content: 'Initial contact made with client', message_type: 'status_update')
Message.find_or_create_by!(deal: deal1, user: loan_officer1, content: 'Pre-approval letter issued', message_type: 'status_update')
Message.find_or_create_by!(deal: deal2, user: loan_officer1, content: 'Appraisal ordered', message_type: 'note')
Message.find_or_create_by!(deal: deal3, user: loan_officer2, content: 'Initial consultation scheduled', message_type: 'note')

puts "Sample data created successfully!"
puts "Admin login: admin@raincrm.com / password123"
puts "Loan Officer 1: john@raincrm.com / password123"
puts "Loan Officer 2: jane@raincrm.com / password123"
