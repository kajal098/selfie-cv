class CreateGraphapis < ActiveRecord::Migration
  def change
    create_table :graphapis do |t|
      t.string :api_id
      t.string :symbol
      t.string :index
      t.string :lasttradetime
      t.string :lasttradedatetime
      t.string :lasttradetimelong
      t.string :change
      t.string :changePercent
      t.string :previouscloseprice
      t.timestamps null: false
    end
  end
end
