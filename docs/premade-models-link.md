<tr>
<td>{{ type.model_type }}</td>
{%- for material in site.data.case_materials -%}
<td>
<!-- loop through materials -->
{%- assign can_build = false -%}
{%- if material.material == "hard" and model[1].build_hard == "true" -%}{%- assign can_build = true -%}{%- endif -%}
{%- if material.material == "soft" and model[1].build_soft == "true" -%}{%- assign can_build = true -%}{%- endif -%}
{%- if can_build -%}
{%- for filetypes in site.data.filetypes -%}
{%- capture filename %}{{ model[0] }} {{ type.model_type }} {{ material.material }}.{{ filetypes.filetype }}{% endcapture -%}
<!-- github-safe file names -->
{%- assign filename = filename | strip | replace: " ", "_" | replace: "+", "plus" -%}
<a href="{{ site.release_download_url }}{{ filename }}">{{ filetypes.filetype }}</a>
{%- endfor -%}
{%- endif -%}
</td>
{%- endfor -%}
</tr>
