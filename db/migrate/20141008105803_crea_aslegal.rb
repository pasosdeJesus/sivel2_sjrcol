class CreaAslegal < ActiveRecord::Migration
  def up
    execute <<-SQL
CREATE SEQUENCE aslegal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE aslegal (
	  id INTEGER PRIMARY KEY DEFAULT nextval('aslegal_seq'),
    nombre character varying(100) NOT NULL,
    fechacreacion date DEFAULT ('now'::text)::date NOT NULL,
    fechadeshabilitacion date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT aslegal_check CHECK (((fechadeshabilitacion IS NULL) OR (fechadeshabilitacion >= fechacreacion)))
);

CREATE TABLE aslegal_respuesta (
    id_respuesta integer NOT NULL,
    id_aslegal integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
	  PRIMARY KEY (id_respuesta, id_aslegal)
);
    SQL
  end
  def down
    drop_table :aslegal_respuesta
    drop_table :aslegal
    execute "DROP SEQUENCE aslegal_seq"
  end
end
