
valida:
	coffee -o /tmp/ ../sivel2_gen/app/assets/javascripts/sivel2_gen/*.js.coffee
	coffee -o /tmp/ ../sivel2_sjr/app/assets/javascripts/sivel2_sjr/*.js.coffee
	find . -name "*js.coffee" | xargs coffee -o /tmp/
