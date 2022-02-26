all: update emoji

update:
	wget -N https://www.unicode.org/emoji/charts/emoji-list.html
	sed "s#src='.*'##g" emoji-list.html > emoji.html

emoji:
	python parse_emoji.py

clean:
	rm -f emoji-list.html emoji.html

.PHONY: all update emoji
