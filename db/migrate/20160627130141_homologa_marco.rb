class HomologaMarco < ActiveRecord::Migration
  def up
    add_column :sivel2_gen_acto, :categoriaant_id, :integer
    execute <<-SQL
    UPDATE sivel2_gen_acto SET categoriaant_id=id_categoria;
    SQL
    hom={
      3000 => [10, 20, 30, 40, 50, 701, 703, 87, 97],
      3001 => [16, 26, 37, 46, 57],
      3002 => [15, 25, 35, 45, 55, 73, 10002, 10026],
      3502 => [18, 28, 38, 49, 59, 706],
      3003 => [12, 22, 36, 47, 56, 72],
      3004 => [13, 23, 33, 43, 53, 702, 704, 88, 98],
      3005 => [19, 195, 196, 29, 295, 296, 39, 395, 396, 420, 
                425, 426, 520, 525, 526, 77, 775, 776, 10020,
                191, 192, 193, 194, 197, 291, 292, 293, 294, 
                297, 391, 392, 393, 394, 397, 421, 422, 423, 
                424, 425, 426, 427, 520, 521, 522, 523, 524, 
                525, 526, 527, 77, 771, 772, 773, 774, 775, 776, 777],
      3006 => [11, 21, 302, 58, 79, 48],
      3007 => [14, 24, 301],
      3008 => [101],
      3509 => [102, 401, 501, 902, 903],
      3511 => [104, 906, 10025],
      3012 => [41],
      3013 => [74],
      3514 => [64, 92, 93, 10006],
      3515 => [95],
      3516 => [707, 708, 709],
      3517 => [80, 84, 85, 86],
      3518 => [66, 89, 801],
      3519 => [78, 904],
      3020 => [75, 10021],
      3522 => [63, 65, 90, 10003],
      3523 => [62, 10007],
      3524 => [68],
      3525 => [67],
      3526 => [69],
      3527 => [10011],
      3528 => [10013],
      3529 => [10014],
      3530 => [10015],
      3531 => [10017, 10018, 10019]
    }
    cub = [];
    hom.each do |l, v|
      cub<<v
    end
    execute <<-SQL
      SELECT id, nombre from sivel2_gen_categoria WHERE id NOT IN (#{cub.join(", ")}) AND (id<2000 OR id>4000) ORDER BY id;
    SQL
    hom.each do |l,v|
      execute <<-SQL
        UPDATE sivel2_gen_acto SET id_categoria='#{l}'  
          WHERE id_categoria IN (#{v.join(", ")});
      SQL
    end
  end 

  def down
    execute <<-SQL
    UPDATE sivel2_gen_acto SET id_categoria=categoriaant_id;
    SQL
    remove_column :sivel2_gen_acto, :categoriaant_id
  end
end
