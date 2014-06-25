

all:
	@echo make init: install
	@echo make run: run server
	@echo make tests: run test

init:
	@npm install --silent

run:
	@coffee src/api.coffee

tests:
	@./node_modules/.bin/coffeelint -f coffeelint.json ./src ./test
	@mocha --compilers coffee:coffee-script/register --reporter spec ./test
