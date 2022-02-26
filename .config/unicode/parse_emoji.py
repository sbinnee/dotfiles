from bs4 import BeautifulSoup

fn = './emoji.html'
with open(fn) as f:
    soup = BeautifulSoup(f)
print(soup.title)

table = soup.find('table')
print("#Table:", len(table))

all_tr = table.find_all('tr')


def _fkey_emoji_entry(tr):
    try:
        td = tr.find('td')
        s = td.string
        return int(s)
    except:
        return False

_all_emoji_tr = filter(_fkey_emoji_entry, all_tr)
all_emoji_tr = list(_all_emoji_tr)
print("#Filtered entires:", len(all_emoji_tr))


def parse_emoji(emoji_tr):
    def _off_span(d):
        if isinstance(d, str):
            return d
        return d.string

    t_img = emoji_tr.find('img')
    emoji = t_img['alt']
    code, _ = t_img['title'].split(emoji)

    desc = [td.contents for td in emoji_tr.find_all('td') if td['class'][0] == 'name']
    # print(desc)
    desc_main = desc[0][0]  # always 1 element
    # sometimes have span in it
    desc_alt = ''.join(_off_span(d[0]) for d in desc[1:])
    # desc_alt = [d for d in desc[1:] if isinstance(d, str) else ]
    # print(desc_alt)
    return emoji + ' ' + desc_main + '; ' + desc_alt + '; ' + code.strip()


parsed = [parse_emoji(e) for e in all_emoji_tr]

with open('./emoji', 'w') as f:
    f.writelines([line + '\n' for line in parsed])
