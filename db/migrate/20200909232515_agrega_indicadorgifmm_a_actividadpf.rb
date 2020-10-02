class AgregaIndicadorgifmmAActividadpf < ActiveRecord::Migration[6.0]
  def change
    add_column :cor1440_gen_actividadpf, :indicadorgifmm_id, :integer
    add_foreign_key :cor1440_gen_actividadpf, :indicadorgifmm, column: :indicadorgifmm_id
  end
end
