class AddAttendeeRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :attendee, references: :users, null: false, index: true
    add_foreign_key :reservations, :users, column: :attendee_id
  end
end