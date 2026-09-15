---
layout: default
title: "Generated Models"
permalink: /models/generated-models/
parent: 3D Models
---

# Generated models
Below you'll find models of every available phone case with every available variation. I generate a new batch with each significant revision of the program. 

Models are from the [latest release]({{ site.github.repository_url }}/releases/latest).

{% for material in site.data.case_materials %} For {{ material.material }} cases, print with {{material.example}}. {% endfor %} Read the [3D printing guide](/guides/print-guide/) for more tips.

<!-- loop through phone_case.json -->
{% for model in site.data.phone_case.parameterSets %}
{% if model[1].in_development != "true" %}
<!-- hide models that don't have build output -->
{% assign any_built = false %}
{% for type in site.data.model_types %}
{% if type.build_key %}
{% assign build_flag = model[1][type.build_key] %}
{% if build_flag == "true" %}{% assign any_built = true %}{% endif %}
{% endif %}
{% endfor %}
{% if any_built %}
## {{ model[0] }}

<table>
<thead>
<tr>
<th>Type</th>
{% for material in site.data.case_materials %}
{% assign mat_built = false %}
{% if material.material == "hard" and model[1].build_hard == "true" %}{% assign mat_built = true %}{% endif %}
{% if material.material == "soft" and model[1].build_soft == "true" %}{% assign mat_built = true %}{% endif %}
<!-- muted text if no build output-->
<th{% unless mat_built %} style="opacity:0.45;font-weight:500"{% endunless %}>{{ material.material | capitalize }} ({{ material.example }})</th>
{% endfor %}
</tr>
</thead>
<tbody>
{% for type in site.data.model_types %}
{% if type.build_key %}
{% assign build_flag = model[1][type.build_key] %}
{% if build_flag == "true" %}
{% include_relative premade-models-link.md %}
{% endif %}
{% endif %}
{% endfor %}
</tbody>
</table>
{% endif %}
{% endif %}
{% endfor %}
