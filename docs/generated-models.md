---
layout: default
title: "Generated Models"
permalink: /models/generated-models/
parent: 3D Models
---

# Generated models
Below you'll find models of every available phone case with every available variation. I generate a new batch with each significant revision of the program. {% for material in site.data.case_materials %} For {{ material.material }} print with {{material.example}}. {% endfor %}. Read the [print guide](/guides/print-guide/)

<!-- loop through phone_case.json, copied over from build script -->
{% for model in site.data.phone_case.parameterSets %}
{% if model[1].in_development != "true" %}
## {{ model[0] }} 

<!-- for each case type (phone, joycon, junglecat) -->
{% for type in site.data.model_types %}

<!-- this is dumb but I don't know better conditionals in Jekyll/Liquid -->
<!-- https://shopify.github.io/liquid/basics/operators/ -->
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
