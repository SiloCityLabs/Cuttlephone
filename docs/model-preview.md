---
layout: default
title: "3D Preview"
permalink: /models/preview/
parent: 3D Models
nav_order: 3
---

# 3D Preview

[**<--** Generated models]({{ '/models/generated-models/' | relative_url }})

<style>
  #model-preview {
    width: 100%;
    margin: 1rem 0 0.5rem;
  }
  #model-preview canvas {
    display: block;
    width: 100%;
    border: 1px solid rgba(0, 0, 0, 0.12);
    border-radius: 4px;
    touch-action: none;
  }
  #model-preview-status {
    margin: 0.5rem 0 0;
    font-size: 0.9rem;
    color: #555;
  }
</style>

<div
  id="model-preview"
  data-assets-base="{{ '/assets/3mf/' | relative_url }}"
  data-default-model="Pixel_3_phone_case_hard.3mf"
>
  <p id="model-preview-status">Loading ...</p>
</div>

<p id="model-preview-download" hidden>
  <a href="#">Download this 3MF</a>
</p>

<script type="importmap">
{
  "imports": {
    "three": "https://cdn.jsdelivr.net/npm/three@0.170.0/build/three.module.js",
    "three/addons/": "https://cdn.jsdelivr.net/npm/three@0.170.0/examples/jsm/"
  }
}
</script>
<script type="module" src="{{ '/assets/js/model-preview.js' | relative_url }}"></script>
