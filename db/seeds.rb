Driver.create!([
  {email: "ouskebe@hotmail.com", encrypted_password: "$2a$11$7frlLKW1GVJqnZXHkFKq1.8rG.qpmCarI8cXTj0p7u6Jk.gfjAom2", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 9, current_sign_in_at: "2017-07-19 01:00:05", last_sign_in_at: "2017-07-18 18:56:32", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "Jeff", last_name: "Gordon", active: true, phone_number: "6145645454"}
])
AdminUser.create!([
  {email: "admin@example.com", encrypted_password: "$2a$11$T.ebStp.lv5eOBIArnvd8eKYhWEKNIwQmrhdcgsySs1CldWoAAS2u", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-06-11 10:25:48", last_sign_in_at: "2017-06-11 10:25:48", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}
])
Client.create!([
  {first_name: "Betty", last_name: "Crocker", medicaid_number: "232355", address: "123 main st columbus oh ", site: "", disability: true, route_id: 1},
  {first_name: "Jimmy", last_name: "John", medicaid_number: "23523235", address: "352 first ave", site: "", disability: false, route_id: 1},
  {first_name: "Flip", last_name: "Flop", medicaid_number: "3466346", address: "235 main pl", site: "", disability: true, route_id: 2},
  {first_name: "Zig", last_name: "Zag", medicaid_number: "236754", address: "235 fair blvd", site: "", disability: false, route_id: 2},
  {first_name: "Uncle", last_name: "Ben", medicaid_number: "4587454", address: "563 4th avenue", site: "", disability: true, route_id: 1},
  {first_name: "Sam", last_name: "Simpson", medicaid_number: "74574747", address: "235 6th ave", site: "", disability: false, route_id: 1},
  {first_name: "Barbara", last_name: "Washington", medicaid_number: "75643434", address: "34545 main st", site: "", disability: true, route_id: 1},
  {first_name: "Tic", last_name: "Tac", medicaid_number: "56834354", address: "946 anystreet dr", site: "", disability: false, route_id: 2},
  {first_name: "john", last_name: "doe", medicaid_number: "", address: "234 main st", site: "", disability: true, route_id: 2}
])
Route.create!([
  {name: "Grove City"},
  {name: "Bexley"}
])
