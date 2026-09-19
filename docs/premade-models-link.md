<tr>
<td>{{ type.model_type }}</td>
{%- for material in site.data.case_materials -%}
<td>
<!-- loop through materials -->
<!-- Liquid has no real booleans; assign false becomes the truthy string "false" -->
{%- assign can_build = "" -%}
{%- if material.material == "hard" and model[1].build_hard == "true" -%}{%- assign can_build = "yes" -%}{%- endif -%}
{%- if material.material == "soft" and model[1].build_soft == "true" -%}{%- assign can_build = "yes" -%}{%- endif -%}
{%- if can_build == "yes" -%}
{%- capture filename %}{{ model[0] }} {{ type.model_type }} {{ material.material }}.3mf{% endcapture -%}
<!-- github-safe file names -->
{%- assign filename = filename | strip | replace: " ", "_" | replace: "+", "plus" -%}
<a class="model-link" href="{{ site.release_download_url }}{{ filename }}">Download 3MF</a>
<br>
<a class="model-link" href="{{ '/models/preview/' | relative_url }}?model={{ filename | url_encode }}{% if model[1].rotate_upright == "true" %}&rotate_upright=true{% endif %}">Preview</a>
{%- endif -%}
</td>
{%- endfor -%}
</tr>
