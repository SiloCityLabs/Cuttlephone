{% for material in site.data.case_materials %}
{% for filetypes in site.data.filetypes %}

{% if material.material == "hard" and model[1].build_hard == "true" %}
<label>{{type.model_type}} (hard case):</label>
<a href="{{ model[0] }} {{ type.model_type}} {{ material.material}}.{{filetypes.filetype}}">
 {{filetypes.filetype}} file
</a>
{% endif %}

{% if material.material == "soft" and model[1].build_soft == "true" %}
<label>{{type.model_type}} (soft case):</label>
<a href="{{ model[0] }} {{ type.model_type}} {{ material.material}}.{{filetypes.filetype}}">
 {{filetypes.filetype}} file
</a>
{% endif %}

{% endfor %}
{% endfor %}