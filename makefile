check:
	tl build -p

build:
	tl build

run: build
	love app
