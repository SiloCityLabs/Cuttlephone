---
layout: default
title: "Premade Models"
permalink: /premade-models/
---

# Premade models
3MF files are made for all versions of a phone

<!-- loop through phone_case.json, copied over from build script -->
{% for model in site.data.phone_case.parameterSets %}
<!-- if I indent then Jekyll wraps it in a code block -->
## {{ model[0] }}
{% for type in site.data.model_types %}

<label>{{type.model_type}}:</label>
{% for material in site.data.case_materials %}
{% for filetypes in site.data.filetypes %}
<a href="/premade_models/{{ model[0] }} {{ type.model_type}} {{ material.material}}.{{filetypes.filetype}}">{{ material.material}} ({{material.example}}) {{filetypes.filetype}}</a>
{% endfor %}

{% endfor %}
{% endfor %}
{% endfor %}
