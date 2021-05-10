# Saca copia de respaldo de volcado de base, anexos y nube
# La deja en carpeta Respaldos de la nube
# Para el cifrado y compresión usa 7z
# Como clave de cifrado usa la que tenga mayor id de la tabla
# sip_claverespaldo

d=Date.today.day

if !ENV['HEB412_RUTA']
  puts "Falta variable de enterno HEB412_RUTA"
  exit 1
end
nube=ENV['HEB412_RUTA']

if !ENV['RUTA_ANEXOS']
  puts "Falta variable de enterno RUTA_ANEXOS"
  exit 1
end
anexos=ENV['RUTA_ANEXOS']

if !ENV['RUTA_VOLCADOS']
  puts "Falta variable de enterno RUTA_VOLCADOS"
  exit 1
end
volcados=ENV['RUTA_VOLCADOS']


# https://stackoverflow.com/questions/690151/getting-output-of-system-calls-in-ruby
def syscall(*cmd)
  begin
    stdout, stderr, status = Open3.capture3(*cmd)
    status.success? && stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
    puts stdout
    puts stderr
    puts status
  rescue
  end
end


#sql="/var/www/htdocs/sivel2_sjrcol/archivos/bd"
#anexos="/var/www/htdocs/sivel2_sjrcol/archivos/anexos"
#"/var/www/htdocs/sivel2_sjrcol/public/heb412"

salida="#{nube}/Respaldos/si_jrscol-#{d}.7z"
# Ojo mejor que la clave no tenga caracteres por escapar que podrían 
# resultar diferentes en otros sistemas operativos al comprimir.
# Mejor asegurar que se compone solo de letras y números
if Sip::Claverespaldo.count == 0
  clave='lalocura'  #;
else
  clave=Sip::Claverespaldo.order(:id).last.clave
end


orden="doas 7z a -p#{clave} #{salida} #{volcados} #{anexos} #{nube} '-x!heb412/Respaldos'"
puts "Ejecutando #{orden}"

puts "Eliminando #{salida}"
syscall('doas', 'rm', '-f', salida)
#puts "Comprimiendo en #{salida}"
syscall('doas', '7z', 'a', "-p#{clave}", salida, 
        volcados, anexos, nube, "-x!heb412/Respaldos")
#puts "Comprimiendo menos en #{salida}"
#syscall('doas', '7z', 'a', "-p#{clave}", salida, nube, "-x!heb412/Respaldos")
