---
layout: default
tle: "Premade Models"
permalink: /premade-models/
---

# Premade models
3MF files are made for all versions of a phone

<ul>
{% for model in site.data.phone_case.parameterSets %}
    <!--<li><a href="{{ item.filename }}">{{ item.title }}</a></li>-->
    <li>key-name : {{ model[0] }} , value : {{ model[1] }}</li>
{% endfor %}
</ul>

<ul>
{% for item in site.data.premade_models %}
    <li><a href="{{ item.filename }}">{{ item.title }}</a></li>
{% endfor %}
</ul>