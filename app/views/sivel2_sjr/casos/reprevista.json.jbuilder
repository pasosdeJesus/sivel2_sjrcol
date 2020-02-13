# frozen_string_literal: true

@conscaso.each do |conscaso|
  caso= conscaso.caso
  json.partial! 'sivel2_sjr/casos/basicos', caso: caso
end
