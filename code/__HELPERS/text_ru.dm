// Here there are processes designed to work with the Cyrillic alphabet.
// In particular, most of the code that fixes the "�" is right there.



/proc/strip_macros(t)
	t = replacetext(t, "\proper", "")
	t = replacetext(t, "\improper", "")
	return t

/proc/sanitize_russian(t)
	t = strip_macros(t)
	return replacetext(t, "�", "&#x044f;")

/proc/russian_html2text(t)
	return replacetext(t, "&#x044f;", "&#255;")

/proc/russian_text2html(t)
	return replacetext(t, "&#255;", "&#x044f;")

/proc/rhtml_encode(t)
	t = rhtml_decode(t)
	t = strip_macros(t)
	var/list/c = splittext(t, "�")
	if(c.len == 1)
		return html_encode(t)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += "&#x044f;"
		first = 0
		out += html_encode(text)
	return out

/proc/rhtml_decode(var/t)
	t = replacetext(t, "&#x044f;", "�")
	t = replacetext(t, "&#255;", "�")
	t = html_decode(t)
	return t


/proc/char_split(t)
	. = list()
	for(var/x in 1 to length(t))
		. += copytext(t,x,x+1)

/proc/ruscapitalize(t)
	var/s = 2
	if (copytext(t,1,2) == ";")
		s += 1
	else if (copytext(t,1,2) == ":")
		if(copytext(t,3,4) == " ")
			s+=3
		else
			s+=2
	return r_uppertext(copytext(t, 1, s)) + copytext(t, s)

/proc/r_uppertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 223)
			t += ascii2text(a - 32)
		else if (a == 184)
			t += ascii2text(168)
		else t += ascii2text(a)
	return uppertext(t)

/proc/r_lowertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a > 191 && a < 224)
			t += ascii2text(a + 32)
		else if (a == 168)
			t += ascii2text(184)
		else t += ascii2text(a)
	return lowertext(t)

/proc/pointization(text)
	if (!text)
		return
	if (copytext(text,1,2) == "*") //Emotes allowed.
		return text
	if (copytext(text,-1) in list("!", "?", "."))
		return text
	text += "."
	return text

/proc/intonation(text)
	if (copytext(text,-1) == "!")
		text = "<b>[text]</b>"
	return text


GLOBAL_LIST_INIT(rus_unicode_conversion,list(
	"�" = "0410", "�" = "0430",
	"�" = "0411", "�" = "0431",
	"�" = "0412", "�" = "0432",
	"�" = "0413", "�" = "0433",
	"�" = "0414", "�" = "0434",
	"�" = "0415", "�" = "0435",
	"�" = "0416", "�" = "0436",
	"�" = "0417", "�" = "0437",
	"�" = "0418", "�" = "0438",
	"�" = "0419", "�" = "0439",
	"�" = "041a", "�" = "043a",
	"�" = "041b", "�" = "043b",
	"�" = "041c", "�" = "043c",
	"�" = "041d", "�" = "043d",
	"�" = "041e", "�" = "043e",
	"�" = "041f", "�" = "043f",
	"�" = "0420", "�" = "0440",
	"�" = "0421", "�" = "0441",
	"�" = "0422", "�" = "0442",
	"�" = "0423", "�" = "0443",
	"�" = "0424", "�" = "0444",
	"�" = "0425", "�" = "0445",
	"�" = "0426", "�" = "0446",
	"�" = "0427", "�" = "0447",
	"�" = "0428", "�" = "0448",
	"�" = "0429", "�" = "0449",
	"�" = "042a", "�" = "044a",
	"�" = "042b", "�" = "044b",
	"�" = "042c", "�" = "044c",
	"�" = "042d", "�" = "044d",
	"�" = "042e", "�" = "044e",
	"�" = "042f", "�" = "044f",

	"�" = "0401", "�" = "0451"
	))

GLOBAL_LIST_INIT(rus_unicode_fix,null)

/proc/r_text2unicode(text)
	text = strip_macros(text)
	text = russian_text2html(text)

	for(var/s in GLOB.rus_unicode_conversion)
		text = replacetext(text, s, "&#x[GLOB.rus_unicode_conversion[s]];")

	return text

/proc/r_text2ascii(t)
	t = replacetext(t, "&#x044f;", "�")
	t = replacetext(t, "&#255;", "�")
	var/output = ""
	var/L = length(t)
	for(var/i = 1 to L)
		output += "&#[text2ascii(t,i)];"
	return output

/proc/sanitize_russian_list(list)
	for(var/i in list)
		if(islist(i))
			sanitize_russian_list(i)

		if(list[i])
			if(istext(list[i]))
				list[i] = sanitize_russian(list[i])
			else if(islist(list[i]))
				sanitize_russian_list(list[i])


/proc/r_json_encode(json_data)
	if(!GLOB.rus_unicode_fix)
		GLOB.rus_unicode_fix = list()
		for(var/s in GLOB.rus_unicode_conversion)
			if(s == "�")
				GLOB.rus_unicode_fix["&#x044f;"] = "\\u[GLOB.rus_unicode_conversion[s]]"
				continue

			GLOB.rus_unicode_fix[copytext(json_encode(s), 2, -1)] = "\\u[GLOB.rus_unicode_conversion[s]]"

	sanitize_russian_list(json_data)
	var/json = json_encode(json_data)

	for(var/s in GLOB.rus_unicode_fix)
		json = replacetext(json, s, GLOB.rus_unicode_fix[s])

	return json