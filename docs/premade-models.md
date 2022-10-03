---
layout: default
title: "Premade Models"
permalink: /premade-models/
---

# Premade models
3MF files are made for all versions of a phone. {% for material in site.data.case_materials %} For {{ material.material }} print with {{material.example}}. {% endfor %}

<!-- loop through phone_case.json, copied over from build script -->
{% for model in site.data.phone_case.parameterSets %}
<!-- if I indent then Jekyll wraps it in a code block -->
## {{ model[0] }} 
{% for type in site.data.model_types %}

<!-- hide gamepad. It's not ready -->
{% if type.model_type != "gamepad" %}

<label>{{type.model_type}}:</label>
{% for material in site.data.case_materials %}
{% for filetypes in site.data.filetypes %}

<!-- test -->
{{model[1]|inspect}}
{% if model[1].case_type == "phone case" and model[1].build_phone == "true" %}
blah blah
{% endif %}

<a href="{{ model[0] }} {{ type.model_type}} {{ material.material}}.{{filetypes.filetype}}">{{ material.material}}  {{filetypes.filetype}} file</a>
{% endfor %}

{% endfor %}
{% endif %}

{% endfor %}
{% endfor %}
