class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :medical_record_num
      t.string :en_pid
      t.string :birth_date
      t.string :gender
      t.string :race
      t.string :ethnicity
      t.string :consent_date

      t.timestamps
    end
  end
end
