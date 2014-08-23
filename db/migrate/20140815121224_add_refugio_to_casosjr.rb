class AddRefugioToCasosjr < ActiveRecord::Migration
  def change
    add_column :casosjr, :fechasalida, :date
    add_column :casosjr, :id_salida, :integer
    add_column :casosjr, :fechallegada, :date
    add_column :casosjr, :id_llegada, :integer
    add_column :casosjr, :categoriaref, :integer
    add_column :casosjr, :observacionesref, :string, limit: 5000

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE casosjr ADD CONSTRAINT casosjr_id_salida_fkey
            FOREIGN KEY (id_salida) REFERENCES ubicacion(id);
          ALTER TABLE casosjr ADD CONSTRAINT casosjr_id_llegada_fkey
            FOREIGN KEY (id_llegada) REFERENCES ubicacion(id);
          ALTER TABLE casosjr ADD CONSTRAINT casosjr_categoriaref_fkey
            FOREIGN KEY (categoriaref) REFERENCES categoria(id);
        SQL
      end
      dir.down do
      end
    end
  end
end
