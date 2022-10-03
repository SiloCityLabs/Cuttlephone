<label>{{type.model_type}}:</label>

{% for material in site.data.case_materials %}
{% for filetypes in site.data.filetypes %}
<a href="{{ model[0] }} {{ type.model_type}} {{ material.material}}.{{filetypes.filetype}}">
{{ material.material}}  {{filetypes.filetype}} file
</a>
{% endfor %}
{% endfor %}