class EliminaDerechoDeTablas < ActiveRecord::Migration
  def change
    remove_column :sivel2_sjr_ayudaestado, :derecho_id, :integer
    remove_column :sivel2_sjr_ayudasjr, :derecho_id, :integer
    remove_column :sivel2_sjr_motivosjr, :derecho_id, :integer
    remove_column :sivel2_sjr_progestado, :derecho_id, :integer
  end
end
