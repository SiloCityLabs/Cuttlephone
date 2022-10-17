---
layout: default
title: "Premade Models"
permalink: /premade-models/
---

# Premade models
3MF files are made for all versions of a phone. {% for material in site.data.case_materials %} For {{ material.material }} print with {{material.example}}. {% endfor %}

<!-- loop through phone_case.json, copied over from build script -->
{% for model in site.data.phone_case.parameterSets %}
{% if model[1].in_development != "true" %}
## {{ model[0] }} 

<!-- for each case type (phone, joycon, junglecat) -->
{% for type in site.data.model_types %}

<!-- this is dumb but I don't know better conditionals in Jekyll/Liquid -->
{% if type.model_type == "phone case" and model[1].build_phone == "true" %}
{% include_relative premade-models-link.md %}
{% elsif type.model_type == "joycon" and model[1].build_joycon == "true" %}
{% include_relative premade-models-link.md %}
{% elsif type.model_type == "junglecat" and model[1].build_junglecat == "true" %}
{% include_relative premade-models-link.md %}
{% endif %}

{% endfor %}

{% endif %}
{% endfor %}
