class AddAttendedEventRefToEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :attended_event, references: :events, null: false, index: true
    add_foreign_key :reservations, :events, column: :attended_event_id
  end
end