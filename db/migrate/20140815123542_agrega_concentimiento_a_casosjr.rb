class AgregaConcentimientoACasosjr < ActiveRecord::Migration
  def change
    add_column :casosjr, :concentimientosjr, :bool
    add_column :casosjr, :concentimientobd, :bool
  end
end
